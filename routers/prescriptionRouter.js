const express = require("express");
const { protect } = require("../middlewares/auth");
// const User = require("../models/user");

const router = express.Router();

const { addPrescription,
     editPrescription, 
     deletePrescription, 
     searchPrescription, 
     getPrescription } = require("../controllers/prescriptionController");


router.route("/").post(protect, addPrescription).put(protect, editPrescription).delete(protect, deletePrescription);
router.route("/search").put(protect, searchPrescription);
router.route("/id").put(protect, getPrescription);




module.exports = router;