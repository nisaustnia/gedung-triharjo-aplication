import { usersInputAuth } from "../../middleware/users.input.auth.js";
import { usersServicesAuth } from "../../services/authentication/users.services.auth.js";
import { isJson } from "../../utils/isJson.utils.js";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";
import { decryptJwt } from "../../utils/decryptJwt.utils.js";
dotenv.config();

// WARNINIG: jika json yang dimasukkan di postman berbentuk raw berarti harus menggunakan isJson dan di middleware harus ditambahkan JSON.parse

export const usersControllerAuth = {
  async register(request, h) {
    try {
      // isJson(request.payload);
      const { value, error } = usersInputAuth.registerInput(request.payload);
      if (error) throw error;
      const result = await usersServicesAuth.register(value);
      return h.response({ result }).code(200);
    } catch (error) {
      return h.response({ error: error.message }).code(400);
    }
  },
  async login(request, h) {
    try {
      // isJson(request.payload);
      const { value, error } = usersInputAuth.loginInput(request.payload);
      if (error) throw error;
      const dataUser = await usersServicesAuth.login(value);
      return h
        .response({
          accessToken: jwt.sign(dataUser, process.env.ACCESSTOKEN, {
            expiresIn: process.env.EXPIRESACCESSTOKEN,
          }),
          refreshToken: jwt.sign(
            { email: dataUser.email },
            process.env.REFRESHTOKEN,
            {
              expiresIn: process.env.EXPIRESREFRESHTOKEN,
            }
          ),
        })
        .code(200);
    } catch (error) {
      return h.response({ error: error.message }).code(400);
    }
  },
  async refreshToken(request, h) {
    try {
      const token = request.headers.authorization.split(" ")[1];
      const datas = await decryptJwt.decryptRefreshToken(token);
      const { type, accessToken } = await usersServicesAuth.refreshToken(datas);
      return h.response({ type, accessToken }).code(200);
    } catch (error) {
      return h.response({ error: error.message }).code(400);
    }
  },
};
