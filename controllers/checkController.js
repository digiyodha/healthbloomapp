const asyncHandler = require("../middlewares/asyncHandler");
const ErrorResponse = require("../utils/ErrorResponse");
const {User} = require("../models/user");
const dbConfig = require('.././config/database.js');
const jwt = require('jsonwebtoken');
const { WaterCheck, MedicineCheck } = require("../models/check");


//check water
exports.waterCheck = asyncHandler(async (req, res, next) => {
    const {target_amount, daily_water_consumed} = req.body;

    var dateObj = new Date();
    var start_date = dateObj.setHours(0,0,0,0);
    var end_date = dateObj.setHours(24, 0, 0, 0);

    console.log(dateObj);
    console.log(new Date(start_date));
    console.log(new Date(end_date));


    var waterObject = await WaterCheck.findOne({ 
        date: {
            $gte: new Date(start_date), 
            $lt: new Date(end_date)
        },
        user_id: req.user._id
    });
    console.log(waterObject);

    var water_object;

    if(waterObject)
    {
        console.log('Inside water object');
        water_object = await WaterCheck.findOneAndUpdate({
            _id: waterObject._id
        }, {
            target_amount: target_amount,
            daily_water_consumed: daily_water_consumed,
            date: dateObj,
            user_id: req.user._id
        }, {new: true});
    }
    else
    {
        water_object = await WaterCheck.create({
            target_amount: target_amount,
            daily_water_consumed: daily_water_consumed,
            date: dateObj,
            user_id: req.user._id
        });
    }

    

    console.log(water_object)
    if (!water_object) {
      return next(
        new ErrorResponse(`Water consumption not added`, 404)
      );
    }
    res.status(200).json({ success: true, data: water_object });
  });

exports.medicineCheck = asyncHandler(async (req, res, next) => {
const {_id} = req.body;

var medicineObject = await MedicineCheck.findOneAndUpdate({_id: _id}, 
{
    check: true
},  {new: true});

if (!medicineObject) {
    return next(
    new ErrorResponse(`Medicine check issue`, 404)
    );
}
res.status(200).json({ success: true, data: medicineObject });
});

exports.healthScore = asyncHandler(async (req, res, next) => {
    
    var dateObj = new Date();

    var start_date = dateObj.setHours(0,0,0,0);
    var end_date = dateObj.setHours(24, 0, 0, 0);

    console.log(dateObj);
    console.log(new Date(start_date));
    console.log(new Date(end_date));


    var medicineObject = await MedicineCheck.find({ 
        medicine_time: {
            $gte: new Date(start_date), 
            $lt: new Date(end_date)
        },
        user_id: req.user._id
    });
    console.log(medicineObject);

    var tablets_consumed = 0;
    var total_tablets = medicineObject.length;

    var medicinePromise = await medicineObject.map(async function(medicine){
        if(medicine.check)
            tablets_consumed += 1;
    });
    await Promise.all(medicinePromise);


    var medicineScore = 100;
    if(medicineObject.length != 0)
    {
        medicineScore = (tablets_consumed/total_tablets) * 100;
    }
    console.log(medicineScore);

    var waterObject = await WaterCheck.findOne({ 
        date: {
            $gte: new Date(start_date), 
            $lt: new Date(end_date)
        },
        user_id: req.user._id
    });
    console.log(waterObject);

    var waterScore = 100;
    var daily_water_consumed = 0;
    var target_amount = 1200;

    if(waterObject)
    {
        daily_water_consumed = waterObject.daily_water_consumed;
        target_amount = waterObject.target_amount;
    }

    waterScore = (daily_water_consumed/target_amount) * 100;
    console.log(waterScore);

    var healthScore = 100;
    healthScore = (waterScore+medicineScore)/2;


    res.status(200).json({ success: true, data: {score: healthScore} });
  });