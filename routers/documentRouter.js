const express = require("express");
const { protect } = require("../middlewares/auth");
// const User = require("../models/user");

const router = express.Router();

const {
    getDocument, getDocumentFamily
  
} = require("../controllers/documentController");


router.route("/").put(protect, getDocument)
router.route("/family").put(protect, getDocumentFamily)





module.exports = router;