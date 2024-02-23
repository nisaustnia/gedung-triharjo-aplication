import { adminController } from "../../controller/admin/admin.controller.js";

export const adminRoutes = [
  {
    method: "GET",
    path: "/admin/notif",
    handler: adminController.notif,
  },
  {
    method: "GET",
    path: "/admin/notif/{idNotif}",
    handler: adminController.readNotif,
  },
  {
    method: "GET",
    path: "/admin/notif/count",
    handler: adminController.notRead,
  },
  {
    method: "GET",
    path: "/admin/payment",
    handler: adminController.listPayment,
  },

  {
    method: "GET",
    path: "/admin/payment/{bookingCode}",
    handler: adminController.getPayment,
  },
  {
    method: "GET",
    path: "/admin/payment/{bookingCode}/accept",
    handler: adminController.acceptPayment,
  },
  {
    method: "DELETE",
    path: "/admin/payment/{bookingCode}",
    handler: adminController.deletePayment,
  },
  {
    method: "DELETE",
    path: "/admin/user",
    handler: adminController.deleteUser,
  },
  {
    method: "GET",
    path: "/admin/user",
    handler: adminController.listUser,
  },
  {
    method: "PUT",
    path: "/admin/user/change",
    handler: adminController.changeRole,
  },
];
