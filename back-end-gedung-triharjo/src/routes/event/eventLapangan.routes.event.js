import { eventLapanganControllerEvent } from "../../controller/event/eventLapangan.controller.event.js";

export const eventLapanganRoutesEvent = [
  {
    method: "GET",
    path: "/event/lapangan",
    handler: eventLapanganControllerEvent.listLapangan,
  },
];
