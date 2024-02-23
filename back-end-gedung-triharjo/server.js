import Hapi from "@hapi/hapi";
import { usersRoutesAuth } from "./src/routes/authentication/users.routes.auth.js";
import { eventGedungRoutesEvent } from "./src/routes/event/eventGedung.routes.event.js";
import { eventBerlanggananRoutesEvent } from "./src/routes/event/eventBerlangganan.routes.event.js";
import { eventBalaiRoutesEvent } from "./src/routes/event/eventBalai.routes.event.js";
import { eventLapanganRoutesEvent } from "./src/routes/event/eventLapangan.routes.event.js";
import { eventRoutesEvent } from "./src/routes/event/event.routes.event.js";
import { usersControlRoutesControl } from "./src/routes/usersControl/usersControl.routes.control.js";
import { pemesananRoutes } from "./src/routes/event/pemesanan.routes.js";
import { getNotificationRoutes } from "./src/routes/midtrans/getnotification.routes.js";
import { adminRoutes } from "./src/routes/admin/admin.routes.js";

const init = async () => {
  const server = Hapi.server({
    port: 8080,
    host: "localhost",
  });

  server.route([
    {
      method: "*",
      path: "/{any*}",
      handler: (request, h) => {
        return h
          .response({
            error: "salah route",
          })
          .code(404);
      },
    },
    ...usersRoutesAuth,
    ...adminRoutes,
    ...eventGedungRoutesEvent,
    ...eventBerlanggananRoutesEvent,
    ...eventBalaiRoutesEvent,
    ...eventLapanganRoutesEvent,
    ...eventRoutesEvent,
    ...usersControlRoutesControl,
    ...pemesananRoutes,
    ...getNotificationRoutes,
  ]);

  await server.start();
  console.log("server berjalan pada port 8080");
};

process.on("unhandledRejection", (err) => {
  console.log(err);
  process.exit(1);
});

init();
