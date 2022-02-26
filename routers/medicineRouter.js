const express = require("express");
const { protect } = require("../middlewares/auth");
// const User = require("../models/user");

const router = express.Router();

const { addMedicine, editMedicine, deleteMedicine, searchMedicine, getMedicine, getMedicineFamily } = require("../controllers/medicineController");


router.route("/").post(protect, addMedicine).put(protect, editMedicine).delete(protect, deleteMedicine);
router.route("/search").put(protect, searchMedicine);
router.route("/id").put(protect, getMedicine);
router.route("/family").put(protect, getMedicineFamily);




module.exports = router;