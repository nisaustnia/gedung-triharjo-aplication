import { EventSewaParent } from "./parentClass/EventSewaParent.model.js";
import mysql from "mysql2";
import dotenv from "dotenv";
dotenv.config({ path: "../.env" });

const pool = mysql.createPool(process.env.DATABASE_URL).promise();

export class DeletePemesanan extends EventSewaParent {
  constructor() {
    super();
  }

  static async addToTable(bookingCode) {
    await pool.query(
      `INSERT INTO checkDataDelete (bookingCode, status) values (?,'pending delete')`,
      [bookingCode]
    );
  }

  static async changeStatus(bookingCode) {
    await pool.query(
      `UPDATE checkDataDelete SET status = 'deleted' WHERE bookingCode =?`,
      [bookingCode]
    );
  }
}
