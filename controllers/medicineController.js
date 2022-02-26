const asyncHandler = require("../middlewares/asyncHandler");
const ErrorResponse = require("../utils/ErrorResponse");
const {User} = require("../models/user");
const {Family} = require("../models/family");
const {Bill} = require("../models/bill");
const { Medicine } = require("../models/medicine");



//add Medicine
exports.addMedicine = asyncHandler(async (req, res, next) => {
    var {medicine_name, amount, dosage, doses, duration, time, start_date,
        reminder_time, alarm_timer, patient} = req.body;
    const medicine = await Medicine.create({
        medicine_name: medicine_name,
        amount: amount,
        dosage: dosage,
        doses: doses,
        duration: duration,
        time: time,
        start_date: start_date,
        reminder_time: reminder_time,
        alarm_timer: alarm_timer,
        patient: patient, 
        user_id: req.user._id
    });
    if(!medicine)
    {
        return next(
        new ErrorResponse(`Medicine creation unsuccessful`, 404)
        );
    }
    res.status(200).json({ success: true, data: medicine });
});

//edit Medicine
exports.editMedicine = asyncHandler(async (req, res, next) => {
    var {medicine_name, amount, dosage, doses, duration, time, start_date,
        reminder_time, alarm_timer, patient, _id} = req.body;
    const medicine = await Medicine.findOneAndUpdate({_id: _id},{
        medicine_name: medicine_name,
        amount: amount,
        dosage: dosage,
        doses: doses,
        duration: duration,
        time: time,
        start_date: start_date,
        reminder_time: reminder_time,
        alarm_timer: alarm_timer,
        patient: patient, 
        user_id: req.user._id
    });
    if(!medicine)
    {
        return next(
        new ErrorResponse(`Medicine creation unsuccessful`, 404)
        );
    }
    res.status(200).json({ success: true, data: medicine });
});

//search Medicine
exports.searchMedicine = asyncHandler(async (req, res, next) => {
    var {name} = req.body;
    // const bill = await Bill.find({$text: {$search: name}});
    const medicine = await Medicine.find({$or: [
        {
            medicine_name: {
                $regex: name,
                $options: 'i'
            }
        }
    ],  
        user_id: req.user.id});
    res.status(200).json({ success: true, data: medicine });
});


//delete medicine
exports.deleteMedicine = asyncHandler(async (req, res, next) => {
    var {_id} = req.body;
    const medicine = await Medicine.findOneAndDelete({_id: _id});
    if(!medicine)
    {
        return next(
        new ErrorResponse(`Medicine id invalid`, 404)
        );
    }
    res.status(200).json({ success: true, data: medicine });
});

//get medicine
exports.getMedicine = asyncHandler(async (req, res, next) => {
    var {_id} = req.body;
    const medicine = await Medicine.findOne({_id: _id});
    if(!medicine)
    {
        return next(
        new ErrorResponse(`Medicine id invalid`, 404)
        );
    }
    res.status(200).json({ success: true, data: medicine });
});


//get medicine by family
exports.getMedicineFamily = asyncHandler(async (req, res, next) => {
    var {patient} = req.body;
    const medicine = await Medicine.find({patient: patient});
    if(!medicine)
    {
        return next(
        new ErrorResponse(`Medicine id invalid`, 404)
        );
    }
    res.status(200).json({ success: true, data: medicine });
});
