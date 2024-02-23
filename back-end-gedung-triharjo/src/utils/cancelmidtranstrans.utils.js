import dotenv from "dotenv";
dotenv.config({ path: "../../.env" });
import axios from "axios";
import { DeletePemesanan } from "../../model/DeletePemesanan.model.js";

async function cancelMidtransTransUtils(bookingCode) {
  const serverKey = process.env.SERVERKEY;
  const authString = `${serverKey}:`;
  const base64AuthString = Buffer.from(authString).toString("base64");
  await DeletePemesanan.addToTable(bookingCode);
  const result = await axios.post(
    `https://api.sandbox.midtrans.com/v2/${bookingCode}/cancel`,
    {},
    {
      headers: {
        Authorization: `Basic ${base64AuthString}`,
        Accept: "application/json",
        "Content-Type": "application/json",
      },
    }
  );
  return result;
}
export default cancelMidtransTransUtils;
