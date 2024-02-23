import Joi from "joi";

export const pengecekanInput = {
  async sesi(inputUser) {
    try {
      const schema = Joi.object({
        time: Joi.string()
          .regex(/^([01]\d|2[0-3]):([0-5]\d)$/)
          .required(),
        dateMulai: Joi.date().iso().required(),
        jumlahHari: Joi.number().min(1).max(999),
      });
      const { error, value } = schema.validate(JSON.parse(inputUser));
      if (!error) {
        value.jumlahHari = undefined;
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
        jumlahHari: Joi.number().min(1).max(999),
      });
      const { error, value } = schema.validate(inputUser);
      if (!error) {
        value.jumlahHari = undefined;
        const year = value.dateMulai.getFullYear();
        const month = String(value.dateMulai.getMonth() + 1).padStart(2, "0"); // Penambahan 1 karena bulan dimulai dari 0
        const day = String(value.dateMulai.getDate()).padStart(2, "0");
        value.dateMulai = `${year}-${month}-${day}`;
      }
      return { error, value };
    }
  },
  async bulan(inputUser) {
    try {
      const schema = Joi.object({
        time: Joi.string().regex(/^([01]\d|2[0-3]):([0-5]\d)$/),
        dateMulai: Joi.date().iso().required(),
        jumlahHari: Joi.number().min(1).max(999),
      });
      const { error, value } = schema.validate(JSON.parse(inputUser));
      if (!error) {
        value.time = undefined;
        value.jumlahHari = undefined;
        const year = value.dateMulai.getFullYear();
        const month = String(value.dateMulai.getMonth() + 1).padStart(2, "0"); // Penambahan 1 karena bulan dimulai dari 0
        const day = String(value.dateMulai.getDate()).padStart(2, "0");
        value.dateMulai = `${year}-${month}-${day}`;
      }
      return { error, value };
    } catch (err) {
      const schema = Joi.object({
        time: Joi.string().regex(/^([01]\d|2[0-3]):([0-5]\d)$/),
        dateMulai: Joi.date().iso().required(),
        jumlahHari: Joi.number().min(1).max(999),
      });
      const { error, value } = schema.validate(inputUser);
      if (!error) {
        value.time = undefined;
        value.jumlahHari = undefined;
        const year = value.dateMulai.getFullYear();
        const month = String(value.dateMulai.getMonth() + 1).padStart(2, "0"); // Penambahan 1 karena bulan dimulai dari 0
        const day = String(value.dateMulai.getDate()).padStart(2, "0");
        value.dateMulai = `${year}-${month}-${day}`;
      }
      return { error, value };
    }
  },
  async hari(inputUser) {
    try {
      const schema = Joi.object({
        time: Joi.string().regex(/^([01]\d|2[0-3]):([0-5]\d)$/),
        dateMulai: Joi.date().iso().required(),
        jumlahHari: Joi.number().min(1).max(999).required(),
      });
      const { error, value } = schema.validate(JSON.parse(inputUser));
      if (!error) {
        value.time = undefined;
        const year = value.dateMulai.getFullYear();
        const month = String(value.dateMulai.getMonth() + 1).padStart(2, "0"); // Penambahan 1 karena bulan dimulai dari 0
        const day = String(value.dateMulai.getDate()).padStart(2, "0");
        value.dateMulai = `${year}-${month}-${day}`;
      }
      return { error, value };
    } catch (err) {
      const schema = Joi.object({
        time: Joi.string().regex(/^([01]\d|2[0-3]):([0-5]\d)$/),
        dateMulai: Joi.date().iso().required(),
        jumlahHari: Joi.number().min(1).max(999).required(),
      });
      const { error, value } = schema.validate(inputUser);
      if (!error) {
        value.time = undefined;
        const year = value.dateMulai.getFullYear();
        const month = String(value.dateMulai.getMonth() + 1).padStart(2, "0"); // Penambahan 1 karena bulan dimulai dari 0
        const day = String(value.dateMulai.getDate()).padStart(2, "0");
        value.dateMulai = `${year}-${month}-${day}`;
      }
      return { error, value };
    }
  },
};
