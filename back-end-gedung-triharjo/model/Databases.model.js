import { EventModel } from "./Event.model.js";
import { EventBalai } from "./EventBalai.model.js";
import { EventBerlangganan } from "./EventBerlangganan.model.js";
import { EventGedung } from "./EventGedung.model.js";
import { EventLapangan } from "./EventLapangan.model.js";
import { CheckDate } from "./CheckDate.model.js";
import { AdminModel } from "./Admin.model.js";

// event data
const EventModelData = new EventModel();
const EventBalaiData = new EventBalai();
const EventBerlanggananData = new EventBerlangganan();
const EventGedungData = new EventGedung();
const EventLapanganData = new EventLapangan();
const AdminModelData = new AdminModel();
const CheckDateData = new CheckDate();

export {
  EventModelData,
  EventBalaiData,
  EventBerlanggananData,
  EventGedungData,
  EventLapanganData,
  AdminModelData,
  CheckDateData,
};
