import { EventSewaParent } from "./parentClass/EventSewaParent.model.js";
import mysql from "mysql2";
import dotenv from "dotenv";
dotenv.config({ path: "../.env" });

const pool = mysql.createPool(process.env.DATABASE_URL).promise();

export class Notification extends EventSewaParent {
  constructor() {
    super();
  }

  static async deleteData(bookingCode) {
    await pool.query(
      `
      DELETE from notificationGtr WHERE bookingCode = ?
    `,
      [bookingCode]
    );
  }

  static async getData(idUser) {
    const [result] = await pool.query(
      `SELECT * FROM notificationGtr WHERE idUser = ?`,
      [idUser]
    );
    return result;
  }

  static async insertData(toIdUser, notif, bookingCode = null) {
    // jika 0 maka ke admin jika nomor maka ke user
    const [result] = await pool.query(
      `INSERT INTO notificationGtr (notif, idUser, bookingCode) VALUES (?,?,?)`,
      [notif, toIdUser, bookingCode]
    );
    return result.insertId;
  }

  static async read(idUser, idNotif) {
    await pool.query(
      `UPDATE notificationGtr SET isRead = 1 WHERE idUser = ? AND idNotif = ?`,
      [idUser, idNotif]
    );
    const [result] = await pool.query(
      `
        SELECT * FROM notificationGtr WHERE idUser = ? AND idNotif = ?
    `,
      [idUser, idNotif]
    );
    if (!result.length) throw new Error("data tidak ada");
    return result[0];
  }

  static async totalNotRead(idUser) {
    const [[result]] = await pool.query(
      `SELECT COUNT(*) FROM notificationGtr WHERE idUser = ? AND isRead = 0`,
      [idUser]
    );
    return result["count(*)"];
  }

  static async getDataFromBookingCode(bookingCode) {
    const [[result]] = await pool.query(
      `
        SELECT * FROM pemesanan WHERE bookingCode = ?
    `,
      [bookingCode]
    );
    return result;
  }
}

// const notification = new Notification();

// async function init() {
//   await notification.insertData(0, "halo").then((data) => {
//     console.log(data);
//   });

//   await notification.getData(0).then((data) => {
//     console.log(data);
//   });

//   await notification.read(0, 1).then((data) => {
//     console.log(data);
//   });

//   await notification.getData(0).then((data) => {
//     console.log(data);
//   });

//   await notification.totalNotRead(0).then((data) => {
//     console.log(data);
//   });
// }
// init();
