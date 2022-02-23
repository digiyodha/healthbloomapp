const express = require("express");
const { protect } = require("../middlewares/auth");
// const User = require("../models/user");

const router = express.Router();

const {
    addFamilyMember,
    editFamilyMember,
    deleteFamilyMember,
    getFamilyMember,
    getAllFamilyMembers
  
} = require("../controllers/familyController");


router.route("/").get(protect, getAllFamilyMembers).post(protect, addFamilyMember).put(protect, editFamilyMember);
router.route("/id").put(protect, getFamilyMember).delete(protect, deleteFamilyMember);



module.exports = router;