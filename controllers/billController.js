const asyncHandler = require("../middlewares/asyncHandler");
const ErrorResponse = require("../utils/ErrorResponse");
const {User} = require("../models/user");
const {Family} = require("../models/family");
const {Bill} = require("../models/bill");



//add Bill
exports.addBill = asyncHandler(async (req, res, next) => {
    var {name, amount, date, description, bill_image, patient} = req.body;
    const bill = await Bill.create({
            name: name,
            amount: amount,
            date: date,
            description: description,
            bill_image: bill_image,
            patient: patient, 
            user_id: req.user._id
    });
    if(!bill)
    {
        return next(
        new ErrorResponse(`Bill creation unsuccessful`, 404)
        );
    }
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
        bill_image: bill_image,
        patient: patient, 
    }, {new: true});
    console.log(bill);
    if(!bill)
    {
        return next(
        new ErrorResponse(`Bill updation unsuccessful`, 404)
        );
    }
    res.status(200).json({ success: true, data: bill });
});

//search bill
exports.searchBill = asyncHandler(async (req, res, next) => {
    var {name} = req.body;
    const bill = await Bill.find().where({name: {
        $regex: name
        }});
    res.status(200).json({ success: true, data: bill });
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

//delete bill
exports.deleteBill = asyncHandler(async (req, res, next) => {
    var {_id} = req.body;
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
    res.status(200).json({ success: true, data: bill });
});
