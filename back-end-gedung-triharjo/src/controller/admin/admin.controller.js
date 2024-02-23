import {
  AdminModelData,
  EventModelData,
} from "../../../model/Databases.model.js";
import { Notification } from "../../../model/Notification.model.js";
import { Users } from "../../../model/Users.model.js";
import cancelMidtransTransUtils from "../../utils/cancelmidtranstrans.utils.js";
import { googlesheetutils } from "../../utils/googlesheet.utils.js";
import statusMidtransTransUtils from "../../utils/statusmidtranstrans.utils.js";

export const adminController = {
  async notif(request, h) {
    try {
      //   const token = request.headers.authorization.split(" ")[1];
      //   const datas = await decryptJwt.decryptAccessToken(token);
      const notReadYet = await Notification.totalNotRead(0);
      const result = await Notification.getData(0);
      return h
        .response({
          token: "token verified",
          // type,
          notReadYet,
          result,
        })
        .code(200);
    } catch (error) {
      return h.response({ error: error.message }).code(400);
    }
  },
  async notRead(request, h) {
    try {
      //   const token = request.headers.authorization.split(" ")[1];
      //   const datas = await decryptJwt.decryptAccessToken(token);
      const notReadYet = await Notification.totalNotRead(0);
      return h
        .response({
          token: "token verified",
          // type,
          notReadYet,
        })
        .code(200);
    } catch (error) {
      return h.response({ error: error.message }).code(400);
    }
  },
  async readNotif(request, h) {
    try {
      //   const token = request.headers.authorization.split(" ")[1];
      //   const datas = await decryptJwt.decryptAccessToken(token);
      const { idNotif } = request.params;
      const result = await Notification.read(0, idNotif);
      return h
        .response({
          token: "token verified",
          // type,
          result,
        })
        .code(200);
    } catch (error) {
      return h.response({ error: error.message }).code(400);
    }
  },
  async deleteUser(request, h) {
    try {
      const { email, id } = request.query;
      //   const token = request.headers.authorization.split(" ")[1];
      //   const datas = await decryptJwt.decryptAccessToken(token);
      if (id) {
        const { error, result } = await Users.deleteUsersById(id);
        if (error) {
          throw new Error(error);
        }
        // const { result: type } = await Users.getUserType(datas.idUser);
        return h
          .response({
            // type,
            result,
          })
          .code(200);
      } else if (email) {
        const { error, result } = await Users.deleteUsersByEmail(email);
        if (error) {
          throw new Error(error);
        }
        // const { result: type } = await Users.getUserType(datas.idUser);
        return h
          .response({
            // type,
            result,
          })
          .code(200);
      } else {
        throw new Error("tolong masukkan query yang tepat");
      }
    } catch (error) {
      console.error(error);
      return h.response({ error: error.message }).code(400);
    }
  },
  async listUser(request, h) {
    // belum selesai
    try {
      const [dataUsers] = await Users.allUsers();
      return h.response({ result: dataUsers });
    } catch (error) {
      return h.response({ error: error.message }).code(400);
    }
  },
  async deletePayment(request, h) {
    try {
      const { bookingCode } = request.params;
      //   const token = request.headers.authorization.split(" ")[1];
      //   const datas = await decryptJwt.decryptAccessToken(token);
      //   lakukan cancel payment midtrans
      const respMidtrans = await cancelMidtransTransUtils(bookingCode);
      if (!(respMidtrans.data.status_code == "200"))
        throw new Error(respMidtrans.data.status_message);
      // const { result: type } = await Users.getUserType(datas.idUser);

      // memberikan notif ke user
      const dataUser = await Notification.getDataFromBookingCode(bookingCode);
      await Notification.deleteData(bookingCode);
      await Notification.insertData(
        dataUser.idUser,
        `pemesanan mu dicancel dengan code booking ${bookingCode}`,
        bookingCode
      );
      await Notification.insertData(
        0,
        `pesanan dengan code booking ${bookingCode} telah dicancel`,
        bookingCode
      );
      return h
        .response({
          token: "token verified",
          // type,
          result: respMidtrans.data,
        })
        .code(200);
    } catch (error) {
      return h.response({ error: error.message }).code(400);
    }
  },
  async getPayment(request, h) {
    try {
      //   const token = request.headers.authorization.split(" ")[1];
      //   const datas = await decryptJwt.decryptAccessToken(token);
      const { bookingCode } = request.params;
      const [result] = await AdminModelData.getPayment(bookingCode);
      result.alamat = `DK. ${result.dukuh}, ${result.kelurahan}, ${result.kecamatan}`;
      result.rtrw = `RT ${result.rt}/RW ${result.rw}`;
      result.dukuh = undefined;
      result.kelurahan = undefined;
      result.kecamatan = undefined;
      result.rt = undefined;
      result.rw = undefined;
      // let rawData;
      // if (result[0].status == "pending") {
      //   rawData = await statusMidtransTransUtils(bookingCode);
      // }
      // const { result: type } = await Users.getUserType(datas.idUser);
      return h
        .response({
          token: "token verified",
          // type,
          result,
        })
        .code(200);
    } catch (error) {
      return h.response({ error: error.message }).code(400);
    }
  },
  async listPayment(request, h) {
    try {
      const { status } = request.query;
      //   const token = request.headers.authorization.split(" ")[1];
      //   const datas = await decryptJwt.decryptAccessToken(token);
      const result = await AdminModelData.listPayment(status);
      // const { result: type } = await Users.getUserType(datas.idUser);
      return h
        .response({
          token: "token verified",
          // type,
          result,
        })
        .code(200);
    } catch (error) {
      return h.response({ error: error.message }).code(400);
    }
  },
  async acceptPayment(request, h) {
    try {
      //   const token = request.headers.authorization.split(" ")[1];
      //   const datas = await decryptJwt.decryptAccessToken(token);
      const { bookingCode } = request.params;
      //   pergantian pending ke success
      const result = await EventModelData.successPemesanan(bookingCode);
      const status = await AdminModelData.getStatusByBookingCode(bookingCode);
      if (status == "pending") throw new Error("gagal accept payment");

      // jangan dihapus karena cancelMidtrans mengembalikan nilai maka harus dimasukkan ke variable
      const respMidtrans = await cancelMidtransTransUtils(bookingCode);

      // transfer to googlesheet
      const rawData = await AdminModelData.getDataForSheet(bookingCode);
      let waktuAkhir;
      if (rawData.tipeWaktu == "sesi" || rawData.tipeWaktu == null) {
        waktuAkhir = rawData.dateMulai.toLocaleString().split(",")[0];
      } else if (rawData.tipeWaktu == "hari") {
        waktuAkhir = new Date(rawData.dateMulai);
        waktuAkhir.setDate(waktuAkhir.getDate() + rawData.jumlahHari);
      } else if (rawData.tipeWaktu == "bulan") {
        waktuAkhir = new Date(rawData.dateMulai);
        waktuAkhir.setMonth(waktuAkhir.getMonth() + 1);
      }
      const values = [
        rawData.bookingCode,
        rawData.nama,
        rawData.email,
        rawData.noTelp,
        `RT/RW ${rawData.rt}/${rawData.rw} ${rawData.dukuh}, ${rawData.kelurahan}, ${rawData.kecamatan} - indonesia`,
        rawData.event,
        rawData.tipeWaktu == null ? "khusus" : rawData.tipeWaktu,
        rawData.time,
        rawData.dateMulai.toLocaleString().split(",")[0],
        waktuAkhir.toLocaleString().split(",")[0],
        rawData.totalPembayaran,
        rawData.tipeHarga,
        rawData.status,
      ];
      const results = await googlesheetutils(
        "./credentials/credentials.json",
        values
      );
      await Notification.insertData(
        rawData.idUser,
        `pemesanan mu telah berhasil dengan code booking ${bookingCode}`,
        bookingCode
      );
      await Notification.insertData(
        0,
        `pesanan dengan code booking ${bookingCode} telah berhasil`,
        bookingCode
      );

      // const { result: type } = await Users.getUserType(datas.idUser);
      return h
        .response({
          token: "token verified",
          // type,
          result: "berhasil",
        })
        .code(200);
    } catch (error) {
      return h.response({ error: error.message }).code(400);
    }
  },
  async changeRole(request, h) {
    try {
      //   const token = request.headers.authorization.split(" ")[1];
      //   const datas = await decryptJwt.decryptAccessToken(token);
      const { email, role } = request.query;
      if (!(email && role))
        throw new Error("tolong masukan email dan role sebagai query");
      if (!(role == "customer" || role == "admin"))
        throw new Error("role hanya ada admin atau customer");
      const [result, err] = await AdminModelData.changeRole(email, role);
      if (err) throw err;
      // const { result: type } = await Users.getUserType(datas.idUser);
      return h
        .response({
          token: "token verified",
          // type,
          result,
        })
        .code(200);
    } catch (error) {
      return h.response({ error: error.message }).code(400);
    }
  },
};
