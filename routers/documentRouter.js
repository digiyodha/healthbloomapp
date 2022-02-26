const express = require("express");
const { protect } = require("../middlewares/auth");
// const User = require("../models/user");

const router = express.Router();

const {
    getDocument
  
} = require("../controllers/documentController");


router.route("/").put(protect, getDocument)




module.exports = router;