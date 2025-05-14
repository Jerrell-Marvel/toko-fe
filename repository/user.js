import pool from "../db/db.js";

export const insertUser = async (client, { user_email, user_password, user_name }) => {
  const queryText = `
  INSERT INTO
    Users(user_email, user_password, user_name)
  VALUES
    ($1, $2, $3)
  RETURNING
    user_id
  `;

  const values = [user_email, user_password, user_name];

  const qureyResult = await client.query(queryText, values);

  return qureyResult;
};

export const getAllUsers = async () => {
  const queryText = `
  SELECT
    u.user_id,
    u.user_email,
    u.user_name,
    u.user_role,
    u.user_phone
  FROM
    Users u
  WHERE
    u.is_active = TRUE
  `;

  const queryResult = await pool.query(queryText);

  return queryResult;
};

export const getSingleUser = async (user_id) => {
  const queryText = `
  SELECT
    u.user_id,
    u.user_email,
    u.user_password,
    u.user_name,
    u.user_role,
    u.user_phone
  FROM
    Users u
  WHERE
    u.user_id= $1 AND u.is_active = TRUE
  `;

  const values = [user_id];

  const queryResult = await pool.query(queryText, values);

  return queryResult;
};

export const getSingleUserByEmail = async (user_email) => {
  const queryText = `
  SELECT 
    u.user_id,
    u.user_email,
    u.user_password,
    u.user_name,
    u.user_role,
    u.user_phone
  FROM 
    Users  u
  WHERE 
    u.user_email = $1`;

  const values = [user_email];

  const queryResult = await pool.query(queryText, values);

  return queryResult;
};

export const updateUser = async (client, { user_id, user_password, user_name, user_phone }) => {
  const queryText = `
  UPDATE
    Users
  SET
    user_password = $1,
    user_name = $2,
    user_phone = $3
  WHERE
    user_id = $4
  `;

  const values = [user_password, user_name, user_phone, user_id];

  const queryResult = await client.query(queryText, values);

  return queryResult.rowCount > 0;
};

export const deleteUser = async (client, user_id) => {
  const queryText = `
  UPDATE 
    Users
  SET
    is_active = FALSE
  WHERE
    user_id = $1
  `;

  const values = [user_id];

  const queryResult = await client.query(queryText, values);

  return queryResult.rowCount > 0;
};
