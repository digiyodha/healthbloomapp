const asyncHandler = require("../middlewares/asyncHandler");
const ErrorResponse = require("../utils/ErrorResponse");
const {User} = require("../models/user");
const {Family} = require("../models/family");
const {Report} = require("../models/report");



//add Report
exports.addReport = asyncHandler(async (req, res, next) => {
    var {name, date, description, report_image, patient} = req.body;
    const report = await Report.create({
        name: name,
        date: date,
        description: description,
        report_image: report_image,
        patient: patient, 
        user_id: req.user._id
    });
    if(!report)
    {
        return next(
        new ErrorResponse(`Report creation unsuccessful`, 404)
        );
    }
    res.status(200).json({ success: true, data: report });
});

//edit Report
exports.editReport = asyncHandler(async (req, res, next) => {
    var {name, date, description, report_image, patient, _id} = req.body;
    const report = await Report.findOneAndUpdate({_id: _id},{
        name: name,
        date: date,
        description: description,
        report_image: report_image,
        patient: patient, 
    }, {new: true});
    console.log(report);
    if(!report)
    {
        return next(
        new ErrorResponse(`Report updation unsuccessful`, 404)
        );
    }
    res.status(200).json({ success: true, data: report });
});

//search Report
exports.searchReport = asyncHandler(async (req, res, next) => {
    var {name} = req.body;
    const reportObject = await Report.find().where({name: {
        $regex: name,
        $options: 'i'
        },  
        user_id: req.user.id});
    
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
            user: userObject
        });
    });
    await Promise.all(reportPromise);

    res.status(200).json({ success: true, data: report_object });
});


//delete report
exports.deleteReport = asyncHandler(async (req, res, next) => {
    var {_id} = req.body;
    const report = await Report.findOneAndDelete({_id: _id});
    if(!report)
    {
        return next(
        new ErrorResponse(`Report id invalid`, 404)
        );
    }
    res.status(200).json({ success: true, data: report });
});

//get report
exports.getReport = asyncHandler(async (req, res, next) => {
    var {_id} = req.body;
    const report = await Report.findOne({_id: _id});
    if(!report)
    {
        return next(
        new ErrorResponse(`Report id invalid`, 404)
        );
    }

    var patientObject = await Family.findOne({_id: report.patient});
    var userObject = await User.findOne({_id: report.user_id});

    var report_object = {
        _id: report._id,
        name: report.name,
        date: report.date,
        description: report.description,
        report_image: report.report_image,
        patient: patientObject,
        user: userObject
    };
    
    res.status(200).json({ success: true, data: report_object });
});

//get report by family member
exports.getReportFamily = asyncHandler(async (req, res, next) => {
    var {patient} = req.body;
    const reportObject = await Report.find({patient: patient}).sort([['date', -1]]);
    
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
            user: userObject
        });
    });
    await Promise.all(reportPromise);
    res.status(200).json({ success: true, data: report_object });
});
