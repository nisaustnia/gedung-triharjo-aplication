import { eventControllerEvent } from "../../controller/event/event.controller.event.js";

export const eventRoutesEvent = [
  {
    method: "GET",
    path: "/event",
    handler: eventControllerEvent.listEvent,
  },
  {
    method: "GET",
    path: "/event/{idEvent}",
    handler: eventControllerEvent.getEvent,
  },
  {
    method: "GET",
    path: "/event/jenis",
    handler: eventControllerEvent.listEventJenis,
  },
  {
    method: "GET",
    path: "/event/perorangan",
    handler: eventControllerEvent.listPerorangan,
  },
  {
    method: "GET",
    path: "/event/list/{jenis}",
    handler: eventControllerEvent.listPemesananDate,
  },
  {
    method: "GET",
    path: "/event/organisasi",
    handler: eventControllerEvent.listOrganisasi,
  },
];
