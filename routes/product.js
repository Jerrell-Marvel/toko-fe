import express from "express";
import {
  getAllProducts,
  getSingleProduct,
  deleteProduct,
  createProduct,
  updateProduct,
  addProductImages,
  deleteProductImage,
  getAllCategories,
  getSingleCategory,
  getCategoryImages,
  addCategoryImages,
  getAllProductsWithCategory,
  deleteCategoryImage,
  getAdditionalProductImages,
  getAllProductsWithKeyword,
} from "../controllers/product.js";

import { fileUpload } from "../middleware/fileUploader.js";

const router = express.Router();

router.get("/", getAllProducts);

// router.post("/", fileUpload("./public"), createProduct);
// router.get("/search", getAllProductsWithKeyword);
// router.get("/category/:category_id", getAllProductsWithCategory);
router.get("/categories", getAllCategories);

router.get("/categories/:category_id", getSingleCategory);
router.get("/categories/:category_id/images", getCategoryImages);
router.post("/categories/:category_id/images", fileUpload("./public"), addCategoryImages);
router.delete("/categories/:category_id/images", deleteCategoryImage);
router.get("/:product_id", getSingleProduct);
router.patch("/:product_id", updateProduct);
router.delete("/:product_id", deleteProduct);
router.get("/:product_id/images", getAdditionalProductImages);
router.post("/:product_id/images", fileUpload("./public"), addProductImages);
router.delete("/:product_id/images", deleteProductImage);

export default router;
