import { google } from "googleapis";

export async function googlesheetutils(pathCredentials, datas) {
  const auth = new google.auth.GoogleAuth({
    credentials: {
      type: "service_account",
      project_id: "gtrproject",
      private_key_id: "de00f42a7c83aeb702b4c76adec01699f4cc78b9",
      private_key:
        "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCuJ9YD1MW+/PRH\nkrZGGzxqRJFFwCWOj3SgRjpxwFVA3Oy252I+FB1McptcL71LX/u285XO3JTE/bu+\neRx8WnY2EJ7Nva8ZLN1cJIpKk9/xpJ2rqZYKPzm0HotI67ML0T8XkwvwucK/sdcV\nHNGJFjb4DTitCWc1ke9cCqT2Xvd+PhOlZ8MSFrwRNLdKoMuz3P1F3k/q6kBd34ea\n24GVhvGMI+Rp1NUp/nDkQjOA6HeCwXjlw50jrOFjrKKnpdhXPdEPGMumk9VUUyqW\nsNVf0eipgGVbtykrFUus6NT0AAfiMg8tmQkvs4CZzzvdCzb8a7GvmAGT2U6xhDsC\nq9t4rQinAgMBAAECggEAGW9Y+uNC5DNma+OZ+mA08SJFg0XeVlVOR7AqDf30lY4O\nhmIBv6ZJZyZf2VVhlJYWmbA2o2kk0yZpmpZumhzOIfRIdSzsW0VpqPDvP5gcP1r2\n6iDQ+Hsmbs99MS+3TRUI3WUM++Htdvi+vGcilR5o9c5chi0W5USEjFFDqXXSOJ4T\nTPntb1dRbjeZYRPyIhOZKO6Gx3rjMVRKkXoumm2cD67az0xG1woODLr69PpIpYiG\nEwHbyoJ/zeMOXPxpV1LYNkZEKFstk6s6sX7iuR5Kx0ZiEz0mSSAbN+5C/N7bvsse\nIaVsS9Q+z0fg8rdx/SZSd4jVKOlV3VlYbU5YRXfsPQKBgQDrqbBtgyAFhqz5IQGe\n7foZYuEBwRctKmHvnyn6taUEJs9kjHtFvXPIfHIIKgsoUo9eT0wuNyGgGQ7+Q0ZL\nz4cI8azcPCYRdOX/yEo9hd1Y0bG9Ch2Ao0+gMWthcGJDKq/OLzw0UzHjTJMcetXk\ng09fyllyDsx443fLh5X0+hpCFQKBgQC9L1EL1s9t3wHE6UaBi0eK7a7To7OvEkkp\nJ1YbTIT1UXXCJpQJblz5IYKkC6J9zFWvxsj8yeZpHpGZiDSjtnKhuyunIZcaXDqR\nPNi2ebxl3P3eSf+S1PpBvaWgQbtAu/qj0572cpqoj6Pq/7f/ej0wDVr/95BFdvwI\nYk+5KjKaywKBgQCPs7K0pL+y/vOdGsZdPmpCbqwcIL1cOjrsHlc/3OHaDTxr6MoG\ntcbTmycB2XliRi3MaXhfuhiUApPE8gr8kXibOJua1Ea2YF0bwuuaZnWaAoxqZK+m\n0G7ulRQQn7IbmP0JMn54vb5vBzOxqymgpX2SQNaYGXQPx002W+BSOOwoHQKBgGbJ\nSXhsOoEQc+6fa55ApRs3bhAw1hRdlABXDfKBDZAXtSpKOY4yNzNoYIluhNdiaH+7\nOkIWFCiy4hqPpUH5g6iZf+srVeSNjYiRjZD+7TxO6GOYwtHtAxcqyc0bSXivaUsP\nVEPEGoFQoZexXi/hI1NzPijqQalsLx0DBRuucJYnAoGBAIftyiNXKPegEpbkDm9+\n88mdzw3Eft19/I245RzMyafnm1V4T/+PJmVosHRXiBoX4Bf/9Pm2xnk8AkD2tfPc\n2hYlY94yup1hA43+ZT3u0JJki1qUwv1yRlrvobZVJKm5y6RZ5zUv3VujCoeoeKWd\neYUmxP02oud5vzDCZ0WrF41p\n-----END PRIVATE KEY-----\n",
      client_email: "gtrproject@gtrproject.iam.gserviceaccount.com",
      client_id: "108510415762242829296",
      auth_uri: "https://accounts.google.com/o/oauth2/auth",
      token_uri: "https://oauth2.googleapis.com/token",
      auth_provider_x509_cert_url: "https://www.googleapis.com/oauth2/v1/certs",
      client_x509_cert_url:
        "https://www.googleapis.com/robot/v1/metadata/x509/gtrproject%40gtrproject.iam.gserviceaccount.com",
      universe_domain: "googleapis.com",
    },
    scopes: "https://www.googleapis.com/auth/spreadsheets",
  });
  const client = await auth.getClient();
  const spreadsheetId = "1fdEj1EfeQFhpi2QVGo7LGLa6ZhHextwrmjBAml_cMeU";
  const googleSheet = google.sheets({ version: "v4", auth: client });
  const result = await googleSheet.spreadsheets.values.append({
    auth,
    spreadsheetId,
    range: "Sheet1!A:M",
    valueInputOption: "USER_ENTERED",
    resource: { values: [datas] },
  });
  return result;
}
