import { Users } from "../../../model/Users.model.js";

describe("digunakan untuk testing CRUD database Users", () => {
  let usersId;
  const dataSementara = {
    nama: "faridl akbarullah",
    alamat: "klaten",
    noKTP: "12345678",
    jenisKelamin: "L",
    noTelp: "12345678910",
  };
  const dataSementaraGanti = {
    nama: "faridl m akbarullah",
    alamat: "klaten",
  };
  test("melakukan testing untuk menambahkan users", async () => {
    const { result, id, error } = await Users.addUser(dataSementara);
    usersId = id;
    expect(result).toBe("data berhasil dimasukkan");
    expect(error).toBeFalsy();
  });
  test("melakukan testing untuk melihat users", async () => {
    const { result, error } = await Users.getUser(usersId);
    expect(result).toBeTruthy();
    expect(error).toBeFalsy();
  });
  test("melakukan testing untuk merubah users", async () => {
    dataSementaraGanti.idUser = usersId;
    const { result, error } = await Users.editUser(dataSementaraGanti);
    expect(result).toBe("data berhasil dirubah");
    expect(error).toBeFalsy();
  });
  test("melakukan testing untuk mendelete users", async () => {
    const { result, error } = await Users.deleteUser(usersId);
    expect(result).toBe("data berhasil dihapus");
    expect(error).toBeFalsy();
  });
});
