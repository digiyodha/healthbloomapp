const express = require("express");
const { protect } = require("../middlewares/auth");
// const User = require("../models/user");

const router = express.Router();

const {
  registerLoginUser,
  addEditUserDetails,
  getUser,
  deleteUser
  
} = require("../controllers/userController");


router.route("/").get(protect, getUser).put(registerLoginUser).delete(protect, deleteUser);
router.route("/id").put(addEditUserDetails);



module.exports = router;