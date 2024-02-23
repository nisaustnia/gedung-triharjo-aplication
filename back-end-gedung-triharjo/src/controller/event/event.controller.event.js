import { EventModelData } from "../../../model/Databases.model.js";
import { Users } from "../../../model/Users.model.js";
import { pemesananInput } from "../../middleware/pemesanan.input.js";
import { eventServicesEvent } from "../../services/event/event.services.event.js";
import { decryptJwt } from "../../utils/decryptJwt.utils.js";

export const eventControllerEvent = {
  async listPemesananDate(request, h) {
    try {
      const token = request.headers.authorization.split(" ")[1];
      const datas = await decryptJwt.decryptAccessToken(token);
      const { jenis } = request.params;
    } catch (error) {}
  },
  async getEvent(request, h) {
    try {
      const token = request.headers.authorization.split(" ")[1];
      const datas = await decryptJwt.decryptAccessToken(token);
      const { idEvent } = request.params;
      const [type, result, column] = await eventServicesEvent.getEvent(
        datas.idUser,
        idEvent
      );
      return h
        .response({ token: "token verified", type, column, result })
        .code(200);
    } catch (error) {
      return h.response({ error: error.message }).code(400);
    }
  },
  async listEvent(request, h) {
    try {
      const token = request.headers.authorization.split(" ")[1];
      const datas = await decryptJwt.decryptAccessToken(token);
      const [type, result, column] = await eventServicesEvent.listEvent(
        datas.idUser
      );
      return h
        .response({ token: "token verified", type, column, result })
        .code(200);
    } catch (error) {
      return h.response({ error: error.message }).code(400);
    }
  },
  async listEventJenis(request, h) {
    try {
      const token = request.headers.authorization.split(" ")[1];
      const datas = await decryptJwt.decryptAccessToken(token);
      const [type, result, column] = await eventServicesEvent.listEventJenis(
        datas.idUser
      );
      return h
        .response({ token: "token verified", type, column, result })
        .code(200);
    } catch (error) {
      return h.response({ error: error.message }).code(400);
    }
  },
  async listPerorangan(request, h) {
    try {
      const token = request.headers.authorization.split(" ")[1];
      const datas = await decryptJwt.decryptAccessToken(token);
      const [type, result, column] = await eventServicesEvent.listPerorangan(
        datas.idUser
      );
      return h
        .response({ token: "token verified", type, column, result })
        .code(200);
    } catch (error) {
      return h.response({ error: error.message }).code(400);
    }
  },
  async listOrganisasi(request, h) {
    try {
      const token = request.headers.authorization.split(" ")[1];
      const datas = await decryptJwt.decryptAccessToken(token);
      const [type, result, column] = await eventServicesEvent.listOrganisasi(
        datas.idUser
      );
      return h
        .response({ token: "token verified", type, column, result })
        .code(200);
    } catch (error) {
      return h.response({ error: error.message }).code(400);
    }
  },
};
