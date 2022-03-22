const express = require("express");
// const User = require("../models/user");

const router = express.Router();

const { nearbyMedicalStores, nearbyMedicalLabs, placeDetails, nextResults} = require("../controllers/mapController");


router.route("/store").put(nearbyMedicalStores);
router.route("/lab").put(nearbyMedicalLabs);
router.route("/details").put(placeDetails);
router.route("/next-page").put(nextResults);






module.exports = router;