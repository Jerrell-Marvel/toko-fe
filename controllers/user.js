import * as userService from "../services/user.js";
import { BadRequestError } from "../errors/BadRequestError.js";

export const register = async (req, res) => {
  const { user_email, user_password, user_name } = req.body;

  if (!user_email) {
    throw new BadRequestError("Email is required");
  }
  if (!user_password) {
    throw new BadRequestError("Password is required");
  }
  if (!user_name) {
    throw new BadRequestError("User_name is required");
  }

  await userService.register({
    user_email,
    user_password,
    user_name,
  });

  return res.status(201).json({ success: true });
};

export const login = async (req, res) => {
  const { user_email, user_password } = req.body;

  if (!user_email) {
    throw new BadRequestError("Email is required");
  }
  if (!user_password) {
    throw new BadRequestError("Password is required");
  }

  const token = await userService.login({ user_email, user_password });

  return res.json({ success: true, token });
};

export const getAllUsers = async (req, res) => {
  const users = await userService.getAllUsers();
  return res.json(users);
};

export const getSingleUser = async (req, res) => {
  const { user_id } = req.params;

  const user = await userService.getSingleUser(user_id);

  return res.json(user);
};

export const updateUser = async (req, res) => {
  const { user_id } = req.params;

  // assumption that user_email can't be updated

  const { user_password, user_name, user_phone } = req.body;

  const result = await userService.updateUser({
    user_id,
    user_password,
    user_name,
    user_phone,
  });

  return res.json({ success: true, ...result });
};

export const deleteUser = async (req, res) => {
  const { user_id } = req.params;

  await userService.deleteUser(user_id);

  return res.json({ success: true });
};
