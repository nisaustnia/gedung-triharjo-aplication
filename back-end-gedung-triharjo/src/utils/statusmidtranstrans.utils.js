import dotenv from "dotenv";
dotenv.config({ path: "../../.env" });
import axios from "axios";

async function statusMidtransTransUtils(bookingCode) {
  const serverKey = process.env.SERVERKEY;
  const authString = `${serverKey}:`;
  const base64AuthString = Buffer.from(authString).toString("base64");
  const result = await axios.get(
    `https://api.sandbox.midtrans.com/v2/${bookingCode}/status`,
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
export default statusMidtransTransUtils;
