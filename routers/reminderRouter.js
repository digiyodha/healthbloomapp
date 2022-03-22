const express = require("express");
const { protect } = require("../middlewares/auth");
// const User = require("../models/user");

const router = express.Router();

const { addReminder, editReminder, deleteReminder, getAllReminder, getReminder, getReminderFamily, scheduleReminder } = require("../controllers/reminderController");


router.route("/").post(protect, addReminder).put(protect, editReminder).delete(protect, deleteReminder).get(protect, getAllReminder);
router.route("/id").put(protect, getReminder);
router.route("/family").put(protect, getReminderFamily);
// router.route("/schedule").put(protect, scheduleReminder);





module.exports = router;