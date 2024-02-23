import { EventSewaParent } from "./parentClass/EventSewaParent.model.js";
import dotenv from "dotenv";
dotenv.config({ path: "../.env" });

export class CheckDate extends EventSewaParent {
  constructor() {
    super();
  }
  async getJenis(idEvent) {
    const [result] = await this.pool.query(
      `SELECT tipeWaktu FROM eventgedung WHERE idEvent = ?`,
      [idEvent]
    );
    if (!result.length) return [null, new Error("data tidak ada")];
    if (result[0].tipeWaktu == null) return ["gedung", null];
    return [result[0].tipeWaktu, null];
  }
  async getDataFromSesi(dateMulai, idEvent) {
    if (!dateMulai) {
      const [result] = await this.pool.query(
        `
        SELECT time, dateMulai
        FROM pemesanan WHERE idEvent = ?`,
        [idEvent]
      );
      // const transformedData = result.reduce((result, item) => {
      //   // Ambil tanggal dari properti dateMulai
      //   const rawDate = new Date(item.dateMulai);
      //   const formattedDate = `${rawDate.getFullYear()}-${(
      //     rawDate.getMonth() + 1
      //   )
      //     .toString()
      //     .padStart(2, "0")}-${rawDate.getDate().toString().padStart(2, "0")}`;

      //   // Pastikan tanggal sudah ada di dalam objek hasil
      //   if (!result[formattedDate]) {
      //     result[formattedDate] = [];
      //   }

      //   // Tambahkan nilai time ke dalam array yang sesuai dengan tanggal
      //   result[formattedDate].push(item.time);

      //   return result;
      // }, {});
      const transformedData = result.reduce((result, item) => {
        const rawDate = new Date(item.dateMulai);
        const formattedDate = `${rawDate.getFullYear()}-${(
          rawDate.getMonth() + 1
        )
          .toString()
          .padStart(2, "0")}-${rawDate.getDate().toString().padStart(2, "0")}`;

        const existingEntry = result.find(
          (entry) => entry.tanggal === formattedDate
        );

        if (existingEntry) {
          existingEntry.time.push(item.time);
        } else {
          result.push({
            tanggal: formattedDate,
            time: [item.time],
          });
        }

        return result;
      }, []);
      return transformedData;
    }
    const [result] = await this.pool.query(
      `
    SELECT time
    FROM pemesanan
    WHERE dateMulai = ? AND idEvent = ?`,
      [dateMulai, idEvent]
    );

    return result.map((item) => item.time);
  }
  async getDataFromGedung(dateMulai) {
    const [result] = await this.pool.query(
      `SELECT *
      FROM pemesanan
      INNER JOIN eventgedung ON pemesanan.idEvent = eventgedung.idEvent
      WHERE DATE_FORMAT(pemesanan.dateMulai, '%Y-%m-01') <= ? AND ? <= LAST_DAY(pemesanan.dateMulai)
      AND eventgedung.jenis = 'gedung';`,
      [dateMulai, dateMulai]
    );
    return result.map((item) => item.dateMulai);
  }
  async getDataFromHariBulan(dateMulai, idEvent) {
    const [result] = await this.pool.query(
      `SELECT p.*, e.*
        FROM pemesanan p INNER JOIN eventgedung e on p.idEvent = e.idEvent 
        WHERE DATE_FORMAT(p.dateMulai, '%Y-%m-01') <= ? AND ? <= LAST_DAY(p.dateMulai)
        AND p.idEvent = ?`,
      [dateMulai, dateMulai, idEvent]
    );
    return result.map((item) => {
      return {
        dateMulai: item.dateMulai,
        jumlahHari: item.jumlahHari,
        tipeWaktu: item.tipeWaktu,
      };
    });
  }
  async getDataFromHariBulanAll(idEvent) {
    const [result] = await this.pool.query(
      `SELECT p.*, e.*
        FROM pemesanan p INNER JOIN eventgedung e on p.idEvent = e.idEvent 
        WHERE p.idEvent = ?`,
      [idEvent]
    );
    return result.map((item) => {
      return {
        dateMulai: item.dateMulai,
        jumlahHari: item.jumlahHari,
        tipeWaktu: item.tipeWaktu,
      };
    });
  }
  async getDataFromGedungAll() {
    const [result] = await this.pool.query(
      `SELECT *
      FROM pemesanan
      INNER JOIN eventgedung ON pemesanan.idEvent = eventgedung.idEvent
      WHERE eventgedung.jenis = 'gedung';`
    );
    return result.map((item) => item.dateMulai);
  }
}

// const CheckDateData = new CheckDate();

// CheckDateData.getDataFromHariBulan("2000-10-10", 7).then((data) => {
//   console.log(data);
// });
