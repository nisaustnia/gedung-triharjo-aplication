import { pemesananControllerEvent } from "../../controller/event/pemesananController.event.js";

export const pemesananRoutes = [
  {
    method: "POST",
    path: "/event/{idEvent}",
    handler: pemesananControllerEvent.pemesanan,
  },
  // {
  //   method: "POST",
  //   path: "/event/{idEvent}/check",
  //   handler: pemesananControllerEvent.checkTanggal,
  // },
  // {
  //   method: "GET",
  //   path: "/event/{idEvent}/check",
  //   handler: pemesananControllerEvent.checkDate,
  // },
  {
    method: "GET",
    path: "/payment",
    handler: pemesananControllerEvent.payment,
  },
  {
    method: "GET",
    path: "/user/payment",
    handler: pemesananControllerEvent.listPayment,
  },
  {
    method: "GET",
    path: "/payment/{bookingCode}",
    handler: pemesananControllerEvent.getPayment,
  },
  {
    method: "DELETE",
    path: "/payment/{bookingCode}",
    handler: pemesananControllerEvent.deletePayment,
  },
  {
    method: "GET",
    path: "/event/{idEvent}/check/{year}/{month}/{day}",
    handler: pemesananControllerEvent.checkDate,
  },
  {
    method: "GET",
    path: "/event/{idEvent}/check",
    handler: pemesananControllerEvent.checkDate,
  },
  {
    method: "GET",
    path: "/event/{idEvent}/{year}/{month}",
    handler: pemesananControllerEvent.checkDate,
  },
];
