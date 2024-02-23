import {
  EventModelData,
  AdminModelData,
} from "../../../model/Databases.model.js";
import { DeletePemesanan } from "../../../model/DeletePemesanan.model.js";
import { Notification } from "../../../model/Notification.model.js";
import { googlesheetutils } from "../../utils/googlesheet.utils.js";

export const getNotificationRoutes = [
  {
    method: "POST",
    path: "/midtrans",
    handler: async (request, h) => {
      try {
        async function deletePemesananSekarang(order_id, transaction_status) {
          if (
            transaction_status == "expire" ||
            transaction_status == "failure" ||
            transaction_status == "deny" ||
            transaction_status == "cancel"
          ) {
            await DeletePemesanan.changeStatus(order_id);
            const { error, result } = await EventModelData.deletePemesanan(
              order_id
            );
            if (error) throw error;
            const dataUser = await Notification.getDataFromBookingCode(
              order_id
            );
            await Notification.deleteData(bookingCode);
            await Notification.insertData(
              dataUser.idUser,
              `pemesanan mu dicancel otomatis dengan code booking ${order_id} dikarenakan expired`,
              order_id
            );
            return result;
          } else if (
            transaction_status == "settlement" ||
            transaction_status == "success"
          ) {
            const result = await EventModelData.successPemesanan(order_id);
            const dataUser = await Notification.getDataFromBookingCode(
              bookingCode
            );
            await Notification.insertData(
              dataUser.idUser,
              `pemesanan mu telah berhasil dengan code booking ${order_id}`,
              order_id
            );
            await Notification.insertData(
              0,
              `pesanan dengan code booking ${order_id} telah berhasil`,
              order_id
            );
            return result;
          }
        }
        const { order_id, transaction_status } = request.payload;
        const status = await AdminModelData.getStatusByBookingCode(order_id);
        console.log(status);
        if (!status) throw new Error("status salah");
        if (status == "success") {
          const rawData = await AdminModelData.getDataForSheet(order_id);
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
          await googlesheetutils("credentials/credentials.json", values);
          return h
            .response({
              token: "token verified",
              result: "berhasil",
            })
            .code(200);
        } else {
          const result = await deletePemesananSekarang(
            order_id,
            transaction_status
          );
          return h
            .response({
              token: "token verified",
              result,
            })
            .code(200);
        }
      } catch (error) {
        return h.response({ error: error.message }).code(400);
      }
    },
  },
];
