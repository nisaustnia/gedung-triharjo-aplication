import { eventGedungServicesEvent } from "../../services/event/eventGedung.services.event.js";
import { decryptJwt } from "../../utils/decryptJwt.utils.js";

export const eventGedungControllerEvent = {
  async listGedung(request, h) {
    try {
      const token = request.headers.authorization.split(" ")[1];
      const datas = await decryptJwt.decryptAccessToken(token);
      const [type, result, column] = await eventGedungServicesEvent.listGedung(
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
