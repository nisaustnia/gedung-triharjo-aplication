import axios from "axios";

// Dapatkan Server Key dan gantilah Your_Server_Key
const serverKey = "SB-Mid-server-O4pyTFQmSUhtdioyRN9AJ9B5";

// Buat Authorization Header
const authString = `${serverKey}:`;
const base64AuthString = Buffer.from(authString).toString("base64");

// Lakukan permintaan HTTP dengan Axios
axios
  .post(
    "https://api.sandbox.midtrans.com/v2/charge",
    {
      payment_type: "gopay",
      transaction_details: {
        order_id: "order03",
        gross_amount: 275000,
      },
      customer_details: {
        first_name: "Budi",
        last_name: "Utomo",
        email: "budi.utomo@midtrans.com",
        phone: "081223323423",
      },
    },
    {
      headers: {
        Authorization: `Basic ${base64AuthString}`,
        Accept: "application/json",
        "Content-Type": "application/json", // Tambahkan header lain jika diperlukan
      },
    }
  )
  .then((response) => {
    console.log("Response:", response.data);
  })
  .catch((error) => {
    console.error("Error:", error.response.data);
  });
