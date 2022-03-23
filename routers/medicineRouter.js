const express = require("express");
const { protect } = require("../middlewares/auth");
// const User = require("../models/user");

const router = express.Router();

const { addMedicine, editMedicine, deleteMedicine, searchMedicine, getMedicine, getMedicineFamily, getNextMedicinesByTime, scheduleMedicine } = require("../controllers/medicineController");


router.route("/").post(protect, addMedicine).put(protect, editMedicine).delete(protect, deleteMedicine);
router.route("/search").put(protect, searchMedicine);
router.route("/id").put(protect, getMedicine);
router.route("/family").put(protect, getMedicineFamily);
router.route("/next-medicine").get(protect, getNextMedicinesByTime);
router.route("/schedule").get(protect, scheduleMedicine);






module.exports = router;