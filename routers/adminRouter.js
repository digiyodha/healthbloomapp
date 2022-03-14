const express = require("express");
const { protect, adminProtect } = require("../middlewares/auth");
// const User = require("../models/user");

const router = express.Router();

const { getAdmin, loginAdmin, registerAdmin, getUserList, switchUser, analytics } = require("../controllers/adminController");


router.route("/").get(adminProtect, getAdmin).put(loginAdmin).post(registerAdmin);
router.route("/users").get(getUserList);
router.route("/switch").put(switchUser);
router.route("/analytics").get(analytics);




module.exports = router;