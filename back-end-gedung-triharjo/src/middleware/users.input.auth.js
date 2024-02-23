import Joi from "joi";

export const usersInputAuth = {
  registerInput(inputUser) {
    try {
      const schema = Joi.object({
        nama: Joi.string().max(50).min(1).required(),
        noKTP: Joi.string()
          .max(50)
          .min(1)
          .pattern(/^[0-9]+$/)
          .required(),
        dukuh: Joi.string().max(255).min(1).required(),
        kelurahan: Joi.string().max(255).min(1).required(),
        kecamatan: Joi.string().max(255).min(1).required(),
        rt: Joi.string().max(255).min(1).required(),
        rw: Joi.string().max(255).min(1).required(),
        email: Joi.string().email().max(50).min(1).required(),
        password: Joi.string().max(255).min(1).required(),
        gender: Joi.string()
          .pattern(/^[lp]$/)
          .max(1)
          .min(1)
          .required(),
        noTelp: Joi.string()
          .max(50)
          .min(1)
          .pattern(/^[0-9]+$/)
          .required(),
      });
      const { error, value } = schema.validate(JSON.parse(inputUser));
      return { error, value };
    } catch (err) {
      const schema = Joi.object({
        nama: Joi.string().max(50).min(1).required(),
        noKTP: Joi.string()
          .max(50)
          .min(1)
          .pattern(/^[0-9]+$/)
          .required(),
        dukuh: Joi.string().max(255).min(1).required(),
        kelurahan: Joi.string().max(255).min(1).required(),
        kecamatan: Joi.string().max(255).min(1).required(),
        rt: Joi.string().max(255).min(1).required(),
        rw: Joi.string().max(255).min(1).required(),
        email: Joi.string().email().max(50).min(1).required(),
        password: Joi.string().max(255).min(1).required(),
        gender: Joi.string()
          .pattern(/^[lp]$/)
          .max(1)
          .min(1)
          .required(),
        noTelp: Joi.string()
          .max(50)
          .min(1)
          .pattern(/^[0-9]+$/)
          .required(),
      });
      const { error, value } = schema.validate(inputUser);
      return { error, value };
    }
  },
  loginInput(inputUser) {
    try {
      const schema = Joi.object({
        email: Joi.string().email().max(50).min(1).required(),
        password: Joi.string().max(255).min(1).required(),
      });
      const { error, value } = schema.validate(JSON.parse(inputUser));
      return { error, value };
    } catch (err) {
      const schema = Joi.object({
        email: Joi.string().email().max(50).min(1).required(),
        password: Joi.string().max(255).min(1).required(),
      });
      const { error, value } = schema.validate(inputUser);
      return { error, value };
    }
  },
};
