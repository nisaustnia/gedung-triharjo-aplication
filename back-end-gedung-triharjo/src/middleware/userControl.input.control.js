import Joi from "joi";

export const userControlInputControl = {
  editInput(inputUser) {
    try {
      const schema = Joi.object({
        nama: Joi.string().max(50).min(1),
        noKTP: Joi.string()
          .max(50)
          .min(1)
          .pattern(/^[0-9]+$/),
        dukuh: Joi.string().max(255).min(1),
        kelurahan: Joi.string().max(255).min(1),
        kecamatan: Joi.string().max(255).min(1),
        rt: Joi.string().max(255).min(1),
        rw: Joi.string().max(255).min(1),
        email: Joi.string().email().max(50).min(1),
        password: Joi.string().max(255).min(1),
        gender: Joi.string()
          .pattern(/^[lp]$/)
          .max(1)
          .min(1),
        noTelp: Joi.string()
          .max(50)
          .min(1)
          .pattern(/^[0-9]+$/),
      });
      const { error, value } = schema.validate(JSON.parse(inputUser));
      return { error, value };
    } catch (err) {
      const schema = Joi.object({
        nama: Joi.string().max(50).min(1),
        noKTP: Joi.string()
          .max(50)
          .min(1)
          .pattern(/^[0-9]+$/),
        dukuh: Joi.string().max(255).min(1),
        kelurahan: Joi.string().max(255).min(1),
        kecamatan: Joi.string().max(255).min(1),
        rt: Joi.string().max(255).min(1),
        rw: Joi.string().max(255).min(1),
        email: Joi.string().email().max(50).min(1),
        password: Joi.string().max(255).min(1),
        gender: Joi.string()
          .pattern(/^[lp]$/)
          .max(1)
          .min(1),
        noTelp: Joi.string()
          .max(50)
          .min(1)
          .pattern(/^[0-9]+$/),
      });
      const { error, value } = schema.validate(inputUser);
      return { error, value };
    }
  },
};
