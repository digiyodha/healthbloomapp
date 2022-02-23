const asyncHandler = require("../middlewares/asyncHandler");
const ErrorResponse = require("../utils/ErrorResponse");
const {User} = require("../models/user");
const {Family} = require("../models/family");


//add family
exports.addFamilyMember = asyncHandler(async (req, res, next) => {
    var {name, relationship, age, avatar} = req.body;
    const user = await Family.create({
            name: name,
            relationship: relationship,
            age: age,
            avatar: avatar,
            user_id: req.user._id
    });
    if(!user)
    {
        return next(
        new ErrorResponse(`User id invalid`, 404)
        );
    }
    res.status(200).json({ success: true, data: user });
});

//edit family
exports.editFamilyMember = asyncHandler(async (req, res, next) => {
    var {name, relationship, age, avatar, _id} = req.body;
    const user = await Family.findOneAndUpdate({_id: _id},{
            name: name,
            relationship: relationship,
            age: age,
            avatar: avatar
    }, {new: true});
    if(!user)
    {
        return next(
        new ErrorResponse(`User id invalid`, 404)
        );
    }
    res.status(200).json({ success: true, data: user });
});

//get family
exports.getFamilyMember = asyncHandler(async (req, res, next) => {
    var {family_member_id} = req.body;
    const user = await Family.findOne({_id: family_member_id});
    if(!user)
    {
        return next(
        new ErrorResponse(`User id invalid`, 404)
        );
    }
    res.status(200).json({ success: true, data: user });
});

//get all family members
exports.getAllFamilyMembers = asyncHandler(async (req, res, next) => {
    const user = await Family.find({user_id: req.user._id});
    if(!user)
    {
        return next(
        new ErrorResponse(`User id invalid`, 404)
        );
    }
    res.status(200).json({ success: true, data: user });
});

//get family
exports.deleteFamilyMember = asyncHandler(async (req, res, next) => {
    var {family_member_id} = req.body;
    const user = await Family.findOneAndDelete({_id: family_member_id});
    if(!user)
    {
        return next(
        new ErrorResponse(`User id invalid`, 404)
        );
    }
    res.status(200).json({ success: true, data: user });
});
