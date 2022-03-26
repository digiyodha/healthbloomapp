const express = require("express");
const { protect } = require("../middlewares/auth");
// const User = require("../models/user");

const router = express.Router();

const { waterCheck, medicineCheckUncheck, healthScore } = require("../controllers/checkController");


router.route("/water").put(protect, waterCheck);
router.route("/medicine").put(protect, medicineCheckUncheck);
router.route("/health").get(protect, healthScore);





module.exports = router;