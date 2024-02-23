import { eventBalaiServicesEvent } from "../../services/event/eventBalai.service.event.js";
import { decryptJwt } from "../../utils/decryptJwt.utils.js";

export const eventBalaiControllerEvent = {
  async listBalai(request, h) {
    try {
      const token = request.headers.authorization.split(" ")[1];
      const datas = await decryptJwt.decryptAccessToken(token);
      console.log(datas);
      const [type, result, column] = await eventBalaiServicesEvent.listBalai(
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
