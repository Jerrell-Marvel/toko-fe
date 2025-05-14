export const normalizeKeyword = (keyword) => {
  if (!keyword) return "";

  return keyword
    .trim() // Hapus spasi di awal/akhir
    .replace(/[^\w\s]/gi, "") // Hapus karakter aneh (kecuali huruf, angka, dan spasi)
    .toLowerCase(); // Normalisasi ke huruf kecil
};
