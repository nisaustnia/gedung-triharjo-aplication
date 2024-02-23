import {
  CheckDateData,
  EventModelData,
} from "../../../model/Databases.model.js";
import { pemesananInput } from "../../middleware/pemesanan.input.js";
import { decryptJwt } from "../../utils/decryptJwt.utils.js";
import dotenv from "dotenv";
import axios from "axios";
import { Users } from "../../../model/Users.model.js";
import cancelMidtransTransUtils from "../../utils/cancelmidtranstrans.utils.js";
import { pengecekanInput } from "../../middleware/pengecekan.input.js";
import { Notification } from "../../../model/Notification.model.js";
import formatedDate from "../../utils/formatedDate.utils.js";

dotenv.config({ path: "../../../../.env" });

// Lakukan permintaan HTTP dengan Axios
async function makePayment(paymentType, transactionDetails, customerDetail) {
  try {
    const serverKey = process.env.SERVERKEY;
    // Buat Authorization Header
    const authString = `${serverKey}:`;
    const base64AuthString = Buffer.from(authString).toString("base64");
    const { bookingCode, totalPembayaran } = transactionDetails;
    const { email, nama, noTelp } = customerDetail;
    const bodyData = {
      payment_type: !(paymentType == "gopay" || paymentType == "shopeepay")
        ? "bank_transfer"
        : paymentType,
      transaction_details: {
        gross_amount: totalPembayaran,
        order_id: bookingCode,
      },
      customer_details: {
        email: email,
        first_name: nama,
        last_name: "",
        phone: noTelp,
      },
      bank_transfer: !(paymentType == "gopay" || paymentType == "shopeepay")
        ? {
            bank: paymentType,
          }
        : undefined,
      shopeepay:
        paymentType == "shopeepay"
          ? {
              callback_url: "https://localhost",
            }
          : undefined,
    };
    const result = await axios.post(
      "https://api.sandbox.midtrans.com/v2/charge",
      bodyData,
      {
        headers: {
          Authorization: `Basic ${base64AuthString}`,
          Accept: "application/json",
          "Content-Type": "application/json",
        },
      }
    );
    return result.data;
  } catch (error) {
    throw new Error(error);
  }
}

async function hooksForPayment(data, waktu, jumlahPerulangan) {
  for (let i = 0; i < jumlahPerulangan; i++) {
    const pembayaran = await makePayment(
      data.paymentType,
      data.dataForMidtrans,
      data.datas
    );
    if (pembayaran.status_code === "201") {
      const dataPembayaran = {
        bookingCode: pembayaran.order_id,
        tipePembayaran: data.paymentType,
        totalPembayaran: pembayaran.gross_amount,
        va_number: pembayaran.va_numbers["0"].va_number,
        actions: pembayaran.actions,
        expiry_time: pembayaran.expiry_time,
      };
      await EventModelData.pemesanan(
        data.idUser,
        data.idEvent,
        data.tablePemesanan,
        pembayaran.order_id,
        JSON.stringify(dataPembayaran)
      );
      Notification.insertData(
        0,
        `terdapat pesanan baru dengan code booking ${pembayaran.order_id} yang belum dibayar`,
        pembayaran.order_id
      );
      // Pembayaran berhasil, keluar dari loop
      break;
    } else {
      // Pembayaran gagal, tunggu selama 'waktu' sebelum mencoba lagi
      await new Promise((resolve) => setTimeout(resolve, waktu));
    }
  }
}

