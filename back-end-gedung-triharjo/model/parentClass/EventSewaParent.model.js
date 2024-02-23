import mysql from "mysql2";
import dotenv from "dotenv";
dotenv.config({ path: "../../.env" });

export class EventSewaParent {
  constructor(jenis) {
    this.jenis = jenis;
    this.pool = mysql.createPool(process.env.DATABASE_URL).promise();
  }
  async listEvent(wargaTriharjo) {
    if (wargaTriharjo) {
      const [listEvent] = await this.pool.query(
        `
        SELECT idEvent, event, descripsi, triharjo, organisasi FROM eventgedung WHERE jenis = ?
        `,
        [this.jenis]
      );
      if (!listEvent.length)
        return { error: `gagal menampilkan list ${this.jenis}` };
      const result = this.changeKeyName(listEvent);
      return {
        result,
        column: ["idEvent", "event", "descripsi", "organisasi", "perorangan"],
      };
    } else {
      const [listEvent] = await this.pool.query(
        `
        SELECT idEvent, event, descripsi, nontriharjo, organisasi FROM eventgedung WHERE jenis = ?
        `,
        [this.jenis]
      );
      if (!listEvent.length)
        return { error: `gagal menampilkan list ${this.jenis}` };
      const result = this.changeKeyName(listEvent);
      return {
        result,
        column: ["idEvent", "event", "descripsi", "organisasi", "perorangan"],
      };
    }
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
}
