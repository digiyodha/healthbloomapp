const express = require("express");
const { protect } = require("../middlewares/auth");
// const User = require("../models/user");

const router = express.Router();

const {
    addReport,
    editReport,
    getReport,
    deleteReport,
    searchReport,
    getReportFamily
} = require("../controllers/reportController");


router.route("/").post(protect, addReport).put(protect, editReport).delete(protect, deleteReport);
router.route("/search").put(protect, searchReport);
// router.route("/filter").put(protect, filterBill);
router.route("/id").put(protect, getReport);
router.route("/family").put(protect, getReportFamily);




module.exports = router;