export function isJson(data) {
  try {
    JSON.parse(data);
  } catch (error) {
    throw new Error("data yang dimasukkan harus json");
  }
}
