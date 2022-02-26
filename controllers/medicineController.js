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
    const medicineObject = await Medicine.find({$or: [
        {
            medicine_name: {
                $regex: name,
                $options: 'i'
            }
        }
    ],  
        user_id: req.user.id});

    var medicine_object = [];
    var medicinePromise = await medicineObject.map(async function(medicine){
        var patientObject = await Family.findOne({_id: medicine.patient});
        var userObject = await User.findOne({_id: medicine.user_id});

        medicine_object.push({
            _id: medicine._id,
            medicine_name: medicine.medicine_name,
            amount: medicine.amount,
            dosage: medicine.dosage,
            doses: medicine.doses,
            duration: medicine.duration,
            time: medicine.time,
            start_date: medicine.start_date,
            reminder_time: medicine.reminder_time,
            alarm_timer: medicine.alarm_timer,
            patient: patientObject,
            // user: userObject
            user_id: medicine.user_id

        });
    });
    await Promise.all(medicinePromise);
    res.status(200).json({ success: true, data: medicine_object });
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
    var patientObject = await Family.findOne({_id: medicine.patient});
    var userObject = await User.findOne({_id: medicine.user_id});

    var medicine_object = {
        _id: medicine._id,
        medicine_name: medicine.medicine_name,
        amount: medicine.amount,
        dosage: medicine.dosage,
        doses: medicine.doses,
        duration: medicine.duration,
        time: medicine.time,
        start_date: medicine.start_date,
        reminder_time: medicine.reminder_time,
        alarm_timer: medicine.alarm_timer,
        patient: patientObject,
        // user: userObject
        user_id: medicine.user_id

    };
    res.status(200).json({ success: true, data: medicine_object });
});


//get medicine by family
exports.getMedicineFamily = asyncHandler(async (req, res, next) => {
    var {patient} = req.body;
    const medicineObject = await Medicine.find({patient: patient});
    var medicine_object = [];
    var medicinePromise = await medicineObject.map(async function(medicine){
        var patientObject = await Family.findOne({_id: medicine.patient});
        var userObject = await User.findOne({_id: medicine.user_id});

        medicine_object.push({
            _id: medicine._id,
            medicine_name: medicine.medicine_name,
            amount: medicine.amount,
            dosage: medicine.dosage,
            doses: medicine.doses,
            duration: medicine.duration,
            time: medicine.time,
            start_date: medicine.start_date,
            reminder_time: medicine.reminder_time,
            alarm_timer: medicine.alarm_timer,
            patient: patientObject,
            // user: userObject
            user_id: medicine.user_id

        });
    });
    await Promise.all(medicinePromise);
    res.status(200).json({ success: true, data: medicine_object });
});
