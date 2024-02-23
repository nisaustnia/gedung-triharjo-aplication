import { EventSewaParent } from "./parentClass/EventSewaParent.model.js";

export class AdminModel extends EventSewaParent {
  constructor() {
    super();
  }
  async getDataForSheet(bookingCode) {
    const [[result]] = await this.pool.query(
      `SELECT u.*, p.*, e.* FROM pemesanan p INNER JOIN Users u ON u.idUser = p.idUser INNER JOIN eventgedung e ON e.idEvent = p.idEvent WHERE bookingCode = ?`,
      [bookingCode]
    );
    return result;
  }
  //   check status
  async getStatusByBookingCode(bookingCode) {
    const [[result]] = await this.pool.query(
      `SELECT status FROM pemesanan WHERE bookingCode = ?`,
      [bookingCode]
    );
    if (!result) throw new Error("data tidak ada");
    return result.status;
  }
  async getPayment(bookingCode) {
    const [result] = await this.pool.query(
      `SELECT p.bookingCode, e.event, u.noKTP, u.dukuh, u.kelurahan, u.kecamatan, u.rt, u.rw, u.nama, u.email, u.noTelp, p.time ,p.dateMulai, p.jumlahHari, p.status, p.totalPembayaran, p.pembayaran, p.createdAt FROM pemesanan p INNER JOIN eventgedung e ON e.idEvent = p.idEvent INNER JOIN Users u on u.idUser = p.idUser WHERE p.bookingCode = ?`,
      [bookingCode]
    );
    if (!result.length) throw new Error("data tidak ada");
    return result;
  }
  async listPayment(status) {
    if (status) {
      const [result] = await this.pool.query(
        `SELECT p.bookingCode, e.event, p.status, p.totalPembayaran FROM pemesanan p INNER JOIN eventgedung e ON e.idEvent = p.idEvent WHERE p.status = ?`,
        [status]
      );
      return result;
    }
    const [result] = await this.pool.query(
      `SELECT p.bookingCode, e.event, p.status, p.totalPembayaran FROM pemesanan p INNER JOIN eventgedung e ON e.idEvent = p.idEvent`
    );
    return result;
  }
  async changeRole(email, role) {
    await this.pool.query(`UPDATE Users SET typeUser = ? WHERE email = ?`, [
      role,
      email,
    ]);
    const [result] = await this.pool.query(
      `SELECT * FROM Users WHERE email = ? AND typeUser = ?`,
      [email, role]
    );
    if (!result.length) return [null, new Error("gagal melakukan perubahan")];
    return ["berhasil melakukan perubahan", null];
    return;
  }
}
