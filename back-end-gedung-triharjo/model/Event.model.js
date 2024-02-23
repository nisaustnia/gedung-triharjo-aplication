import { EventSewaParent } from "./parentClass/EventSewaParent.model.js";
import dotenv from "dotenv";
dotenv.config({ path: "../.env" });

export class EventModel extends EventSewaParent {
  constructor() {
    super();
  }
  async getPayment(UsersId, bookingCode) {
    const [result] = await this.pool.query(
      `SELECT p.bookingCode, e.event, u.noKTP, u.dukuh, u.kelurahan, u.kecamatan, u.rt, u.rw, u.nama, u.email, u.noTelp, p.time ,p.dateMulai, p.jumlahHari, p.status, p.totalPembayaran, p.pembayaran, p.createdAt FROM pemesanan p INNER JOIN eventgedung e ON e.idEvent = p.idEvent INNER JOIN Users u on u.idUser = p.idUser WHERE u.idUser = ? AND bookingCode = ?`,
      [UsersId, bookingCode]
    );
    if (!result.length) throw new Error("data tidak ada");
    return result;
  }
  async listPayment(UsersId) {
    const [result] = await this.pool.query(
      `SELECT p.bookingCode, e.event, p.status, p.totalPembayaran FROM pemesanan p INNER JOIN eventgedung e ON e.idEvent = p.idEvent WHERE idUser = ?`,
      [UsersId]
    );
    return result;
  }
  async getPaymentByBookingUserId(UsersId, bookingCode) {
    const [result] = await this.pool.query(
      `SELECT bookingCode FROM pemesanan WHERE idUser = ? AND bookingCode = ?`,
      [UsersId, bookingCode]
    );
    return result;
  }
  async successPemesanan(bookingCode) {
    const [result] = await this.pool.query(
      `UPDATE pemesanan SET status="success", pembayaran=null WHERE bookingCode=?`,
      [bookingCode]
    );
    return result;
  }
  async addPembayaran(datas, bookingCode) {
    await this.pool.query(
      `UPDATE pemesanan SET pembayaran = ? WHERE bookingCode=?`,
      [datas, bookingCode]
    );
  }
  async deletePemesanan(bookingCode) {
    await this.pool.query(`DELETE FROM pemesanan WHERE bookingCode =?`, [
      bookingCode,
    ]);
    const [result] = await this.pool.query(
      `SELECT * FROM pemesanan WHERE bookingCode= ?`,
      [bookingCode]
    );
    if (result.length) return { error: new Error("gagal") };
    return { result: "berhasil" };
  }
  async getTipeWaktuDanHarga(idEvent) {
    const [dataTipeWaktu] = await this.pool.query(
      `
      SELECT tipeWaktu, triharjo, nontriharjo, organisasi FROM eventgedung WHERE idEvent = ?
    `,
      [idEvent]
    );
    if (!dataTipeWaktu.length) return { error: "gagal menampilkan list Event" };
    return {
      result: dataTipeWaktu[0].tipeWaktu,
      hargas: {
        triharjo: dataTipeWaktu[0].triharjo,
        nontriharjo: dataTipeWaktu[0].nontriharjo,
        organisasi: dataTipeWaktu[0].organisasi,
      },
    };
  }
  async getHarga(idEvent, tipeHarga) {
    const [dataHarga] = await this.pool.query(
      `
      SELECT triharjo, nontriharjo, organisasi FROM eventgedung WHERE idEvent = ?
    `,
      [idEvent]
    );
    if (!dataHarga.length) return { error: "gagal menampilkan list Event" };
    return { result: dataHarga[0][tipeHarga] };
  }
  async getEventById(idE, wargaTriharjo) {
    if (wargaTriharjo) {
      const [dataEvent] = await this.pool.query(
        `
      SELECT idEvent, event, descripsi, triharjo, organisasi, jenis, tipeWaktu FROM eventgedung WHERE idEvent = ?
    `,
        [idE]
      );
      if (!dataEvent.length) return { error: "gagal menampilkan list Event" };
      const result = this.changeKeyName(dataEvent);
      return {
        result,
        column: [
          "idEvent",
          "event",
          "descripsi",
          "perorangan",
          "organisasi",
          "jenis",
          "tipeWaktu",
        ],
      };
    } else {
      const [dataEvent] = await this.pool.query(
        `
      SELECT idEvent, event, descripsi, nontriharjo, organisasi, jenis, tipeWaktu FROM eventgedung WHERE idEvent = ?
    `,
        [idE]
      );
      if (!dataEvent.length) return { error: "gagal menampilkan list Event" };
      const result = this.changeKeyName(dataEvent);
      return {
        result,
        column: [
          "idEvent",
          "event",
          "descripsi",
          "perorangan",
          "organisasi",
          "jenis",
          "tipeWaktu",
        ],
      };
    }
  }
  async listEvent(wargaTriharjo) {
    if (wargaTriharjo) {
      const [listEvent] = await this.pool.query(`
        SELECT idEvent, event, descripsi, triharjo, jenis, organisasi FROM eventgedung
        `);
      if (!listEvent.length) return { error: "gagal menampilkan list Event" };
      const result = this.changeKeyName(listEvent);
      return {
        result,
        column: ["idEvent", "event", "descripsi", "organisasi", "perorangan"],
      };
    } else {
      const [listEvent] = await this.pool.query(`
        SELECT idEvent, event, descripsi, nontriharjo, jenis, organisasi FROM eventgedung
        `);
      if (!listEvent.length) return { error: "gagal menampilkan list Event" };
      const result = this.changeKeyName(listEvent);
      return {
        result,
        column: ["idEvent", "event", "descripsi", "organisasi", "perorangan"],
      };
    }
  }
  async listEvent0() {
    const [listEvent] = await this.pool.query(`
        SELECT idEvent, event, descripsi, triharjo, nontriharjo, organisasi, jenis, tipeWaktu FROM eventgedung
        `);
    if (!listEvent.length) return { error: "gagal menampilkan list Event" };
    return {
      result: listEvent,
      column: [
        "idEvent",
        "event",
        "descripsi",
        "triharjo",
        "nontriharjo",
        "organisasi",
        "jenis",
        "tipeWaktu",
      ],
    };
  }
  async listEventJenis(wargaTriharjo) {
    if (wargaTriharjo) {
      const [listEvent] = await this.pool.query(`
        SELECT idEvent, event, descripsi, triharjo, jenis, organisasi FROM eventgedung
        `);
      if (!listEvent.length) return { error: "gagal menampilkan list Event" };
      const result = this.changeKeyName(listEvent);
      const reduceD = this.reduceData(result);
      return {
        result: reduceD,
        column: ["idEvent", "event", "descripsi", "organisasi", "perorangan"],
      };
    } else {
      const [listEvent] = await this.pool.query(`
        SELECT idEvent, event, descripsi, nontriharjo, jenis, organisasi FROM eventgedung
        `);
      if (!listEvent.length) return { error: "gagal menampilkan list Event" };
      const result = this.changeKeyName(listEvent);
      const reduceD = this.reduceData(result);
      return {
        result: reduceD,
        column: ["idEvent", "event", "descripsi", "organisasi", "perorangan"],
      };
    }
  }
  async listPerorangan(wargaTriharjo) {
    const column = ["idEvent", "event", "descripsi", "perorangan"];
    if (wargaTriharjo) {
      const [perorangan] = await this.pool.query(`
        SELECT idEvent, event, descripsi, triharjo, jenis FROM eventgedung WHERE triharjo IS NOT NULL
        `);
      if (!perorangan.length) return { error: "gagal menampilkan list Event" };
      const result = this.changeKeyName(perorangan);
      const reduceD = this.reduceData(result);
      return {
        result: reduceD,
        column,
      };
    } else {
      const [perorangan] = await this.pool.query(`
        SELECT idEvent, event, descripsi, nontriharjo, jenis FROM eventgedung WHERE nontriharjo IS NOT NULL
        `);
      if (!perorangan.length) return { error: "gagal menampilkan list Event" };
      const result = this.changeKeyName(perorangan);
      const reduceD = this.reduceData(result);
      return {
        result: reduceD,
        column,
      };
    }
  }
  async listOrganisasi() {
    const column = ["idEvent", "event", "descripsi", "organisasi"];
    const [organisasi] = await this.pool.query(`
        SELECT idEvent, event, descripsi, organisasi, jenis FROM eventgedung WHERE organisasi IS NOT NULL
        `);
    if (!organisasi.length) return { error: "gagal menampilkan list Event" };
    const result = this.reduceData(organisasi);
    return {
      result,
      column,
    };
  }
  reduceData(data) {
    const groupedData = data.reduce((acc, current) => {
      const { jenis, ...rest } = current;

      if (!acc[jenis]) {
        acc[jenis] = [];
      }

      acc[jenis].push(rest);
      return acc;
    }, {});

    return groupedData;
  }
  changeKeyName(datas) {
    return datas.map((objek) => {
      const { triharjo, nontriharjo, ...objekBaru } = objek;
      if (triharjo) return { ...objekBaru, perorangan: triharjo };
      return { ...objekBaru, perorangan: nontriharjo };
    });
  }
  async isWargaTriharjo(id) {
    const [wargaTriharjo] = await this.pool.query(
      `
        SELECT wargaTriharjo FROM Users WHERE idUser = ?
    `,
      [id]
    );
    if (!wargaTriharjo.length) return { error: "gagal" };
    return { result: wargaTriharjo[0].wargaTriharjo };
  }
  async pemesanan0(idUser, idEvent, dataPemesanan) {
    const { dateMulai, jumlah, totalPembayaran } = dataPemesanan;
    const currentDate = new Date();
    const year = currentDate.getFullYear();
    const month = currentDate.getMonth() + 1; // Penambahan 1 karena bulan dimulai dari 0
    const day = currentDate.getDate();
    const [pemesanan] = await this.pool.query(
      `
      INSERT INTO pemesanan (idUser, idEvent, dateMulai, jumlah, totalPembayaran) VALUES (?,?,?,?,?)
      `,
      [idUser, idEvent, dateMulai, jumlah, totalPembayaran]
    );
    const bookingCode = `${year}${month}${day}0${idUser}0${idEvent}0${pemesanan.insertId}`;
    const [result] = await this.pool.query(
      `
      UPDATE pemesanan SET bookingCode = ? WHERE idPemesanan = ?
      `,
      [bookingCode, pemesanan.insertId]
    );
    if (!result.insertId) return { error: "data gagal dimasukkan" };
    return { result: "pemesanan berhasil dimasukkan" };
  }
  async pemesanan(idUser, idEvent, dataPemesanan, bookingCode, pembayaran) {
    // check apakah data ada
    // dataPemesanan.time = await this.checkDataAda(idEvent, dataPemesanan);
    const {
      time = "00:01",
      dateMulai,
      jumlahHari = null,
      totalPembayaran,
      tipeHarga,
      keperluan = null,
    } = dataPemesanan;
    // memasukkan data
    const [result] = await this.pool.query(
      `
      INSERT INTO pemesanan (idUser, idEvent, time, dateMulai, jumlahHari, totalPembayaran, tipeHarga, keperluan, bookingCode, pembayaran) VALUES (?,?,?,?,?,?,?,?,?,?);`,
      [
        idUser,
        idEvent,
        time,
        dateMulai,
        jumlahHari,
        totalPembayaran,
        tipeHarga,
        keperluan,
        bookingCode,
        pembayaran,
      ]
    );
    if (!result.insertId) {
      return [null, new Error("gagal memasukkan data")];
    }
    const [[resultDatas]] = await this.pool.query(
      `SELECT * FROM pemesanan WHERE idPemesanan = ?`,
      [result.insertId]
    );
    return [resultDatas, null];
  }
  async checkDataAda(idEvent, dataPemesanan) {
    const [[datas]] = await this.pool.query(
      `
      SELECT tipeWaktu, jenis FROM eventgedung WHERE idEvent = ?;
    `,
      [idEvent]
    );

    if (datas.jenis == "gedung") {
      if (dataPemesanan.jumlahHari > 1) {
        throw new Error("jumlah hari hanya boleh satu");
      }
      const [checkData] = await this.pool.query(
        `SELECT *
        FROM pemesanan INNER JOIN eventgedung ON pemesanan.idEvent = eventgedung.idEvent
        WHERE ? BETWEEN pemesanan.dateMulai AND DATE_ADD(pemesanan.dateMulai, INTERVAL 0 DAY) AND eventgedung.jenis = ?;`,
        [dataPemesanan.dateMulai, datas.jenis]
      );
      if (checkData.length) {
        throw new Error("tanggal sudah dipesan");
      }
      return "00:01:00";
    } else if (datas.tipeWaktu == "bulan") {
      // jike berbentuk bulanan
      if (dataPemesanan.jumlahHari > 1) {
        throw new Error(
          "jumlah hari default adalah satu, tapi dalam perhitungannya adalah bulan"
        );
      }
      const [checkData] = await this.pool.query(
        `SELECT *
        FROM pemesanan
        WHERE ? BETWEEN dateMulai AND DATE_ADD(dateMulai, INTERVAL 1 month) AND idEvent= ?;`,
        [dataPemesanan.dateMulai, idEvent]
      );
      if (checkData.length) {
        throw new Error("tanggal sudah dipesan");
      }
      return "00:01:00";
    } else if (datas.tipeWaktu == "hari") {
      // jika berbentuk harian
      // harus mengecek tanggal berdasarkan jumlah hari juga
      const [checkData] = await this.pool.query(
        `SELECT *
        FROM pemesanan p
        WHERE ? BETWEEN p.dateMulai AND DATE_ADD(p.dateMulai, INTERVAL p.jumlahHari - 1 DAY) AND idEvent= ?;`,
        [dataPemesanan.dateMulai, idEvent]
      );
      if (checkData.length) {
        throw new Error("tanggal sudah dipesan");
      }
      return "00:01:00";
      // jika sesi
    } else if (datas.tipeWaktu == "sesi") {
      // check apakah ada jumlahHari
      if (dataPemesanan.jumlahHari > 1) {
        throw new Error("jumlah hari hanya boleh satu");
      } else if (!dataPemesanan.time) {
        throw new Error("time tidak ada");
      }
      // mengecek tanggal
      const [checkData] = await this.pool.query(
        `SELECT *
        FROM pemesanan
        WHERE dateMulai = ? AND time = ? AND idEvent = ?`,
        // dibuat seperti ini karena beda idEvent beda tempat
        [dataPemesanan.dateMulai, dataPemesanan.time, idEvent]
      );
      if (checkData.length) {
        throw new Error("waktu sudah dipesan");
      }
      return dataPemesanan.time;
    }
  }
  async makeBookingCode(idUser, idEvent) {
    // const [[jumlah]] = await this.pool.query(
    //   `
    // SELECT COUNT(*) FROM pemesanan where idUser=?;`,
    //   [idUser]
    // );
    // mendapatkan tanggal
    const currentDate = new Date();
    const year = currentDate.getFullYear();
    const month = currentDate.getMonth() + 1;
    const day = currentDate.getDate();
    const hours = currentDate.getHours();
    const minutes = currentDate.getMinutes();
    const seconds = currentDate.getSeconds();
    return `${year}${month}${day}${hours}${minutes}${seconds}${idUser}${idEvent}`;
  }
}

// const EventData = new EventModel();

// const dataPemesanan = {
//   dateMulai: "2023-09-29",
//   jumlahHari: 1,
//   time: "07:00:00",
//   tipeHarga: "triharjo",
//   totalPembayaran: 20000,
// };

// EventData.pemesanan(1, 2, dataPemesanan).then((data) => {
//   console.log(data);
// });
