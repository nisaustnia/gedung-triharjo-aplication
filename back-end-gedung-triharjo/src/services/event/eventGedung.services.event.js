import { EventGedungData } from "../../../model/Databases.model.js";
import { Users } from "../../../model/Users.model.js";

export const eventGedungServicesEvent = {
  async listGedung(idUser) {
    const { error: error1, result: wargaTriharjo } =
      await EventGedungData.isWargaTriharjo(idUser);
    if (error1) throw new Error(error1);
    const {
      error: error2,
      result,
      column,
    } = await EventGedungData.listEvent(wargaTriharjo);
    if (error2) throw new Error(error2);
    // get type user
    const { result: type } = await Users.getUserType(idUser);
    return [type, result, column];
  },
};
