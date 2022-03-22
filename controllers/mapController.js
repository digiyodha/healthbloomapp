const asyncHandler = require("../middlewares/asyncHandler");
const ErrorResponse = require("../utils/ErrorResponse");
var axios = require('axios');


exports.nearbyMedicalStores = asyncHandler(async (req, res, next) => {
    var {latitude, longitude, distance,
        // hours, rating
    } = req.body;
    

    var lat = "18.457533", long = "73.867744", dis = "500";
    //  hour = "Any time", rate = "4";

    if(latitude)
        lat = latitude;
    if(longitude)
        long = longitude;
    if(distance)
        dis = distance;
    // if(hours)
    //     hour = hours;
    // if(rating)
    //     rate = rating;

    // var url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?rating=" + rate + "&hours=" + hour + "&location=" + lat + "," + long + "&radius=" + dis + "&types=pharmacy&keyword=pharmacy&key=AIzaSyBMDiwO_HOqZlM0g5glTlTMZd00ejdVYoA"

    var url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=" + lat + "," + long + "&radius=" + dis + "&types=pharmacy&keyword=pharmacy&key=AIzaSyBMDiwO_HOqZlM0g5glTlTMZd00ejdVYoA"


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
    var {latitude, longitude, distance, 
        // hours, rating
    } = req.body;
    

    var lat = "18.457533", long = "73.867744", dis = "500";
    //  hour = "Any time", rate = "4";

    if(latitude)
        lat = latitude;
    if(longitude)
        long = longitude;
    if(distance)
        dis = distance;
    // if(hours)
    //     hour = hours;
    // if(rating)
    //     rate = rating

    // var url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?rating=" + rate + "hours=" + hour + "&location=" + lat + "," + long + "&radius=" + dis + "&types=medical labs&keyword=medical labs&key=AIzaSyBMDiwO_HOqZlM0g5glTlTMZd00ejdVYoA"

    var url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=" + lat + "," + long + "&radius=" + dis + "&types=medical labs&keyword=medical labs&key=AIzaSyBMDiwO_HOqZlM0g5glTlTMZd00ejdVYoA"


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

exports.placeDetails = asyncHandler(async (req, res, next) => {
    var {place_id} = req.body;
    

    var url = "https://maps.googleapis.com/maps/api/place/details/json?place_id=" + place_id + "&key=AIzaSyBMDiwO_HOqZlM0g5glTlTMZd00ejdVYoA"


    // 'https://maps.googleapis.com/maps/api/place/details/json?place_id=ChIJN1t_tDeuEmsRUsoyG83frY4&fields=name%2Crating%2Cformatted_phone_number&key=YOUR_API_KEY',
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

exports.nextResults = asyncHandler(async (req, res, next) => {
    var {next_page_token} = req.body;
    

    var url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?pagetoken=" + next_page_token + "&key=AIzaSyBMDiwO_HOqZlM0g5glTlTMZd00ejdVYoA"


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