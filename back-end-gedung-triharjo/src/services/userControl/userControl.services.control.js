import { Users } from "../../../model/Users.model.js";

export const userControlServicesControl = {
  async getUser(idUser) {
    const { result } = await Users.getUser(idUser);
    const { result: type } = await Users.getUserType(idUser);
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
    } = result;
    return {
      type,
      result: {
        nama,
        email,
        noTelp,
        noKTP,
        gender,
        alamatLengkap: `RT/RW ${rt}/${rw} ${dukuh}, ${kelurahan}, ${kecamatan}, Indonesia`,
        wargaTriharjo,
      },
    };
  },
  async editUser(value, idUser) {
    const { result } = await Users.editUser(value, idUser);
    const { result: type } = await Users.getUserType(idUser);
    return { result, type };
  },
};
