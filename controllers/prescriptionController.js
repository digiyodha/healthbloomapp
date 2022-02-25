const asyncHandler = require("../middlewares/asyncHandler");
const ErrorResponse = require("../utils/ErrorResponse");
const {User} = require("../models/user");
const {Family} = require("../models/family");
const {Prescription} = require("../models/prescription");



//add Prescription
exports.addPrescription = asyncHandler(async (req, res, next) => {
    var {doctor_name, clinic_name, consultation_date, user_ailment, doctor_advice, prescription_image, patient} = req.body;
    const prescription = await Prescription.create({
        doctor_name:doctor_name,
        clinic_name: clinic_name,
        consultation_date: consultation_date,
        user_ailment: user_ailment,
        doctor_advice: doctor_advice,
        prescription_image: prescription_image,
        patient: patient, 
        user_id: req.user._id
    });
    if(!prescription)
    {
        return next(
        new ErrorResponse(`Prescription creation unsuccessful`, 404)
        );
    }
    res.status(200).json({ success: true, data: prescription });
});

//edit Prescription
exports.editPrescription = asyncHandler(async (req, res, next) => {
    var {doctor_name, clinic_name, consultation_date, user_ailment, doctor_advice, prescription_image, patient, _id} = req.body;
    const prescription = await Prescription.findOneAndUpdate({_id: _id},{
        doctor_name:doctor_name,
        clinic_name: clinic_name,
        consultation_date: consultation_date,
        user_ailment: user_ailment,
        doctor_advice: doctor_advice,
        prescription_image: prescription_image,
        patient: patient, 
    }, {new: true});
    console.log(prescription);
    if(!prescription)
    {
        return next(
        new ErrorResponse(`Prescription updation unsuccessful`, 404)
        );
    }
    res.status(200).json({ success: true, data: prescription });
});

//search Prescription
exports.searchPrescription = asyncHandler(async (req, res, next) => {
    var {name} = req.body;
    const prescription = await Prescription.find({$or: [
        {
            doctor_name: {
                $regex: name,
                $options: 'i'
            }
        },
        {
            clinic_name: {
                $regex: name,
                $options: 'i'
            }
        },
    ]});
    res.status(200).json({ success: true, data: prescription });
});

// //filter bill
// exports.filterBill = asyncHandler(async (req, res, next) => {
//     const {name} = req.body;
//     const bill = await Bill.find({$text: {$search: name}});
//     // if(!user)
//     // {
//     //     return next(
//     //     new ErrorResponse(`User id invalid`, 404)
//     //     );
//     // }
//     res.status(200).json({ success: true, data: bill });
// });

//delete prescription
exports.deletePrescription = asyncHandler(async (req, res, next) => {
    var {_id} = req.body;
    const prescription = await Prescription.findOneAndDelete({_id: _id});
    if(!prescription)
    {
        return next(
        new ErrorResponse(`Prescription id invalid`, 404)
        );
    }
    res.status(200).json({ success: true, data: prescription });
});

//get Prescription
exports.getPrescription = asyncHandler(async (req, res, next) => {
    var {_id} = req.body;
    const prescription = await Prescription.findOne({_id: _id});
    if(!prescription)
    {
        return next(
        new ErrorResponse(`Prescription id invalid`, 404)
        );
    }
    res.status(200).json({ success: true, data: prescription });
});
