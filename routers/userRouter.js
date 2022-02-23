const express = require("express");
const { protect } = require("../middlewares/auth");
// const User = require("../models/user");

const router = express.Router();

const {
  registerUser,
  loginUser,
  addEditUserDetails,
  getUser,
  deleteUser
  
} = require("../controllers/userController");


router.route("/").get(protect, getUser).post(registerUser).put(loginUser).delete(protect, deleteUser);
router.route("/id").put(protect, addEditUserDetails);



module.exports = router;