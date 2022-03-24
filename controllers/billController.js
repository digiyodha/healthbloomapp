const asyncHandler = require("../middlewares/asyncHandler");
const ErrorResponse = require("../utils/ErrorResponse");
const {User} = require("../models/user");
const {Family} = require("../models/family");
const {Bill, BillAsset} = require("../models/bill");



//add Bill
exports.addBill = asyncHandler(async (req, res, next) => {
    var {name, amount, date, description, bill_image, patient} = req.body;
    const bill = await Bill.create({
            name: name,
            amount: amount,
            date: date,
            description: description,
            patient: patient, 
            user_id: req.user._id
    });
    if(!bill)
    {
        return next(
        new ErrorResponse(`Bill creation unsuccessful`, 404)
        );
    }

    var billPromise = await bill_image.map(async function(image){
        await BillAsset.create({
            bill_id: bill._id,
            asset_url: image.asset_url,
            asset_name: image.asset_name,
            asset_type: image.asset_type,
            asset_size: image.asset_size,
            thumbnail_url: image.thumbnail_url
        });
    });
    await Promise.all(billPromise);


    res.status(200).json({ success: true, data: bill });
});

//edit Bill
exports.editBill = asyncHandler(async (req, res, next) => {
    var {name, amount, date, description, bill_image, patient, _id} = req.body;
    const bill = await Bill.findOneAndUpdate({_id: _id},{
        name: name,
        amount: amount,
        date: date,
        description: description,
        patient: patient, 
    }, {new: true});
    console.log(bill);
    if(!bill)
    {
        return next(
        new ErrorResponse(`Bill updation unsuccessful`, 404)
        );
    }

    await BillAsset.deleteMany({bill_id: _id});

    var billPromise = await bill_image.map(async function(image){
        await BillAsset.create({
            bill_id: _id,
            asset_url: image.asset_url,
            asset_name: image.asset_name,
            asset_type: image.asset_type,
            asset_size: image.asset_size,
            thumbnail_url: image.thumbnail_url
        });
    });
    await Promise.all(billPromise);

    res.status(200).json({ success: true, data: bill });
});

//search bill
exports.searchBill = asyncHandler(async (req, res, next) => {
    var {name} = req.body;
    // const bill = await Bill.find({$text: {$search: name}});
    var bill_object = [];
    const billObject = await Bill.find({$or: [
        {
            name: {
                $regex: name,
                $options: 'i'
            }
        },
        {
            description: {
                $regex: name,
                $options: 'i'
            }
        },

    ],  
        user_id: req.user.id});

    var billPromise = await billObject.map(async function(bill){
        var patientObject = await Family.findOne({_id: bill.patient});
        var userObject = await User.findOne({_id: bill.user_id});
        var assetObject = await BillAsset.find({bill_id: bill._id});

        bill_object.push({
            _id: bill._id,
            name: bill.name,
            amount: bill.amount,
            date: bill.date,
            description: bill.description,
            bill_image: assetObject,
            patient: patientObject,
            // user: userObject
            user_id: bill.user_id
        });
    });
    await Promise.all(billPromise);
    res.status(200).json({ success: true, data: bill_object });
});


//delete bill
exports.deleteBill = asyncHandler(async (req, res, next) => {
    var {_id} = req.body;

    await BillAsset.deleteMany({bill_id: _id});
    const bill = await Bill.findOneAndDelete({_id: _id});
    if(!bill)
    {
        return next(
        new ErrorResponse(`Bill id invalid`, 404)
        );
    }
    res.status(200).json({ success: true, data: bill });
});

//get bill
exports.getBill = asyncHandler(async (req, res, next) => {
    var {_id} = req.body;
    const bill = await Bill.findOne({_id: _id});
    if(!bill)
    {
        return next(
        new ErrorResponse(`Bill id invalid`, 404)
        );
    }
    var patientObject = await Family.findOne({_id: bill.patient});
    var userObject = await User.findOne({_id: bill.user_id});
    var assetObject = await BillAsset.find({bill_id: bill._id});


    var bill_object = {
        _id: bill._id,
        name: bill.name,
        amount: bill.amount,
        date: bill.date,
        description: bill.description,
        bill_image: assetObject,
        patient: patientObject,
        // user: userObject
        user_id: bill.user_id
    };
    
    res.status(200).json({ success: true, data: bill_object });
});


//get bill by family
exports.getBillFamily = asyncHandler(async (req, res, next) => {
    var {patient} = req.body;
    var bill_object = [];
    const billObject = await Bill.find({patient: patient}).sort([['date', -1]]);

    var billPromise = await billObject.map(async function(bill){
        var patientObject = await Family.findOne({_id: bill.patient});
        var userObject = await User.findOne({_id: bill.user_id});
        var assetObject = await BillAsset.find({bill_id: bill._id});


        bill_object.push({
            _id: bill._id,
            name: bill.name,
            amount: bill.amount,
            date: bill.date,
            description: bill.description,
            bill_image: assetObject,
            patient: patientObject,
            // user: userObject
            user_id: bill.user_id
        });
    });
    await Promise.all(billPromise);
    res.status(200).json({ success: true, data: bill_object });
});
