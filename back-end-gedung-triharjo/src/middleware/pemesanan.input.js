import Joi from "joi";

export const pemesananInput = {
  pemesananSesi(inputUser) {
    try {
      const schema = Joi.object({
        time: Joi.string()
          .regex(/^([01]\d|2[0-3]):([0-5]\d)$/)
          .required(),
        dateMulai: Joi.date().iso().required(),
        jumlahHari: Joi.number().min(1).max(999).required(),
        tipeHarga: Joi.string().valid("perorangan", "organisasi").required(),
        paymentType: Joi.string()
          .valid("bri", "mandiri", "bca", "mandiri", "bni", "cimb")
          .required(),
      });
      const { error, value } = schema.validate(JSON.parse(inputUser));
      if (!error) {
        value.jumlahHari = 1;
        const year = value.dateMulai.getFullYear();
        const month = String(value.dateMulai.getMonth() + 1).padStart(2, "0"); // Penambahan 1 karena bulan dimulai dari 0
        const day = String(value.dateMulai.getDate()).padStart(2, "0");
        value.dateMulai = `${year}-${month}-${day}`;
      }
      return { error, value };
    } catch (err) {
      const schema = Joi.object({
        time: Joi.string()
          .regex(/^([01]\d|2[0-3]):([0-5]\d)$/)
          .required(),
        dateMulai: Joi.date().iso().required(),
        jumlahHari: Joi.number().min(1).max(999).required(),
        tipeHarga: Joi.string().valid("perorangan", "organisasi").required(),
        paymentType: Joi.string()
          .valid("bri", "mandiri", "bca", "mandiri", "bni", "cimb")
          .required(),
      });
      const { error, value } = schema.validate(inputUser);
      if (!error) {
        value.jumlahHari = 1;
        const year = value.dateMulai.getFullYear();
        const month = String(value.dateMulai.getMonth() + 1).padStart(2, "0"); // Penambahan 1 karena bulan dimulai dari 0
        const day = String(value.dateMulai.getDate()).padStart(2, "0");
        value.dateMulai = `${year}-${month}-${day}`;
      }
      return { error, value };
    }
  },
  pemesananBulan(inputUser) {
    try {
      const schema = Joi.object({
        time: Joi.string().regex(/^([01]\d|2[0-3]):([0-5]\d)$/),
        dateMulai: Joi.date().iso().required(),
        jumlahHari: Joi.number().min(1).max(999),
        tipeHarga: Joi.string().valid("perorangan", "organisasi").required(),
        paymentType: Joi.string()
          .valid("bri", "mandiri", "bca", "mandiri", "bni", "cimb")
          .required(),
      });

      const { error, value } = schema.validate(JSON.parse(inputUser));
      if (!error) {
        const year = value.dateMulai.getFullYear();
        const month = String(value.dateMulai.getMonth() + 1).padStart(2, "0"); // Penambahan 1 karena bulan dimulai dari 0
        const day = String(value.dateMulai.getDate()).padStart(2, "0");
        value.dateMulai = `${year}-${month}-${day}`;
        value.time = undefined;
        value.jumlahHari = undefined;
      }
      return { error, value };
    } catch (err) {
      const schema = Joi.object({
        time: Joi.string().regex(/^([01]\d|2[0-3]):([0-5]\d)$/),
        dateMulai: Joi.date().iso().required(),
        jumlahHari: Joi.number().min(1).max(999),
        tipeHarga: Joi.string().valid("perorangan", "organisasi").required(),
        paymentType: Joi.string()
          .valid("bri", "mandiri", "bca", "mandiri", "bni", "cimb")
          .required(),
      });
      const { error, value } = schema.validate(inputUser);
      if (!error) {
        const year = value.dateMulai.getFullYear();
        const month = String(value.dateMulai.getMonth() + 1).padStart(2, "0"); // Penambahan 1 karena bulan dimulai dari 0
        const day = String(value.dateMulai.getDate()).padStart(2, "0");
        value.dateMulai = `${year}-${month}-${day}`;
        value.time = undefined;
        value.jumlahHari = undefined;
      }
      return { error, value };
    }
  },
  pemesananHari(inputUser) {
    try {
      const schema = Joi.object({
        time: Joi.string().regex(/^([01]\d|2[0-3]):([0-5]\d)$/),
        dateMulai: Joi.date().iso().required(),
        jumlahHari: Joi.number().min(1).max(999).required(),
        tipeHarga: Joi.string().valid("perorangan", "organisasi").required(),
        paymentType: Joi.string()
          .valid("bri", "mandiri", "bca", "mandiri", "bni", "cimb")
          .required(),
      });
      const { error, value } = schema.validate(JSON.parse(inputUser));
      if (!error) {
        const year = value.dateMulai.getFullYear();
        const month = String(value.dateMulai.getMonth() + 1).padStart(2, "0"); // Penambahan 1 karena bulan dimulai dari 0
        const day = String(value.dateMulai.getDate()).padStart(2, "0");
        value.dateMulai = `${year}-${month}-${day}`;
        value.time = undefined;
      }
      return { error, value };
    } catch (err) {
      const schema = Joi.object({
        time: Joi.string().regex(/^([01]\d|2[0-3]):([0-5]\d)$/),
        dateMulai: Joi.date().iso().required(),
        jumlahHari: Joi.number().min(1).max(999).required(),
        tipeHarga: Joi.string().valid("perorangan", "organisasi").required(),
        paymentType: Joi.string()
          .valid("bri", "mandiri", "bca", "mandiri", "bni", "cimb")
          .required(),
      });
      const { error, value } = schema.validate(inputUser);
      if (!error) {
        const year = value.dateMulai.getFullYear();
        const month = String(value.dateMulai.getMonth() + 1).padStart(2, "0"); // Penambahan 1 karena bulan dimulai dari 0
        const day = String(value.dateMulai.getDate()).padStart(2, "0");
        value.dateMulai = `${year}-${month}-${day}`;
        value.time = undefined;
      }

      return { error, value };
    }
  },
};
