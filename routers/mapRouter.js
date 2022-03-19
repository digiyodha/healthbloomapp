const express = require("express");
// const User = require("../models/user");

const router = express.Router();

const { nearbyMedicalStores, nearbyMedicalLabs} = require("../controllers/mapController");


router.route("/store").put(nearbyMedicalStores);
router.route("/lab").put(nearbyMedicalLabs);





module.exports = router;