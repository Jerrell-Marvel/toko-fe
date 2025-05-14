import pool from "../db/db.js";

export const getAllProducts = async () => {
  const queryText = `
  SELECT 
    p.product_id,
    p.product_name,
    p.product_price,
    p.product_stock,
    p.product_details,
    p.product_featured_image_url,
    c.category_id,
    c.category_name
  FROM 
    Products p 
  INNER JOIN
    Categories c
  ON
    p.category_id = c.category_id
  WHERE 
    p.is_active = TRUE`;

  const queryResult = await pool.query(queryText);

  return queryResult;
};

export const getSingleProduct = async (product_id) => {
  const queryText = `
  SELECT 
    p.product_id,
    p.product_name,
    p.product_price,
    p.product_stock,
    p.product_details,
    p.product_featured_image_url,
    c.category_id,
    c.category_name
  FROM 
    Products p 
  INNER JOIN
    Categories c
  ON
    p.category_id = c.category_id
  WHERE 
    p.is_active = TRUE AND p.product_id = $1`;

  const values = [product_id];

  const queryResult = await pool.query(queryText, values);

  return queryResult;
};

export const createProduct = async (client, { product_name, product_price, product_stock, product_details, category_id, product_featured_image_url }) => {
  const queryText = `
  INSERT INTO
    Products (product_name, product_price, product_stock, product_details, category_id, product_featured_image_url)
  VALUES
    ($1, $2, $3, $4, $5, $6)
  RETURNING
    product_id
    `;

  const values = [product_name, product_price, product_stock, product_details, category_id, product_featured_image_url];

  const result = await client.query(queryText, values);

  return result.rows[0].product_id;
};

export const updateProduct = async (client, { product_id, product_name, product_price, product_stock, product_details, product_featured_image_url, category_id }) => {
  const queryText = `
  UPDATE
    Products
  SET
    product_name = $1,
    product_price = $2,
    product_stock = $3,
    product_details = $4,
    product_featured_image_url = $5,
    category_id = $6
  WHERE
    product_id = $7
  `;

  const values = [product_name, product_price, product_stock, product_details, product_featured_image_url, category_id, product_id];

  const queryResult = await client.query(queryText, values);

  return queryResult;
};

export const deleteProduct = async (client, product_id) => {
  const queryText = `
  UPDATE
    Products
  SET
    is_active = FALSE
  WHERE 
    product_id = $1`;

  const values = [product_id];

  const queryResult = await client.query(queryText, values);

  return queryResult;
};

export const insertProductImages = async (client, product_id, additionalImages) => {
  const queryText = `
    INSERT INTO Product_Images (product_id, product_image_url)
    VALUES ($1, $2)
  `;

  const queries = additionalImages.map((product_image_url) => {
    const values = [product_id, product_image_url];
    return client.query(queryText, values);
  });

  await Promise.all(queries);
};

export const getAdditionalProductImages = async (product_id) => {
  const queryText = `
  SELECT
    p.product_image_id,
    p.product_id,
    p.product_image_url,
    p.created_at
  FROM
    Product_Images p
  WHERE
    p.product_id = $1 AND p.is_active = TRUE
  `;

  const values = [product_id];

  const queryResult = await pool.query(queryText, values);

  return queryResult;
};

export const deleteProductImage = async (client, product_image_id) => {
  const queryText = `
  UPDATE
    Product_Images
  SET
    is_active = FALSE
  WHERE
    product_image_id = $1
  `;

  const values = [product_image_id];

  const queryResult = await client.query(queryText, values);

  return queryResult;
};

export const getAllCategories = async () => {
  const queryText = `
  SELECT
    c.category_id,
    c.category_name
  FROM
    Categories c
  WHERE
    c.is_active = TRUE
  `;

  const queryResult = await pool.query(queryText);

  return queryResult;
};

export const getSingleCategory = async (category_id) => {
  const queryText = `
  SELECT
    c.category_id,
    c.category_name
  FROM
    Categories c
  WHERE
    c.category_id = $1
  `;

  const values = [category_id];

  const queryResult = await pool.query(queryText, values);

  return queryResult;
};

export const insertCategoryImages = async (client, category_id, categoryImages) => {
  const queryText = `
    INSERT INTO Category_Images (category_id, category_image_url)
    VALUES ($1, $2)
  `;

  const queries = categoryImages.map((category_image_url) => {
    const values = [category_id, category_image_url];
    return client.query(queryText, values);
  });

  await Promise.all(queries);
};

export const getCategoryImages = async (category_id) => {
  const queryText = `
  SELECT
    c.category_image_id,
    c.category_id,
    c.category_image_url,
    c.created_at
  FROM
    Category_Images c
  WHERE
    c.category_id = $1 AND c.is_active = TRUE
  `;

  const values = [category_id];

  const queryResult = await pool.query(queryText, values);

  return queryResult;
};

export const deleteCategoryImage = async (client, category_image_id) => {
  const queryText = `
  UPDATE
    Category_Images
  SET
    is_active = FALSE
  WHERE
    category_image_id = $1
  `;

  const values = [category_image_id];

  const queryResult = await client.query(queryText, values);

  return queryResult;
};

export const getAllProductsWithCategory = async (category_name) => {
  const queryText = `
  SELECT 
    p.product_id,
    p.product_name,
    p.product_price,
    p.product_stock,
    p.product_details,
    p.product_featured_image_url,
    c.category_id,
    c.category_name
  FROM 
    Products p 
  INNER JOIN
    Categories c
  ON
    p.category_id = c.category_id
  WHERE 
    LOWER(c.category_name) = LOWER($1) AND p.is_active = TRUE`;

  const values = [category_name];

  const queryResult = await pool.query(queryText, values);

  return queryResult;
};

export const getAllProductsWithKeyword = async (keyword) => {
  const queryText = `
  SELECT 
    p.product_id,
    p.product_name,
    p.product_price,
    p.product_stock,
    p.product_details,
    p.product_featured_image_url,
    c.category_id,
    c.category_name
  FROM 
    Products p 
  INNER JOIN
    Categories c
  ON
    p.category_id = c.category_id
  WHERE 
    p.is_active = TRUE AND p.product_name ILIKE $1`;

  const values = [`%${keyword}%`];

  const queryResult = await pool.query(queryText, values);

  return queryResult;
};
