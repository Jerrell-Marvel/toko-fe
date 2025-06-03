import { hashPassword } from "../utils/hashPassword.js";
import * as userRepo from "../repository/user.js";
import { BadRequestError } from "../errors/BadRequestError.js";
import { NotFoundError } from "../errors/NotFoundError.js";
import { UnauthorizedError } from "../errors/UnauthorizedError.js";
import { InternalServerError } from "../errors/InternalServerError.js";
import bcrypt from "bcryptjs";
import pool from "../db/db.js";
import jwt from "jsonwebtoken";

export const register = async ({ user_email, user_password, user_name }) => {
  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    // check if email is already in use
    const getUserByEmailResult = await userRepo.getSingleUserByEmail(
      user_email
    );
    console.log(getUserByEmailResult);
    if (getUserByEmailResult.rowCount !== 0) {
      throw new BadRequestError("Email is already in use");
    }
    const hashedPassword = await hashPassword(user_password);
    console.log(hashedPassword);

    await userRepo.insertUser(client, {
      user_email,
      user_password: hashedPassword,
      user_name,
    });

    await client.query("COMMIT");
  } catch (error) {
    await client.query("ROLLBACK");
    throw error;
  } finally {
    client.release();
  }
};

export const login = async ({ user_email, user_password }) => {
  const userQueryResult = await userRepo.getSingleUserByEmail(user_email);
  if (userQueryResult.rowCount === 0) {
    throw new UnauthorizedError("Email or Password is Incorrect");
  }
  const user = userQueryResult.rows[0];

  const isPasswordMatch = await bcrypt.compare(
    user_password,
    user.user_password
  );

  if (!isPasswordMatch) {
    throw new UnauthorizedError("Email or Password is Incorrect");
  }

  const token = jwt.sign(
    {
      user_id: user.user_id,
      user_email: user.user_email,
      user_name: user.user_name,
      user_role: user.user_role,
      user_phone: user.user_phone,
    },
    process.env.JWT_SECRET,
    {
      expiresIn: process.env.JWT_LIFETIME,
    }
  );

  return token;
};

export const getAllUsers = async () => {
  const queryResult = await userRepo.getAllUsers();

  if (queryResult.rowCount === 0) {
    throw new NotFoundError("No user founded");
  }

  return queryResult.rows;
};

export const getSingleUser = async (user_id) => {
  const queryResult = await userRepo.getSingleUser(user_id);

  if (queryResult.rowCount === 0) {
    throw new NotFoundError(`User with id ${user_id} is not found`);
  }

  return queryResult.rows[0];
};

export const updateUser = async ({ user_id, user_name, user_phone }) => {
  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    const result = await userRepo.updateUser(client, {
      user_id,
      user_name,
      user_phone,
    });

    if (!result) {
      throw new InternalServerError(
        "Failed to update user with id = " + user_id
      );
    }

    await client.query("COMMIT");
    return { result };
  } catch (error) {
    await client.query("ROLLBACK");
    throw error;
  } finally {
    client.release();
  }
};

export const deleteUser = async (user_id) => {
  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    const result = await userRepo.deleteUser(client, user_id);

    if (!result) {
      throw new InternalServerError(
        "Failed to delete user with id = " + user_id
      );
    }

    await client.query("COMMIT");
    return { result };
  } catch (error) {
    await client.query("ROLLBACK");
    throw error;
  } finally {
    client.release();
  }
};

// Addresses

export const getAddresses = async (user_id) => {
  const queryResult = await userRepo.getAddresses(user_id);

  return queryResult.rows;
};

export const getDistricts = async () => {
  const queryResult = await userRepo.getDistricts();

  if (queryResult.rowCount === 0) {
    throw new NotFoundError("No Districts founded");
  }

  return queryResult.rows;
};
export const getSubdistricts = async () => {
  const queryResult = await userRepo.getSubdistricts();

  if (queryResult.rowCount === 0) {
    throw new NotFoundError("No Subdistricts founded");
  }

  return queryResult.rows;
};

export const getSpecificSubdistricts = async (district_id) => {
  const queryResult = await userRepo.getSpecificSubdistricts(district_id);

  if (queryResult.rowCount === 0) {
    throw new NotFoundError("No Subdistricts founded");
  }

  return queryResult.rows;
};

export const addNewAddress = async ({
  user_id,
  address_label,
  address_name,
  subdistrict_id,
}) => {
  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    // // check if email is already in use
    // const getUserByEmailResult = await userRepo.getSingleUserByEmail(user_email);

    // if (getUserByEmailResult.rowCount !== 0) {
    //   throw new BadRequestError("Email is already in use");
    // }

    const queryResult = await userRepo.addNewAddress(client, {
      user_id,
      address_label,
      address_name,
      subdistrict_id,
    });

    await client.query("COMMIT");

    return queryResult.rows[0].address_id;
  } catch (error) {
    await client.query("ROLLBACK");
    throw error;
  } finally {
    client.release();
  }
};

export const updateAddress = async ({
  address_id,
  address_label,
  address_name,
  subdistrict_id,
}) => {
  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    await userRepo.updateAddress(client, {
      address_id,
      address_label,
      address_name,
      subdistrict_id,
    });

    await client.query("COMMIT");
  } catch (error) {
    await client.query("ROLLBACK");
    throw error;
  } finally {
    client.release();
  }
};

export const deleteAddress = async ({ address_id }) => {
  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    const isDeleted = await userRepo.deleteAddress(client, {
      address_id,
    });

    await client.query("COMMIT");
    return isDeleted;
  } catch (error) {
    await client.query("ROLLBACK");
    throw error;
  } finally {
    client.release();
  }
};
