export default function formatedDate(inputDate) {
  // Split tanggal menjadi komponen bulan, hari, dan tahun
  const [month, day, year] = inputDate.split("/");

  // Format tanggal baru dalam bentuk "YYYY-MM-DD"
  const formattedDate = `${year}-${month.padStart(2, "0")}-${day.padStart(
    2,
    "0"
  )}`;

  return formattedDate;
}
