const express = require("express");
const { protect } = require("../middlewares/auth");
// const User = require("../models/user");

const router = express.Router();

const { addFeedbackOptions, getFeedbackOptions, deleteFeedbackOptions, addFeedback, getFeedback } = require("../controllers/feedbackController");


router.route("/options").post(addFeedbackOptions).get(getFeedbackOptions).delete(deleteFeedbackOptions);
router.route("/").post(protect, addFeedback).get(protect, getFeedback);


module.exports = router;