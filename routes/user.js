import express from "express";
import { register, login, getAllUsers, getSingleUser, updateUser, deleteUser ,getAddresses,getDistrictsAndSubdistricts, getSpecificSubdistricts, addNewAddress, updateAddress } from "../controllers/user.js";
import { authMiddleware } from "../middleware/authMiddleware.js";

const router = express.Router();

router.post("/register", register);
router.post("/login", login);
router.get("/districtandsub", getDistrictsAndSubdistricts );
router.get("/districtandsub/:district_id", getSpecificSubdistricts );
router.get("/addresses", authMiddleware, getAddresses);
router.patch("/updateuser", authMiddleware, updateUser)
router.post("/newaddress", authMiddleware, addNewAddress)
router.patch("/updateaddress", authMiddleware, updateAddress)

router.get("/:user_id", getSingleUser);

export default router;
