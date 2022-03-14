const asyncHandler = require("../middlewares/asyncHandler");
const ErrorResponse = require("../utils/ErrorResponse");
const {User} = require("../models/user");
const dbConfig = require('.././config/database.js');
const jwt = require('jsonwebtoken');
const _ = require('lodash');
const { Admin } = require("../models/admin");
const { Family } = require("../models/family");
const { subDays } = require("date-fns");
const { Medicine } = require("../models/medicine");




//register admin
exports.registerAdmin = asyncHandler(async (req, res, next) => {
    var {email_id,password} = req.body;
  
    const userDetailsObj = {};
    if (!_.isEmpty(email_id)) {
        userDetailsObj.email_id = email_id;
    }
    if (!_.isEmpty(password)) {
        userDetailsObj.password = password;
    }
    var user = await Admin.findOne({
        email_id: email_id,
    });
    if(user)
    {
        if(user.password == password)
        {
            return next(
            new ErrorResponse(`User already registered. Please login!`, 404)
            );
        }
        else
        {
            return next(
                new ErrorResponse(`Password incorrect!`, 404)
            );
        }
    }
    const userObject = await Admin.create({ ...userDetailsObj });
        
    res.status(200).json({ success: true, data: userObject });
  });


//login admin
exports.loginAdmin = asyncHandler(async (req, res, next) => {
    const { email_id, password } = req.body;

        const userExists = await Admin.findOne({
                email_id: email_id,
        });
        var userObject;

        if (!_.isEmpty(userExists)) {


            if(userExists.password != password)
            {
                return next(
                    new ErrorResponse(`Incorrect password!`, 404)
                );
            }
            else
            {

            var token = jwt.sign({ data: userExists._id }, dbConfig.JWT_SECRET, {
                expiresIn: '12h',
              });
              userObject = {
                email_id,
                x_auth_token: token,
                id: userExists._id,
            };
        }
        }
        else
        {
            return next(
                new ErrorResponse(`User doesn't exist, please register!`, 404)
                );
        }
        
    res.status(200).json({ success: true, data: userObject });
  });



//get admin
exports.getAdmin = asyncHandler(async (req, res, next) => {

        const userObject = await Admin.findOne({_id:req.user._id});

        
    res.status(200).json({ success: true, data: userObject });
  });


  
//get user list
exports.getUserList = asyncHandler(async (req, res, next) => {

    const userObject = await User.find({});
    var user_object = [];
    var userPromise = await userObject.map(async function(user){
        var familyObject = await Family.find({user_id: user._id});
        user_object.push({
            avatar: user.avatar,
            _id: user._id,
            email_id: user.email_id,
            phone_number: user.phone_number,
            is_active: user.is_active,
            familyObject: familyObject,
            name: user.name,
            gender: user.gender,
            country_code: user.country_code,
            google_address: user.google_address,
            user_address: user.user_address,
            city: user.city,
            state: user.state,
            blood_group: user.blood_group,
            uid: user.uid
        });

    });
    await Promise.all(userPromise);

    
res.status(200).json({ success: true, data: user_object });
});

exports.switchUser = asyncHandler(async (req, res, next) => {

    const {user_id} = req.body;
    const userObject = await User.findOne({_id: user_id});

    await User.update({_id: user_id}, {is_active: !userObject.is_active});
    
    const user_object = await User.findOne({_id: user_id});
    
res.status(200).json({ success: true, data: user_object });
});
  

exports.analytics = asyncHandler(async (req, res, next) => {

    var totalUsers = await User.find({});

    var activeUsers = await User.find({is_active: true});

    var deletedUsers = await User.find({is_active: false});

    var date = Date.now();

    var newUsers = await User.find({
        createdAt: {
                $gt: subDays(date, 1)
        }
    });

    console.log(newUsers);

    var analyticsObject = {
        totalUsers: totalUsers.length,
        activeUsers: activeUsers.length,
        deletedUsers: deletedUsers.length,
        newUsers: newUsers.length
    }
    
res.status(200).json({ success: true, data: analyticsObject });
});
  
  