import { eventBalaiControllerEvent } from "../../controller/event/eventBalai.controller.event.js";

export const eventBalaiRoutesEvent = [
  {
    method: "GET",
    path: "/event/balai",
    handler: eventBalaiControllerEvent.listBalai,
  },
];
