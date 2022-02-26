const express = require("express");
const { protect } = require("../middlewares/auth");
// const User = require("../models/user");

const router = express.Router();

const { 
    addInsurance, 
    editInsurance, 
    deleteInsurance, 
    searchInsurance, 
    getInsurance, 
    getInsuranceFamily 
} = require("../controllers/insuranceController");


router.route("/").post(protect, addInsurance).put(protect, editInsurance).delete(protect, deleteInsurance);
router.route("/search").put(protect, searchInsurance);
router.route("/id").put(protect, getInsurance);
router.route("/family").put(protect, getInsuranceFamily);




module.exports = router;