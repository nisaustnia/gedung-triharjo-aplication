import { eventBerlanggananServicesEvent } from "../../services/event/eventBerlangganan.service.event.js";
import { decryptJwt } from "../../utils/decryptJwt.utils.js";

export const eventBerlanggananControllerEvent = {
  async listBerlangganan(request, h) {
    try {
      const token = request.headers.authorization.split(" ")[1];
      const datas = await decryptJwt.decryptAccessToken(token);
      const [type, result, column] =
        await eventBerlanggananServicesEvent.listBerlangganan(datas.idUser);
      return h
        .response({ token: "token verified", type, column, result })
        .code(200);
    } catch (error) {
      return h.response({ error: error.message }).code(400);
    }
  },
};
