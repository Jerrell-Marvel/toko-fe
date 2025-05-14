import { NotFoundError } from "../errors/NotFoundError.js";
import * as productRepo from "../repository/product.js";
import pool from "../db/db.js";

export const getAllProducts = async () => {
  const queryResult = await productRepo.getAllProducts();

  return queryResult.rows;
};

export const getSingleProduct = async (product_id) => {
  const queryResult = await productRepo.getSingleProduct(product_id);

  return queryResult.rows[0];
};

export const createProduct = async ({ product_name, product_price, product_stock, product_details, category_id, product_featured_image_url, additionalImages }) => {
  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    const product_id = await productRepo.createProduct(client, {
      product_name,
      product_price,
      product_stock,
      product_details,
      category_id,
      product_featured_image_url,
    });

    if (additionalImages.length > 0) {
      await productRepo.insertProductImages(client, product_id, additionalImages);
    }

    await client.query("COMMIT");
    return { product_id };
  } catch (error) {
    await client.query("ROLLBACK");
    throw error;
  } finally {
    client.release();
  }
};

export const updateProduct = async ({ product_id, product_name, product_price, product_stock, product_details, product_featured_image_url, category_id }) => {
  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    const queryResult = await productRepo.updateProduct(client, {
      product_id,
      product_name,
      product_price,
      product_stock,
      product_details,
      product_featured_image_url,
      category_id,
    });

    await client.query("COMMIT");
    return { queryResult };
  } catch (error) {
    await client.query("ROLLBACK");
    throw error;
  } finally {
    client.release();
  }
};

export const deleteProduct = async (product_id) => {
  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    const queryResult = await productRepo.deleteProduct(client, product_id);

    if (queryResult.rowCount === 0) {
      throw new NotFoundError(`product with id ${product_id} is not found`);
    }

    await client.query("COMMIT");
    return { queryResult };
  } catch (error) {
    await client.query("ROLLBACK");
    throw error;
  } finally {
    client.release();
  }
};

export const addProductImages = async (product_id, additionalImages) => {
  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    const queryResult = await productRepo.insertProductImages(client, product_id, additionalImages);

    await client.query("COMMIT");
    return { queryResult };
  } catch (error) {
    await client.query("ROLLBACK");
    throw error;
  } finally {
    client.release();
  }
};

export const getAdditionalProductImages = async (product_id) => {
  const queryResult = await productRepo.getAdditionalProductImages(product_id);

  return queryResult.rows;
};

export const deleteProductImage = async (product_image_id) => {
  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    const queryResult = await productRepo.deleteProductImage(client, product_image_id);

    await client.query("COMMIT");
    return { queryResult };
  } catch (error) {
    await client.query("ROLLBACK");
    throw error;
  } finally {
    client.release();
  }
};

export const getAllCategories = async () => {
  const queryResult = await productRepo.getAllCategories();

  return queryResult.rows;
};

export const getSingleCategory = async (category_id) => {
  const queryResult = await productRepo.getSingleCategory(category_id);

  return queryResult.rows[0];
};

export const addCategoryImages = async (category_id, categoryImages) => {
  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    const queryResult = await productRepo.insertCategoryImages(client, category_id, categoryImages);

    await client.query("COMMIT");
    return { queryResult };
  } catch (error) {
    await client.query("ROLLBACK");
    throw error;
  } finally {
    client.release();
  }
};

export const getCategoryImages = async (category_id) => {
  const queryResult = await productRepo.getCategoryImages(category_id);

  return queryResult.rows;
};

export const deleteCategoryImage = async (category_image_id) => {
  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    const queryResult = await productRepo.deleteCategoryImage(client, category_image_id);

    await client.query("COMMIT");
    return { queryResult };
  } catch (error) {
    await client.query("ROLLBACK");
    throw error;
  } finally {
    client.release();
  }
};

export const getAllProductsWithCategory = async (category_name) => {
  const queryResult = await productRepo.getAllProductsWithCategory(category_name);

  return queryResult.rows;
};

export const getAllProductsWithKeyword = async (keyword) => {
  const queryResult = await productRepo.getAllProductsWithKeyword(keyword);

  return queryResult.rows;
};
