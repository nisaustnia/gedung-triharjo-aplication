import { eventLapanganServicesEvent } from "../../services/event/eventLapangan.services.event.js";
import { decryptJwt } from "../../utils/decryptJwt.utils.js";

export const eventLapanganControllerEvent = {
  async listLapangan(request, h) {
    try {
      const token = request.headers.authorization.split(" ")[1];
      const datas = await decryptJwt.decryptAccessToken(token);
      const [type, result, column] =
        await eventLapanganServicesEvent.listLapangan(datas.idUser);
      return h
        .response({ token: "token verified", type, column, result })
        .code(200);
    } catch (error) {
      return h.response({ error: error.message }).code(400);
    }
  },
};
