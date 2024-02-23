import { usersControlControllerControl } from "../../controller/userControl/usersControl.controller.control.js";

export const usersControlRoutesControl = [
  {
    method: "PUT",
    path: "/user",
    handler: usersControlControllerControl.editUser,
  },
  {
    method: "GET",
    path: "/user",
    handler: usersControlControllerControl.getUser,
  },
  {
    method: "GET",
    path: "/notif",
    handler: usersControlControllerControl.notif,
  },
  {
    method: "GET",
    path: "/notif/{idNotif}",
    handler: usersControlControllerControl.readNotif,
  },
  {
    method: "GET",
    path: "/notif/count",
    handler: usersControlControllerControl.notRead,
  },
];
