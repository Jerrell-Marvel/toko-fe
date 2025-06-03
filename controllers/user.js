import * as userService from "../services/user.js";
import { BadRequestError } from "../errors/BadRequestError.js";

export const register = async (req, res) => {
  const { user_email, user_password, user_name } = req.body;
  
  if (!user_name) {
    throw new BadRequestError("Username is required");
  }
  if (!user_email) {
    throw new BadRequestError("Email is required");
  }
  if (!user_password) {
    throw new BadRequestError("Password is required");
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
    throw new BadRequestError("Email is empty");
  }
  if (!user_password) {
    throw new BadRequestError("Password is empty");
  }

  const token = await userService.login({ user_email, user_password });

  return res.json({ success: true, token });
};

export const getAllUsers = async (req, res) => {
  const users = await userService.getAllUsers();
  return res.json(users);
};

export const getSingleUser = async (req, res) => {
  const { user_id } = req.user;

  const user = await userService.getSingleUser(user_id);

  return res.json(user);
};

export const updateUser = async (req, res) => {
  const { user_id } = req.user;

  // assumption that user_email can't be updated
  const { user_name, user_phone } = req.body;

  console.log(req.body);

  const result = await userService.updateUser({
    user_id,
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

// Addresses

export const getAddresses = async (req, res) => {
  const { user_id } = req.user;

  console.log("controllers " + req.user);

  const addresses = await userService.getAddresses(user_id);

  // const formatAddress = {
  //   address_id : addresses.address_id,
  //   address_label : addresses.address_label,
  //   addresses_name : addresses.address_name,
  //   district : {
  //       district_id : addresses.district_id,
  //       district_name : addresses.district_name,
  //   },
  //   subdistrict : {
  //       subdistrict_id : addresses.subdistrict_id,
  //       subdistrict_name : addresses.subdistrict_name,
  //   }
  // }

  return res.json({ success: true, addresses });
};

export const getDistrictsAndSubdistricts = async (_, res) => {
  const districts = await userService.getDistricts();
  const subdistricts = await userService.getSubdistricts();

  return res.json({
    success: true,
    districts: districts,
    subdistricts: subdistricts,
  });
};

export const getSpecificSubdistricts = async (req, res) => {
  const { district_id } = req.params;

  const subdistricts = await userService.getSpecificSubdistricts(district_id);

  return res.json({ success: true, subdistricts: subdistricts });
};

export const addNewAddress = async (req, res) => {
  const { user_id } = req.user;
  const { address_label, address_name, subdistrict_id } = req.body;

  // console.log(
  //   {
  //   user_id : user_id,
  //   address_label : address_label,
  //   address_name : address_name,
  //   subdistrict_id : subdistrict_id,
  // }
  // )

  if (!address_label) {
    throw new BadRequestError("Address label is required");
  }
  if (!address_name) {
    throw new BadRequestError("Address is required");
  }

  const addressId = await userService.addNewAddress({
    user_id,
    address_label,
    address_name,
    subdistrict_id,
  });

  return res.status(201).json({ success: true, address_id: addressId });
};

export const updateAddress = async (req, res) => {
  // assumption that user_email can't be updated
  const { address_id, address_name, address_label, subdistrict_id } = req.body;

  const result = await userService.updateAddress({
    address_id,
    address_name,
    address_label,
    subdistrict_id,
  });

  return res.json({ success: true });
};
