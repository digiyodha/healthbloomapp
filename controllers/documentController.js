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
    var bill=[];
    var report=[];
    var prescription = [];


    if(from_date == "" && to_date == "")
    {
        bill = await Bill.find({user_id: req.user.id}).sort([['date', -1]]);
        report = await Report.find({user_id: req.user.id}).sort([['date', -1]]);
        prescription = await Prescription.find({user_id: req.user.id}).sort([['consultation_date', -1]]);
    }
    else if(from_date == "")
    {
        bill = await Bill.find({
            user_id: req.user.id,
            date: {
                $lte: to_date
            }
        }).sort([['date', -1]]);
        report = await Report.find({
            user_id: req.user.id,
            date: {
                $lte: to_date
            }
        }).sort([['date', -1]]);
        prescription = await Prescription.find({
            user_id: req.user.id,
            consultation_date: {
                $lte: to_date
            }
        }).sort([['consultation_date', -1]]);
    }
    else if(to_date == "")
    {
        bill = await Bill.find({
            user_id: req.user.id,
            date: {
                $gte: from_date
            }
        }).sort([['date', -1]]);
        report = await Report.find({
            user_id: req.user.id,
            date: {
                $gte: from_date
            }
        }).sort([['date', -1]]);
        prescription = await Prescription.find({
            user_id: req.user.id,
            consultation_date: {
                $gte: from_date
            }
        }).sort([['consultation_date', -1]]);
    }
    else
    {
        bill = await Bill.find({
            user_id: req.user.id,
            date: {
                $gte: from_date,
                $lte: to_date
            }
        }).sort([['date', -1]]);
        report = await Report.find({
            user_id: req.user.id,
            date: {
                $gte: from_date,
                $lte: to_date
            }
        }).sort([['date', -1]]);
        prescription = await Prescription.find({
            user_id: req.user.id,
            consultation_date: {
                $gte: from_date,
                $lte: to_date
            }
        }).sort([['consultation_date', -1]]);
    }


    var document = {
        bill: bill,
        report: report,
        prescription: prescription
    }
    res.status(200).json({ success: true, data: document });
});