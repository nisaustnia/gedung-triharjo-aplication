import { eventBerlanggananControllerEvent } from "../../controller/event/eventBerlangganan.constroller.event.js";

export const eventBerlanggananRoutesEvent = [
  {
    method: "GET",
    path: "/event/berlangganan",
    handler: eventBerlanggananControllerEvent.listBerlangganan,
  },
];
