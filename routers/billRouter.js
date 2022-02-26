const express = require("express");
const { protect } = require("../middlewares/auth");
// const User = require("../models/user");

const router = express.Router();

const {
    addBill,
    editBill,
    searchBill,
    // filterBill,
    deleteBill,
    getBill,
    getBillFamily
  
} = require("../controllers/billController");


router.route("/").post(protect, addBill).put(protect, editBill).delete(protect, deleteBill);
router.route("/search").put(protect, searchBill);
// router.route("/filter").put(protect, filterBill);
router.route("/id").put(protect, getBill);
router.route("/family").put(protect, getBillFamily);




module.exports = router;