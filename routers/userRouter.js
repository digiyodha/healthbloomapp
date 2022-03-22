const express = require("express");
const { protect } = require("../middlewares/auth");
// const User = require("../models/user");

const router = express.Router();

const {
  registerLoginUser,
  addEditUserDetails,
  getUser,
  deleteUser,
  editSettings
  
} = require("../controllers/userController");


router.route("/").get(protect, getUser).put(registerLoginUser).delete(protect, deleteUser);
router.route("/id").put(addEditUserDetails);
router.route("/settings").put(protect, editSettings);




module.exports = router;