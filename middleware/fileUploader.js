import multer from "multer";
import path from "path";
import { BadRequestError } from "../errors/BadRequestError.js";
import { PayloadTooLarge } from "../errors/PayloadTooLargeError.js";

export const fileUpload = (destination) => {
  const storage = multer.diskStorage({
    destination: function (req, file, cb) {
      cb(null, destination);
    },
    filename: function (req, file, cb) {
      const fileExtension = path.extname(file.originalname);
      const uniqueSuffix = Date.now() + "-" + Math.round(Math.random() * 1e9);
      cb(null, file.fieldname + "-" + uniqueSuffix + fileExtension);
    },
  });

  const imageFileFilter = (req, file, cb) => {
    const filetypes = /jpeg|jpg|png/i;
    const mimetype = filetypes.test(file.mimetype);
    const extname = filetypes.test(path.extname(file.originalname));

    if (mimetype && extname) {
      return cb(null, true);
    }
    cb(new BadRequestError("Invalid file type"));
  };

  const limits = {
    fileSize: 1024 * 1024 * 3, // 3MB per file
  };

  const upload = multer({ storage, fileFilter: imageFileFilter, limits });

  return upload.fields([
    { name: "featured_image", maxCount: 1 }, // Single featured image (for display product image in card)
    { name: "images", maxCount: 12 }, // Multiple optional images (max 12) (for additional product image)
    { name: "category_images", maxCount: 12 }, // For category display image in banner
  ]);
};
