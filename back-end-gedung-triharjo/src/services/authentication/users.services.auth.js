import { Users } from "../../../model/Users.model.js";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";
dotenv.config();

export const usersServicesAuth = {
  async register(datas) {
    const emailData = await Users.getUserByEmail(datas.email);
    if (emailData.length) throw new Error("data sudah ada");
    datas.wargaTriharjo = false;
    if (datas.dukuh.toUpperCase().includes("TRIHARJO"))
      datas.wargaTriharjo = true;
    const { result, error } = await Users.addUser(datas);
    if (error) throw new Error("gagal melakukan registrasi");
    return "berhasil melakukan registrasi";
  },
  async login(datas) {
    const passwordData = await Users.getPasswordByEmail(datas.email);
    if (!passwordData.length) throw Error("data tidak ada");
    if (datas.password !== passwordData[0].password)
      throw new Error("password salah");
    const emailData = await Users.getUserByEmail(datas.email);
    if (!emailData.length) throw Error("data tidak ada");
    return emailData[0];
  },
  async refreshToken(datas) {
    const dataUser = await Users.getUserByEmail(datas.email);
    if (!dataUser.length) throw new Error("data sudah tidak ada");
    const accessToken = jwt.sign(dataUser[0], process.env.ACCESSTOKEN, {
      expiresIn: process.env.EXPIRESACCESSTOKEN,
    });
    // get type user
    const { result: type } = await Users.getUserType(dataUser[0].idUser);
    return { type, accessToken };
  },
};