export const pemesananControllerEvent = {
  async checkTanggal(request, h) {
    try {
      const token = request.headers.authorization.split(" ")[1];
      const datas = await decryptJwt.decryptAccessToken(token);
      const { idEvent } = request.params;
      const { result: tipeWaktu } = await EventModelData.getTipeWaktu(idEvent);
      async function getValueTipeWaktu() {
        if (tipeWaktu == "sesi") {
          const { error, value } = await pengecekanInput.sesi(request.payload);
          return { error, value };
        } else if (tipeWaktu == "bulan" || tipeWaktu == null) {
          const { error, value } = await pengecekanInput.bulan(request.payload);
          return { error, value };
        } else if (tipeWaktu == "hari") {
          const { error, value } = await pengecekanInput.hari(request.payload);
          return { error, value };
        } else {
          throw new Error("hmm, something wrong... di input ada yang salah");
        }
      }
      const { error, value } = await getValueTipeWaktu();
      if (error) throw error;
      const { error2, result: result1 } = await EventModelData.getEventById(
        idEvent
      );
      if (error2) throw new Error(error2);
      const dataUntukDicheck = {
        ...value,
        ...result1["0"],
      };
      const result = await EventModelData.checkDataAda(
        idEvent,
        dataUntukDicheck
      );
      const { result: type } = await Users.getUserType(datas.idUser);
      return h
        .response({
          token: "token verified",
          type,
          result: "tanggal bisa dipesan",
        })
        .code(200);
    } catch (error) {
      return h.response({ error: error.message }).code(400);
    }
  },
  async pemesanan(request, h) {
    try {
      const token = request.headers.authorization.split(" ")[1];
      const datas = await decryptJwt.decryptAccessToken(token);
      const { idEvent } = request.params;
      const { result: tipeWaktu, hargas } =
        await EventModelData.getTipeWaktuDanHarga(idEvent);
      async function getValueTipeWaktu() {
        if (tipeWaktu == "sesi") {
          const { error, value } = await pemesananInput.pemesananSesi(
            request.payload
          );
          return { error, value };
        } else if (tipeWaktu == "bulan" || tipeWaktu == null) {
          const { error, value } = await pemesananInput.pemesananBulan(
            request.payload
          );
          return { error, value };
        } else if (tipeWaktu == "hari") {
          const { error, value } = await pemesananInput.pemesananHari(
            request.payload
          );
          return { error, value };
        } else {
          throw new Error("data tidak ada !");
        }
      }
      const { error, value } = await getValueTipeWaktu();
      if (value.tipeHarga == "perorangan") {
        // const isTriharjo = await EventModelData.isWargaTriharjo(datas.idUser);
        if (datas.wargaTriharjo) {
          value.tipeHarga = "triharjo";
        } else {
          value.tipeHarga = "nontriharjo";
        }
      }
      if (error) throw error;
      // const harga = await EventModelData.getHarga(idEvent, value.tipeHarga);
      const harga = hargas[value.tipeHarga];
      const tablePemesanan = {
        time: value.time,
        dateMulai: value.dateMulai,
        jumlahHari: value.jumlahHari,
        totalPembayaran: value.jumlahHari ? harga * value.jumlahHari : harga,
        tipeHarga: value.tipeHarga,
      };
      if (!tablePemesanan.totalPembayaran)
        throw new Error(
          "tidak dibolehkan karena pemesanan tidak valid, tidak ada harga atau pemesanan dengan tipe harga, contoh: tidak ada pemesanan perorangan jika menghasilkan error seperti ini, coba organisasi untuk tipe harga"
        );

      // midtrans
      // data pemesanan butuh { bookingCode, totalPembayaran } = transactionDetails;
      // const { email, nama, noTelp }
      // const { result: dataUser, error: error3 } = await Users.getUser(
      //   datas.idUser
      // ); memakai datas dulu karena terlalu lambat
      // if (error3) throw new Error(error3);
      const timeer = await EventModelData.checkDataAda(idEvent, tablePemesanan);
      // make bookingcode
      const currentDate = new Date();
      const year = currentDate.getFullYear();
      const month = currentDate.getMonth() + 1;
      const day = currentDate.getDate();
      const hours = currentDate.getHours();
      const minutes = currentDate.getMinutes();
      const seconds = currentDate.getSeconds();
      const bookingCode = `${year}${month}${day}${hours}${minutes}${seconds}${datas.idUser}${idEvent}`;
      const dataForMidtrans = {
        ...tablePemesanan,
        bookingCode,
      };

      // hooksForPayment;
      // hooksForPayment(
      //   {
      //     idUser: datas.idUser,
      //     idEvent,
      //     tablePemesanan,
      //     paymentType: value.paymentType,
      //     dataForMidtrans,
      //     datas,
      //   },
      //   200,
      //   7
      // );
      const pembayaran = await makePayment(
        value.paymentType,
        dataForMidtrans,
        datas
      );

      // untuk melihat apakah ada error di midtrans
      if (!(pembayaran.status_code == "201"))
        throw new Error(
          "gagal melakukan pembayaran, status_code " +
            pembayaran.status_code +
            "coba lakukan lagi"
        );
      const dataPembayaran = {
        bookingCode: pembayaran.order_id,
        tipePembayaran: value.paymentType,
        totalPembayaran: pembayaran.gross_amount,
        va_number: pembayaran.va_numbers
          ? pembayaran.va_numbers["0"].va_number
          : pembayaran.permata_va_number,
        actions: pembayaran.actions,
        expiry_time: pembayaran.expiry_time,
      };
      EventModelData.pemesanan(
        datas.idUser,
        idEvent,
        tablePemesanan,
        bookingCode,
        JSON.stringify(dataPembayaran)
      );
      // if (error2) throw error2;

      // const { result: type } = await Users.getUserType(datas.idUser);
      Notification.insertData(
        0,
        `terdapat pesanan baru dengan code booking ${bookingCode} yang belum dibayar`,
        bookingCode
      );
      Notification.insertData(
        datas.idUser,
        `berhasil membuat pesanan dengan code booking ${bookingCode} yang belum dibayar`,
        bookingCode
      );
      return h
        .response({
          token: "token verified",
          result: {
            ...dataPembayaran,
            status: "pending",
          },
          // : {
          //   idPemesanan: result.idPemesanan,
          //   noRekening: "123456789",
          //   totalPembayaran: result.totalPembayaran,
          // },
        })
        .code(200);
    } catch (error) {
      return h.response({ error: error.message }).code(400);
    }
  },
  async payment(request, h) {
    try {
      const token = request.headers.authorization.split(" ")[1];
      const datas = await decryptJwt.decryptAccessToken(token);
      const { result: type } = await Users.getUserType(datas.idUser);
      return h
        .response({
          token: "token verified",
          type,
          result: ["bri", "bca", "mandiri", "bni", "cimb"],
        })
        .code(200);
    } catch (error) {
      return h.response({ error: error.message }).code(400);
    }
  },
  async deletePayment(request, h) {
    try {
      const { bookingCode } = request.params;
      const token = request.headers.authorization.split(" ")[1];
      const datas = await decryptJwt.decryptAccessToken(token);
      const dataResult = await EventModelData.getPaymentByBookingUserId(
        datas.idUser,
        bookingCode
      );
      if (!dataResult.length) {
        throw new Error("data tidak ada");
      }
      // jangan dihapus karena cancelMidtrans mengembalikan nilai maka harus dimasukkan ke variable
      const respMidtrans = await cancelMidtransTransUtils(bookingCode);
      if (!(respMidtrans.data.status_code == "200"))
        throw new Error(respMidtrans.data.status_message);
      await Notification.deleteData(bookingCode);
      await Notification.insertData(
        datas.idUser,
        `pemesanan mu dicancel dengan code booking ${bookingCode}`,
        bookingCode
      );
      await Notification.insertData(
        0,
        `pesanan dengan code booking ${bookingCode} dicancel USER`,
        bookingCode
      );
      const { result: type } = await Users.getUserType(datas.idUser);
      return h
        .response({
          token: "token verified",
          type,
          result: respMidtrans.data,
        })
        .code(200);
    } catch (error) {
      return h.response({ error: error.message }).code(400);
    }
  },
  async getPayment(request, h) {
    try {
      const token = request.headers.authorization.split(" ")[1];
      const datas = await decryptJwt.decryptAccessToken(token);
      const { bookingCode } = request.params;
      const [result] = await EventModelData.getPayment(
        datas.idUser,
        bookingCode
      );

      result.alamat = `DK. ${result.dukuh}, ${result.kelurahan}, ${result.kecamatan}`;
      result.rtrw = `RT ${result.rt}/RW ${result.rw}`;
      result.dukuh = undefined;
      result.kelurahan = undefined;
      result.kecamatan = undefined;
      result.rt = undefined;
      result.rw = undefined;

      const { result: type } = await Users.getUserType(datas.idUser);
      return h
        .response({
          token: "token verified",
          type,
          result,
        })
        .code(200);
    } catch (error) {
      return h.response({ error: error.message }).code(400);
    }
  },
  async listPayment(request, h) {
    try {
      const token = request.headers.authorization.split(" ")[1];
      const datas = await decryptJwt.decryptAccessToken(token);
      const result = await EventModelData.listPayment(datas.idUser);
      const { result: type } = await Users.getUserType(datas.idUser);
      return h
        .response({
          token: "token verified",
          type,
          result,
        })
        .code(200);
    } catch (error) {
      return h.response({ error: error.message }).code(400);
    }
  },
  async checkDate(request, h) {
    try {
      const token = request.headers.authorization.split(" ")[1];
      const datas = await decryptJwt.decryptAccessToken(token);
      const { idEvent, year, month, day = 1 } = request.params;
      const [jenis, err] = await CheckDateData.getJenis(idEvent);
      if (err) throw err;
      let result;
      if (jenis == "gedung") {
        result = await CheckDateData.getDataFromGedungAll();

        const items = [];
        result = result.map((item) => {
          items.push(formatedDate(item.toLocaleString().split(",")[0]));
        });
        result = items.sort();
      } else if (jenis == "sesi") {
        if (!(year && month && day)) {
          result = await CheckDateData.getDataFromSesi(null, idEvent);
        } else {
          result = await CheckDateData.getDataFromSesi(
            `${year}-${month}-${day}`,
            idEvent
          );
        }
      } else {
        result = await CheckDateData.getDataFromHariBulanAll(idEvent);
        if (jenis == "bulan") {
          result = result.map((item) => {
            const dateObject = new Date(item.dateMulai);

            const year = dateObject.getFullYear(); // Mendapatkan tahun
            const month = dateObject.getMonth() + 1; // Mendapatkan bulan (dalam rentang 0-11, jadi perlu ditambah 1)
            const day = dateObject.getDate(); // Mendapatkan tanggal
            const dateMulai = new Date(`${year}-${month}-${day}`);
            dateMulai.setMonth(dateMulai.getMonth() + 1);
            return {
              dateMulai: formatedDate(
                item.dateMulai.toLocaleString().split(",")[0]
              ),
              dateAkhir: formatedDate(dateMulai.toLocaleString().split(",")[0]),
              type: jenis,
              jumlahHari: "28-31 hari berlaku 1 bulan",
            };
          });
        } else {
          const items = [];
          result = result.map((item) => {
            for (let i = 0; i < item.jumlahHari; i++) {
              const dateObject = new Date(item.dateMulai);

              const year = dateObject.getFullYear(); // Mendapatkan tahun
              const month = dateObject.getMonth() + 1; // Mendapatkan bulan (dalam rentang 0-11, jadi perlu ditambah 1)
              const day = dateObject.getDate(); // Mendapatkan tanggal
              const dateMulai = new Date(`${year}-${month}-${day}`);
              dateMulai.setDate(dateMulai.getDate() + i);
              items.push(
                formatedDate(dateMulai.toLocaleString().split(",")[0])
              );
            }
          });
          result = items.sort();
        }
      }
      const { result: type } = await Users.getUserType(datas.idUser);
      return h
        .response({
          token: "token verified",
          type,
          result,
        })
        .code(200);
    } catch (error) {
      return h.response({ error: error.message }).code(400);
    }
  },
};
