import pool from "../db/db.js";

export const getUserCart = async (user_id) => {
  const queryText = `
  SELECT
    c.cart_item_id,
    c.product_id,
    c.user_id,
    c.product_quantity,
    p.product_name
  FROM
    Cart_Items c
  INNER JOIN
    Products p
  ON p.product_id = c.product_id
  WHERE
    c.user_id = $1
  `;

  const values = [user_id];

  const queryResult = await pool.query(queryText, values);

  return queryResult;
};

export const findUserCartItemByUserAndProduct = async (
  client,
  { user_id, product_id }
) => {
  const queryText = `
  SELECT
    c.cart_item_id,
    c.product_quantity
  FROM
    Cart_Items c
  WHERE
    c.user_id = $1 AND c.product_id = $2
  `;

  const values = [user_id, product_id];

  const queryResult = await client.query(queryText, values);

  return queryResult;
};

export const findUserCartItem = async (client, { cart_item_id, user_id }) => {
  const queryText = `
  SELECT
    c.product_id,
    c.cart_item_id,
    c.product_quantity
  FROM
    Cart_Items c
  WHERE
    c.cart_item_id = $1 AND c.user_id = $2
  `;

  const values = [cart_item_id, user_id];

  const queryResult = await client.query(queryText, values);

  return queryResult;
};

export const insertNewCartItem = async (
  client,
  { user_id, product_id, product_quantity }
) => {
  const queryText = `
  INSERT INTO
    Cart_Items (user_id, product_id, product_quantity)
  VALUES
    ($1, $2, $3)
  `;

  const values = [user_id, product_id, product_quantity];

  const queryResult = await client.query(queryText, values);

  return queryResult;
};

export const getProductStock = async (client, { product_id }) => {
  const queryText = `
  SELECT
    p.product_stock
  FROM
    Products p
  WHERE
    p.product_id = $1
  `;

  console.log("kdlsjflskfjkls", product_id);

  const values = [product_id];

  const queryResult = await client.query(queryText, values);

  return queryResult;
};

export const updateCartItem = async (
  client,
  { cart_item_id, product_quantity }
) => {
  const queryText = `
  UPDATE
    Cart_Items
  SET
    product_quantity = $1
  WHERE
    cart_item_id = $2
  `;

  const values = [product_quantity, cart_item_id];

  let queryResult;
  if (client) {
    queryResult = await client.query(queryText, values);
  } else {
    queryResult = await pool.query(queryText, values);
  }

  return queryResult;
};

export const removeCartItem = async ({ user_id, cart_item_id }) => {
  const queryText = `
  DELETE FROM
    Cart_Items
  WHERE
    user_id = $1 AND cart_item_id = $2
  `;

  const values = [user_id, cart_item_id];

  const queryResult = await pool.query(queryText, values);

  return queryResult;
};

export const clearCart = async (client, { user_id }) => {
  const queryText = `
  DELETE FROM
    Cart_Items
  WHERE
    user_id = $1
  `;

  const values = [user_id];

  const queryResult = await client.query(queryText, values);

  return queryResult.rowCount > 0;
};
