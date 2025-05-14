import express from "express";
import { register, login, getAllUsers, getSingleUser, updateUser, deleteUser } from "../controllers/user.js";

const router = express.Router();

router.post("/register", register);
router.post("/login", login);
router.get("/:user_id", getSingleUser);

export default router;
