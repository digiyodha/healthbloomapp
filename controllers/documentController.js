const asyncHandler = require("../middlewares/asyncHandler");
const ErrorResponse = require("../utils/ErrorResponse");
const {User} = require("../models/user");
const {Family} = require("../models/family");
const {Bill} = require("../models/bill");
const { Prescription } = require("../models/prescription");
const { Report } = require("../models/report");



//list all documents
exports.getDocument = asyncHandler(async (req, res, next) => {
    var {from_date, to_date} = req.body;
    var billObject=[];
    var reportObject=[];
    var prescriptionObject= [];


    if(from_date == "" && to_date == "")
    {
        billObject = await Bill.find({user_id: req.user.id}).sort([['date', -1]]);
        reportObject = await Report.find({user_id: req.user.id}).sort([['date', -1]]);
        prescriptionObject = await Prescription.find({user_id: req.user.id}).sort([['consultation_date', -1]]);
    }
    else if(from_date == "")
    {
        billObject = await Bill.find({
            user_id: req.user.id,
            date: {
                $lte: to_date
            }
        }).sort([['date', -1]]);
        reportObject = await Report.find({
            user_id: req.user.id,
            date: {
                $lte: to_date
            }
        }).sort([['date', -1]]);
        prescriptionObject = await Prescription.find({
            user_id: req.user.id,
            consultation_date: {
                $lte: to_date
            }
        }).sort([['consultation_date', -1]]);
    }
    else if(to_date == "")
    {
        billObject = await Bill.find({
            user_id: req.user.id,
            date: {
                $gte: from_date
            }
        }).sort([['date', -1]]);
        reportObject = await Report.find({
            user_id: req.user.id,
            date: {
                $gte: from_date
            }
        }).sort([['date', -1]]);
        prescriptionObject = await Prescription.find({
            user_id: req.user.id,
            consultation_date: {
                $gte: from_date
            }
        }).sort([['consultation_date', -1]]);
    }
    else
    {
        billObject = await Bill.find({
            user_id: req.user.id,
            date: {
                $gte: from_date,
                $lte: to_date
            }
        }).sort([['date', -1]]);
        reportObject = await Report.find({
            user_id: req.user.id,
            date: {
                $gte: from_date,
                $lte: to_date
            }
        }).sort([['date', -1]]);
        prescriptionObject = await Prescription.find({
            user_id: req.user.id,
            consultation_date: {
                $gte: from_date,
                $lte: to_date
            }
        }).sort([['consultation_date', -1]]);
    }

    var bill_object = [];
    var billPromise = await billObject.map(async function(bill){
        var patientObject = await Family.findOne({_id: bill.patient});
        var userObject = await User.findOne({_id: bill.user_id});

        bill_object.push({
            _id: bill._id,
            name: bill.name,
            amount: bill.amount,
            date: bill.date,
            description: bill.description,
            bill_image: bill.bill_image,
            patient: patientObject,
            // user: userObject
            user_id: bill.user_id
        });
    });
    await Promise.all(billPromise);


    var report_object = [];
    var reportPromise = await reportObject.map(async function(report){
        var patientObject = await Family.findOne({_id: report.patient});
        var userObject = await User.findOne({_id: report.user_id});

        report_object.push({
            _id: report._id,
            name: report.name,
            date: report.date,
            description: report.description,
            report_image: report.report_image,
            patient: patientObject,
            // user: userObject
            user_id: report.user_id
        });
    });
    await Promise.all(reportPromise);

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


    var document = {
        bill: bill_object,
        report: report_object,
        prescription: prescription_object
    }
    res.status(200).json({ success: true, data: document });
});

//list all documents
exports.getDocumentFamily = asyncHandler(async (req, res, next) => {
    var {from_date, to_date, patient} = req.body;
    var billObject=[];
    var reportObject=[];
    var prescriptionObject= [];


    if(from_date == "" && to_date == "")
    {
        billObject = await Bill.find({user_id: req.user.id, patient: patient}).sort([['date', -1]]);
        reportObject = await Report.find({user_id: req.user.id, patient: patient}).sort([['date', -1]]);
        prescriptionObject = await Prescription.find({user_id: req.user.id, patient: patient}).sort([['consultation_date', -1]]);
    }
    else if(from_date == "")
    {
        billObject = await Bill.find({
            user_id: req.user.id,
            date: {
                $lte: to_date
            },
            patient: patient
        }).sort([['date', -1]]);
        reportObject = await Report.find({
            user_id: req.user.id,
            date: {
                $lte: to_date
            }, 
            patient: patient
        }).sort([['date', -1]]);
        prescriptionObject = await Prescription.find({
            user_id: req.user.id,
            consultation_date: {
                $lte: to_date
            }, 
            patient: patient
        }).sort([['consultation_date', -1]]);
    }
    else if(to_date == "")
    {
        billObject = await Bill.find({
            user_id: req.user.id,
            date: {
                $gte: from_date
            },
            patient: patient
        }).sort([['date', -1]]);
        reportObject = await Report.find({
            user_id: req.user.id,
            date: {
                $gte: from_date
            }, 
            patient: patient
        }).sort([['date', -1]]);
        prescriptionObject = await Prescription.find({
            user_id: req.user.id,
            consultation_date: {
                $gte: from_date
            }, 
            patient: patient
        }).sort([['consultation_date', -1]]);
    }
    else
    {
        billObject = await Bill.find({
            user_id: req.user.id,
            date: {
                $gte: from_date,
                $lte: to_date
            }, 
            patient: patient
        }).sort([['date', -1]]);
        reportObject = await Report.find({
            user_id: req.user.id,
            date: {
                $gte: from_date,
                $lte: to_date
            }, 
            patient: patient
        }).sort([['date', -1]]);
        prescriptionObject = await Prescription.find({
            user_id: req.user.id,
            consultation_date: {
                $gte: from_date,
                $lte: to_date
            }, 
            patient: patient
        }).sort([['consultation_date', -1]]);
    }

    var bill_object = [];
    var billPromise = await billObject.map(async function(bill){
        var patientObject = await Family.findOne({_id: bill.patient});
        var userObject = await User.findOne({_id: bill.user_id});

        bill_object.push({
            _id: bill._id,
            name: bill.name,
            amount: bill.amount,
            date: bill.date,
            description: bill.description,
            bill_image: bill.bill_image,
            patient: patientObject,
            // user: userObject
            user_id: bill.user_id
        });
    });
    await Promise.all(billPromise);


    var report_object = [];
    var reportPromise = await reportObject.map(async function(report){
        var patientObject = await Family.findOne({_id: report.patient});
        var userObject = await User.findOne({_id: report.user_id});

        report_object.push({
            _id: report._id,
            name: report.name,
            date: report.date,
            description: report.description,
            report_image: report.report_image,
            patient: patientObject,
            // user: userObject
            user_id: report.user_id
        });
    });
    await Promise.all(reportPromise);

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


    var document = {
        bill: bill_object,
        report: report_object,
        prescription: prescription_object
    }
    res.status(200).json({ success: true, data: document });
});