const asyncHandler = require("../middlewares/asyncHandler");
const ErrorResponse = require("../utils/ErrorResponse");
var axios = require('axios');


exports.nearbyMedicalStores = asyncHandler(async (req, res, next) => {
    var {latitude, longitude, hours, distance, rating} = req.body;
    

    var lat = "18.457533", long = "73.867744", dis = "500", hour = "Any time", rate = "4";

    if(latitude)
        lat = latitude;
    if(longitude)
        long = longitude;
    if(distance)
        dis = distance;
    if(hours)
        hour = hours;
    if(rating)
        rate = rating;

    var url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?rating=" + rate + "&hours=" + hour + "&location=" + lat + "," + long + "&radius=" + dis + "&types=pharmacy&keyword=pharmacy&key=AIzaSyBMDiwO_HOqZlM0g5glTlTMZd00ejdVYoA"


    var config = {
        method: 'get',
        url: url,
        headers: { }
      };
      
      axios(config)
      .then(function (response) {
        res.status(200).json({ success: true, data: response.data});
      })
      .catch(function (error) {
        console.log(error);
        return next(
            new ErrorResponse(error, 404)
            );
      });

    
});


exports.nearbyMedicalLabs = asyncHandler(async (req, res, next) => {
    var {latitude, longitude, hours, distance, rating} = req.body;
    

    var lat = "18.457533", long = "73.867744", dis = "500", hour = "Any time", rate = "4";

    if(latitude)
        lat = latitude;
    if(longitude)
        long = longitude;
    if(distance)
        dis = distance;
    if(hours)
        hour = hours;
    if(rating)
        rate = rating

    var url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?rating=" + rate + "hours=" + hour + "&location=" + lat + "," + long + "&radius=" + dis + "&types=medical labs&keyword=medical labs&key=AIzaSyBMDiwO_HOqZlM0g5glTlTMZd00ejdVYoA"


    var config = {
        method: 'get',
        url: url,
        headers: { }
      };
      
      axios(config)
      .then(function (response) {
        res.status(200).json({ success: true, data: response.data});
      })
      .catch(function (error) {
        console.log(error);
        return next(
            new ErrorResponse(error, 404)
            );
      });

    
});