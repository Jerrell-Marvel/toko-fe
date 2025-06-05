import * as cartService from "../services/cart.js";
import { BadRequestError } from "../errors/BadRequestError.js";

export const getUserCart = async (req, res) => {
  const { user_id } = req.user;
  const result = await cartService.getUserCart(user_id);

  return res.json(result);
};

export const insertNewCartItem = async (req, res) => {
  const { user_id } = req.user;

  const { product_id, product_quantity } = req.body;

  if (!product_id) {
    throw new BadRequestError("product_id must be included");
  }

  if (!product_quantity) {
    throw new BadRequestError("product_quantity must be included");
  }

  await cartService.insertNewCartItem({
    user_id,
    product_id,
    product_quantity,
  });

  return res.json({ success: true });
};

export const updateCartItem = async (req, res) => {
  const { user_id } = req.user;
  const { cart_item_id } = req.params;
  const { product_quantity } = req.body;

  if (!cart_item_id) {
    throw new BadRequestError("cart_item_id must be included");
  }

  if (!product_quantity) {
    throw new BadRequestError("product_quantity must be included");
  }

  if (product_quantity <= 0) {
    throw new BadRequestError("product_quantity must be greater than 0");
  }

  await cartService.updateCartItem({
    user_id,
    cart_item_id,
    product_quantity,
  });

  return res.json({ success: true });
};

export const removeCartItem = async (req, res) => {
  const { cart_item_id } = req.params;
  const { user_id } = req.user;

  await cartService.removeCartItem({
    user_id,
    cart_item_id,
  });

  return res.json({ success: true });
};

export const clearCart = async (req, res) => {
  const { user_id } = req.params;

  const result = await cartService.clearCart(user_id);

  return res.json(result);
};
