import mysql from "mysql2";
import dotenv from "dotenv";
dotenv.config();

const pool = mysql.createPool(process.env.DATABASE_URL).promise();

export class Users {
  static async allUsers() {
    return await pool.query(`SELECT * FROM Users`);
  }
  static async deleteUsersByEmail(email) {
    await pool.query(`DELETE FROM Users WHERE email = ?`, [email]);
    const [dataUser] = await pool.query(`SELECT * FROM Users WHERE email = ?`, [
      email,
    ]);
    if (dataUser.length) {
      return { error: "gagal untuk menghapus data" };
    }
    return { result: "data berhasil dihapus" };
  }
  static async deleteUsersById(id) {
    await pool.query(`DELETE FROM Users WHERE idUser = ?`, [id]);
    const [dataUser] = await pool.query(
      `SELECT * FROM Users WHERE idUser = ?`,
      [id]
    );
    if (dataUser.length) {
      return { error: "gagal untuk menghapus data" };
    }
    return { result: "data berhasil dihapus" };
  }
  static async addUser(userData) {
    const {
      nama,
      noKTP,
      dukuh,
      kelurahan,
      kecamatan,
      rt,
      rw,
      email,
      password,
      gender,
      noTelp,
      wargaTriharjo,
    } = userData;
    const [datas] = await pool.query(
      `INSERT INTO Users (
        nama,
        noKTP,
        dukuh,
        kelurahan,
        kecamatan,
        rt,
        rw,
        email,
        password,
        gender,
        noTelp,
        wargaTriharjo
        ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)`,
      [
        nama,
        noKTP,
        dukuh,
        kelurahan,
        kecamatan,
        rt,
        rw,
        email,
        password,
        gender,
        noTelp,
        wargaTriharjo,
      ]
    );
    const hasil = datas.insertId
      ? { result: "data berhasil dimasukkan", id: datas.insertId, error: null }
      : { result: null, id: null, error: "data gagal dimasukkan" };
    return hasil;
  }
  static async getUser(id) {
    const [datas] = await pool.query(`SELECT * FROM Users WHERE idUser = ?`, [
      id,
    ]);
    if (!datas.length) return { result: null, error: "data tidak ada" };
    return {
      result: datas[0],
      error: null,
    };
  }
  static async getUserType(id) {
    const [datas] = await pool.query(`SELECT * FROM Users WHERE idUser = ?`, [
      id,
    ]);
    if (!datas.length) return { result: null, error: "data tidak ada" };
    return {
      result: datas[0].typeUser,
      error: null,
    };
  }
  static async editUser(userData, idUser) {
    const { result: datas, error } = await this.getUser(idUser);
    if (error) return { result: null, error };
    const {
      nama = datas.nama,
      noKTP = datas.noKTP,
      dukuh = datas.dukuh,
      kelurahan = datas.kelurahan,
      kecamatan = datas.kecamatan,
      rt = datas.rt,
      rw = datas.rw,
      email = datas.email,
      password = datas.password,
      gender = datas.gender,
      noTelp = datas.noTelp,
      wargaTriharjo = datas.wargaTriharjo,
    } = userData;
    await pool.query(
      `UPDATE Users SET 
        nama = ?,
        noKTP = ?,
        dukuh = ?,
        kelurahan = ?,
        kecamatan = ?,
        rt=?,
        rw=?,
        email=?,
        password=?,
        gender=?,
        noTelp=?,
        wargaTriharjo=?
        WHERE idUser = ?`,
      [
        nama,
        noKTP,
        dukuh,
        kelurahan,
        kecamatan,
        rt,
        rw,
        email,
        password,
        gender,
        noTelp,
        wargaTriharjo,
        idUser,
      ]
    );
    // seharusnya menambahkan pernecekan apakah data sudah berhasil dirubah atau gagal
    return {
      result: "data berhasil dirubah",
      error: null,
    };
  }
  static async getPasswordByEmail(email) {
    const [dataUser] = await pool.query(
      `SELECT password FROM Users WHERE email = ?`,
      [email]
    );
    return dataUser;
  }
  static async getUserByEmail(email) {
    const [dataUser] = await pool.query(
      `
      SELECT * FROM Users WHERE email = ? 
    `,
      [email]
    );
    return dataUser;
  }
  static async deleteUser(id) {
    const dataUser = await pool.query(`DELETE FROM Users WHERE idUser = ?`, [
      id,
    ]);
    const { result, error } = await this.getUser(id);
    if (error) return { result: "data berhasil dihapus", error: null };
    return {
      result: null,
      error: "data gagal dihapus",
    };
  }
}
