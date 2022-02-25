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
    const report = await Report.find().where({name: {
        $regex: name,
        $options: 'i'
        }});
    res.status(200).json({ success: true, data: report });
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
    res.status(200).json({ success: true, data: report });
});
