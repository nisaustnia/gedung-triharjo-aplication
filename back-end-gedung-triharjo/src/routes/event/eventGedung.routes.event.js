import { eventGedungControllerEvent } from "../../controller/event/eventGedung.controller.event.js";

export const eventGedungRoutesEvent = [
  {
    method: "GET",
    path: "/event/gedung",
    handler: eventGedungControllerEvent.listGedung,
  },
];
