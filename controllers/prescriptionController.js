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
    const prescriptionObject = await Prescription.find({$or: [
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
    ],  
        user_id: req.user.id
    });

    var prescription_object = [];
    var prescriptionPromise = await prescriptionObject.map(async function(prescription){
        var patientObject = await Family.findOne({_id: prescription.patient});
        var userObject = await User.findOne({_id: prescription.user_id});

        prescription_object.push({
            _id: prescription._id,
            doctor_name: prescription.doctor_name,
            clinic_name: prescription.clinic_name,
            user_ailment: prescription.user_ailment,
            consultation_date: prescription.consultation_date,
            doctor_advice: prescription.doctor_advice,
            prescription_image: prescription.prescription_image,
            patient: patientObject,
            // user: userObject
            user_id: prescription.user_id

        });
    });
    await Promise.all(prescriptionPromise);

    res.status(200).json({ success: true, data: prescription_object });
});

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

    var patientObject = await Family.findOne({_id: prescription.patient});
    var userObject = await User.findOne({_id: prescription.user_id});

    var prescription_object = {
        _id: prescription._id,
        doctor_name: prescription.doctor_name,
        clinic_name: prescription.clinic_name,
        user_ailment: prescription.user_ailment,
        consultation_date: prescription.consultation_date,
        doctor_advice: prescription.doctor_advice,
        prescription_image: prescription.prescription_image,
        patient: patientObject,
        // user: userObject
        user_id: prescription.user_id

    };

    res.status(200).json({ success: true, data: prescription_object });
});

//get Prescription by family member
exports.getPrescriptionFamily = asyncHandler(async (req, res, next) => {
    var {patient} = req.body;
    const prescriptionObject = await Prescription.find({patient: patient}).sort([['consultation_date', -1]]);


    var prescription_object = [];
    var prescriptionPromise = await prescriptionObject.map(async function(prescription){
        var patientObject = await Family.findOne({_id: prescription.patient});
        var userObject = await User.findOne({_id: prescription.user_id});

        prescription_object.push({
            _id: prescription._id,
            doctor_name: prescription.doctor_name,
            clinic_name: prescription.clinic_name,
            user_ailment: prescription.user_ailment,
            consultation_date: prescription.consultation_date,
            doctor_advice: prescription.doctor_advice,
            prescription_image: prescription.prescription_image,
            patient: patientObject,
            // user: userObject
            user_id: prescription.user_id

        });
    });
    await Promise.all(prescriptionPromise);
    res.status(200).json({ success: true, data: prescription_object });
});
