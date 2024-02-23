import { usersControllerAuth } from "../../controller/authentication/users.controller.auth.js";

export const usersRoutesAuth = [
  {
    method: "POST",
    path: "/register",
    handler: usersControllerAuth.register,
  },
  {
    method: "POST",
    path: "/login",
    handler: usersControllerAuth.login,
  },
  {
    method: "GET",
    path: "/refreshtoken",
    handler: usersControllerAuth.refreshToken,
  },
];
