const express = require("express");
const { protect } = require("../middlewares/auth");
// const User = require("../models/user");

const router = express.Router();

const { waterCheck, healthScore, medicineCheck } = require("../controllers/checkController");


router.route("/water").put(protect, waterCheck);
router.route("/medicine").put(protect, medicineCheck);
router.route("/health").get(protect, healthScore);





module.exports = router;