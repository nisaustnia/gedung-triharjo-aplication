import { EventModelData } from "../../../model/Databases.model.js";
import { Users } from "../../../model/Users.model.js";

export const eventServicesEvent = {
  async listEvent(idUser) {
    const isTriharjo = await EventModelData.isWargaTriharjo(idUser);
    const { error, result, column } = await EventModelData.listEvent(
      isTriharjo.result
    );
    if (error) throw new Error(error);
    // get type user
    const { result: type } = await Users.getUserType(idUser);
    return [type, result, column];
  },
  async getEvent(idUser, idEvent) {
    const { error: error1, result: wargaTriharjo } =
      await EventModelData.isWargaTriharjo(idUser);
    if (error1) throw new Error(error1);
    const { error, result, column } = await EventModelData.getEventById(
      idEvent,
      wargaTriharjo
    );
    if (error) throw new Error(error);
    // get type user
    const { result: type } = await Users.getUserType(idUser);
    return [type, result, column];
  },
  async listEventJenis(idUser) {
    const { error: error1, result: wargaTriharjo } =
      await EventModelData.isWargaTriharjo(idUser);

    if (error1) throw new Error(error1);
    const {
      error: error2,
      result,
      column,
    } = await EventModelData.listEventJenis(wargaTriharjo);
    if (error2) throw new Error(error2);
    // get type user
    const { result: type } = await Users.getUserType(idUser);
    return [type, result, column];
  },
  async listPerorangan(idUser) {
    const { error: error1, result: wargaTriharjo } =
      await EventModelData.isWargaTriharjo(idUser);

    if (error1) throw new Error(error1);
    const {
      error: error2,
      result,
      column,
    } = await EventModelData.listPerorangan(wargaTriharjo);
    if (error2) throw new Error(error2);
    // get type user
    const { result: type } = await Users.getUserType(idUser);
    return [type, result, column];
  },
  async listOrganisasi(idUser) {
    const { error: error1, result: wargaTriharjo } =
      await EventModelData.isWargaTriharjo(idUser);

    if (error1) throw new Error(error1);
    const {
      error: error2,
      result,
      column,
    } = await EventModelData.listOrganisasi(wargaTriharjo);
    if (error2) throw new Error(error2);
    // get type user
    const { result: type } = await Users.getUserType(idUser);
    return [type, result, column];
  },
};
