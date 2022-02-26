const asyncHandler = require("../middlewares/asyncHandler");
const ErrorResponse = require("../utils/ErrorResponse");
const {User} = require("../models/user");
const {Family} = require("../models/family");
const {Bill} = require("../models/bill");
const { Insurance } = require("../models/insurance");



//add Insurance
exports.addInsurance = asyncHandler(async (req, res, next) => {
    var {organisation_name, patient, insurance_image} = req.body;
    const insurance = await Insurance.create({
            organisation_name: organisation_name,
            patient: patient, 
            insurance_image: insurance_image,
            user_id: req.user._id
    });
    if(!insurance)
    {
        return next(
        new ErrorResponse(`Insurance creation unsuccessful`, 404)
        );
    }
    res.status(200).json({ success: true, data: insurance });
});

//edit Insurance
exports.editInsurance = asyncHandler(async (req, res, next) => {
    var {organisation_name, insurance_image, patient, _id} = req.body;
    const insurance = await Insurance.findOneAndUpdate({_id: _id},{
        insurance_image: insurance_image,
        organisation_name: organisation_name,
        patient: patient, 
    }, {new: true});
    console.log(insurance);
    if(!insurance)
    {
        return next(
        new ErrorResponse(`Insurance updation unsuccessful`, 404)
        );
    }
    res.status(200).json({ success: true, data: insurance });
});

//search insurance
exports.searchInsurance = asyncHandler(async (req, res, next) => {
    var {name} = req.body;
    const insurance = await Insurance.find({$or: [
        {
            organisation_name: {
                $regex: name,
                $options: 'i'
            }
        }
    ],  
        user_id: req.user.id});
    res.status(200).json({ success: true, data: insurance });
});


//delete insurance
exports.deleteInsurance = asyncHandler(async (req, res, next) => {
    var {_id} = req.body;
    const insurance = await Insurance.findOneAndDelete({_id: _id});
    if(!insurance)
    {
        return next(
        new ErrorResponse(`Insurance id invalid`, 404)
        );
    }
    res.status(200).json({ success: true, data: insurance });
});

//get insurance
exports.getInsurance = asyncHandler(async (req, res, next) => {
    var {_id} = req.body;
    const insurance = await Insurance.findOne({_id: _id});
    if(!insurance)
    {
        return next(
        new ErrorResponse(`Insurance id invalid`, 404)
        );
    }
    res.status(200).json({ success: true, data: insurance });
});


//get insurance by family
exports.getInsuranceFamily = asyncHandler(async (req, res, next) => {
    var {patient} = req.body;
    const insurance = await Insurance.find({patient: patient});
    if(!insurance)
    {
        return next(
        new ErrorResponse(`Insurance id invalid`, 404)
        );
    }
    res.status(200).json({ success: true, data: insurance});
});
