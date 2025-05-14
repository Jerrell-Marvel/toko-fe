import express from "express";
import { getUserCart, insertNewCartItem, updateCartItem, removeCartItem, clearCart } from "../controllers/cart.js";
import { authMiddleware } from "../middleware/authMiddleware.js";

const router = express.Router();

router.get("/", authMiddleware, getUserCart);

router.post("/", authMiddleware, insertNewCartItem);
router.patch("/:cart_item_id", authMiddleware, updateCartItem);
router.delete("/:cart_item_id", authMiddleware, removeCartItem);
router.delete("/:user_id", clearCart);

export default router;
