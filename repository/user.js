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

export const getAddresses = async (user_id) => {
  const queryText = `
  SELECT 
    a.address_id,
	  a.address_label,
    a.address_name,
	  d.district_name,
    d.district_id,
	  sd.subdistrict_name,
    sd.subdistrict_id
  FROM 
    addresses a
  JOIN 
    subdistricts sd
  ON 
    a.subdistrict_id = sd.subdistrict_id
  JOIN 
    districts d
  ON 
    sd.district_id = d.district_id
  WHERE 
    user_id = $1 ;`;

  const values = [user_id];

  const queryResult = await pool.query(queryText,values);

  return queryResult;
}

export const getDistricts = async () => {
  const queryText = `
  Select 
    d.district_id,
    d.district_name
  FROM districts d;
  `;

 const queryResult = await pool.query(queryText);

 return queryResult;
}
export const getSubdistricts = async () => {
  const queryText = `
  Select 
    sd.subdistrict_id,
    sd.subdistrict_name,
    sd.district_id
  FROM subdistricts sd;
  `;

 const queryResult = await pool.query(queryText);

 return queryResult;

}
export const getSpecificSubdistricts = async (district_id) => {
  const queryText = `
  Select 
    sd.subdistrict_id,
    sd.subdistrict_name,
    sd.district_id
  FROM
    subdistricts sd
  WHERE 
    sd.district_id = $1;
  `;

  const values = [district_id]
 const queryResult = await pool.query(queryText,values);

 return queryResult;
}

export const addNewAddress = async (client, {
      user_id,
      address_label,
      address_name,
      subdistrict_id,
    }) => {
  const queryText = `
  INSERT INTO
    Addresses(user_id, address_label, address_name, subdistrict_id)
  VALUES
    ($1, $2, $3 , $4)
  RETURNING
    address_id
  `;

  const values = [user_id, address_label, address_name, subdistrict_id];

  const qureyResult = await client.query(queryText, values);

  return qureyResult;
};

export const updateAddress = async (client, {
      address_id,
      address_label,
      address_name,
      subdistrict_id,
    }) => {
   const queryText = `
    UPDATE
      Addresses
    SET
      address_label = $1,
      address_name = $2,
      subdistrict_id = $3
    WHERE
      address_id = $4
    `;

    const values = [address_label, address_name, subdistrict_id, address_id];

    const queryResult = await client.query(queryText, values);

    return queryResult.rowCount > 0;
};