import jwt from "jsonwebtoken";
import dotenv from "dotenv";
dotenv.config();

export const decryptJwt = {
  async decryptAccessToken(token) {
    const result = await jwt.verify(
      token,
      process.env.ACCESSTOKEN,
      (err, decoded) => {
        if (err) {
          throw new Error("TOKEN YANG DIMASUKKAN SALAH");
        }
        return decoded;
      }
    );
    return result;
  },
  async decryptRefreshToken(token) {
    const result = await jwt.verify(
      token,
      process.env.REFRESHTOKEN,
      (err, decoded) => {
        if (err) {
          throw new Error("token yang dimasukkan salah");
        }
        return decoded;
      }
    );
    return result;
  },
};
