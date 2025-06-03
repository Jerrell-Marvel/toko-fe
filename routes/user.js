import express from "express";
import {
  register,
  login,
  getAllUsers,
  getSingleUser,
  updateUser,
  deleteUser,
  getAddresses,
  getDistrictsAndSubdistricts,
  getSpecificSubdistricts,
  addNewAddress,
  updateAddress,
  deleteAddress,
} from "../controllers/user.js";
import { authMiddleware } from "../middleware/authMiddleware.js";

const router = express.Router();

router.get("/", authMiddleware, getSingleUser);
router.post("/register", register);
router.post("/login", login);
router.get("/districtandsub", getDistrictsAndSubdistricts);
router.get("/districtandsub/:district_id", getSpecificSubdistricts);
router.get("/addresses", authMiddleware, getAddresses);
router.patch("/updateuser", authMiddleware, updateUser);
router.post("/newaddress", authMiddleware, addNewAddress);
router.patch("/updateaddress", authMiddleware, updateAddress);
router.delete("/deleteaddress", authMiddleware, deleteAddress);

export default router;
