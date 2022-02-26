const express = require("express");
const { protect } = require("../middlewares/auth");
// const User = require("../models/user");

const router = express.Router();

const { addPrescription,
     editPrescription, 
     deletePrescription, 
     searchPrescription, 
     getPrescription, 
     getPrescriptionFamily} = require("../controllers/prescriptionController");


router.route("/").post(protect, addPrescription).put(protect, editPrescription).delete(protect, deletePrescription);
router.route("/search").put(protect, searchPrescription);
router.route("/id").put(protect, getPrescription);
router.route("/family").put(protect, getPrescriptionFamily);





module.exports = router;