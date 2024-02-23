import { Notification } from "../../../model/Notification.model.js";
import { Users } from "../../../model/Users.model.js";
import { userControlInputControl } from "../../middleware/userControl.input.control.js";
import { userControlServicesControl } from "../../services/userControl/userControl.services.control.js";
import { decryptJwt } from "../../utils/decryptJwt.utils.js";

export const usersControlControllerControl = {
  async notif(request, h) {
    try {
      const token = request.headers.authorization.split(" ")[1];
      const datas = await decryptJwt.decryptAccessToken(token);

      const result = await Notification.getData(datas.idUser);
      const notReadYet = await Notification.totalNotRead(datas.idUser);

      const { result: type } = await Users.getUserType(datas.idUser);
      return h
        .response({
          token: "token verified",
          type,
          notReadYet,
          result,
        })
        .code(200);
    } catch (error) {
      return h.response({ error: error.message }).code(400);
    }
  },
  async notRead(request, h) {
    try {
      const token = request.headers.authorization.split(" ")[1];
      const datas = await decryptJwt.decryptAccessToken(token);

      const notReadYet = await Notification.totalNotRead(datas.idUser);

      const { result: type } = await Users.getUserType(datas.idUser);
      return h
        .response({
          token: "token verified",
          type,
          notReadYet,
        })
        .code(200);
    } catch (error) {
      return h.response({ error: error.message }).code(400);
    }
  },
  async readNotif(request, h) {
    try {
      const token = request.headers.authorization.split(" ")[1];
      const datas = await decryptJwt.decryptAccessToken(token);

      const { idNotif } = request.params;
      const result = await Notification.read(datas.idUser, idNotif);

      const { result: type } = await Users.getUserType(datas.idUser);
      return h
        .response({
          token: "token verified",
          type,
          result,
        })
        .code(200);
    } catch (error) {
      return h.response({ error: error.message }).code(400);
    }
  },
  async getUser(request, h) {
    try {
      const token = request.headers.authorization.split(" ")[1];
      const datas = await decryptJwt.decryptAccessToken(token);
      const { result, type } = await userControlServicesControl.getUser(
        datas.idUser
      );
      return h
        .response({
          token: "token verified",
          type,
          result,
        })
        .code(200);
    } catch (error) {
      return h.response({ error: error.message }).code(400);
    }
  },
  async editUser(request, h) {
    try {
      const token = request.headers.authorization.split(" ")[1];
      const datas = await decryptJwt.decryptAccessToken(token);
      const { value } = await userControlInputControl.editInput(
        request.payload
      );
      const { result, type } = await userControlServicesControl.editUser(
        value,
        datas.idUser
      );
      return h.response({ token: "token verified", type, result }).code(200);
    } catch (error) {
      console.error(error);
      return h.response({ error: error.message }).code(400);
    }
  },
};
