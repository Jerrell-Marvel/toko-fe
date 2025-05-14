import * as cartRepo from "../repository/cart.js";
import { NotFoundError } from "../errors/NotFoundError.js";
import pool from "../db/db.js";
import { BadRequestError } from "../errors/BadRequestError.js";

export const getUserCart = async (user_id) => {
  const queryResult = await cartRepo.getUserCart(user_id);

  return queryResult.rows;
};

export const insertNewCartItem = async ({ user_id, product_id, product_quantity }) => {
  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    const getProductStockQueryResult = await cartRepo.getProductStock(client, {
      product_id,
    });
    // check jika product ada
    if (getProductStockQueryResult.rowCount === 0) {
      throw new BadRequestError("Product doesn't exist");
    }
    const productStock = getProductStockQueryResult.rows[0].product_stock;

    // Check if item already exist in user cart
    const getCartItemQueryResult = await cartRepo.findUserCartItemByUserAndProduct(client, {
      user_id,
      product_id,
    });

    if (getCartItemQueryResult.rowCount === 0) {
      // belum ada
      await cartRepo.insertNewCartItem(client, {
        user_id,
        product_id,
        product_quantity,
      });
    } else {
      // sudah ada
      const cartItemId = getCartItemQueryResult.rows[0].cart_item_id;
      const productInCart = getCartItemQueryResult.rows[0].product_quantity;

      console.log(cartItemId, productInCart);
      if (product_quantity + productInCart > productStock) {
        throw new BadRequestError(`Excedeed maximum quantity of product stock = ${productStock}`);
      }
      await cartRepo.updateCartItem(client, {
        cart_item_id: cartItemId,
        product_quantity: product_quantity + productInCart,
      });
    }

    await client.query("COMMIT");
  } catch (error) {
    await client.query("ROLLBACK");
    throw error;
  } finally {
    client.release();
  }
};

export const updateCartItem = async ({ cart_item_id, user_id, product_quantity }) => {
  // let isExternalClient = true;

  // if client doesn't exist, make new connection
  // client will be exist from external only if this function called from the services
  // client won't be exist, if this function called from the controller
  // if (!client) {
  //   client = await pool.connect();
  //   isExternalClient = false;
  // }

  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    const getCartItemQueryResult = await cartRepo.findUserCartItem(client, {
      user_id,
      cart_item_id,
    });

    if (getCartItemQueryResult.rowCount === 0) {
      throw new BadRequestError("No cart item available");
    }

    const productId = getCartItemQueryResult.rows[0].product_id;

    // let queryResult;
    // const product_stock = await cartRepo.getProductStock(client, {
    //   product_id,
    // });

    const getProductStockQueryResult = await cartRepo.getProductStock(client, {
      product_id: productId,
    });

    const productStock = getProductStockQueryResult.rows[0].product_stock;

    if (product_quantity > productStock) {
      throw new BadRequestError(`Excedeed maximum quantity of product stock = ${productStock}`);
    }

    await cartRepo.updateCartItem(client, {
      cart_item_id,
      product_quantity,
    });

    await client.query("COMMIT");
  } catch (error) {
    await client.query("ROLLBACK");

    throw error;
  } finally {
    client.release();
  }
};

export const removeCartItem = async ({ user_id, cart_item_id }) => {
  // if client doesn't exist, make new connection
  // client will be exist from external only if this function called from the services
  // client won't be exist, if this function called from the controller

  const removeCartItemQueryResult = await cartRepo.removeCartItem({
    user_id,
    cart_item_id,
  });

  if (removeCartItemQueryResult.rowCount === 0) {
    throw new BadRequestError("cart item doesn't exist");
  }
};

export const clearCart = async (user_id) => {
  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    const queryResult = await cartRepo.clearCart(client, {
      user_id,
    });

    await client.query("COMMIT");

    if (!queryResult) {
      throw new BadRequestError("User cart doesn't exist");
    }
    return { queryResult, success: true };
  } catch (error) {
    await client.query("ROLLBACK");
    throw error;
  } finally {
    client.release();
  }
};
