const asyncHandler = require("../middlewares/asyncHandler");
const ErrorResponse = require("../utils/ErrorResponse");
const {User} = require("../models/user");
const dbConfig = require('.././config/database.js');
const jwt = require('jsonwebtoken');


//get user
exports.getUser = asyncHandler(async (req, res, next) => {
  // var {public_key} = req.body;
  console.log(req.user)
  if (!req.user) {
    return next(
      new ErrorResponse(`No such user`, 404)
    );
  }
  res.status(200).json({ success: true, data: req.user });
});


//register login
exports.registerLoginUser = asyncHandler(async (req, res, next) => {
  var {email_id, uid, avatar, phone_number, country_code, name, fcm_token} = req.body;

  var new_user = false;

  var user = await User.findOne({
    'uid': uid
  });
  if(!user)
  {
    const userDetailsObj = {};
    if (email_id) {
        userDetailsObj.email_id = email_id;
    }else{
      userDetailsObj.email_id = null;
    }
    if (uid) {
        userDetailsObj.uid = uid;
    }else{
      userDetailsObj.uid = null;
    }
    if (avatar) {
        userDetailsObj.avatar = avatar;
    }else{ 
      userDetailsObj.avatar = null;
    }
    if (country_code) {
      userDetailsObj.country_code = country_code;
    }else{
      userDetailsObj.country_code = null;
    }
    if (phone_number) {
      userDetailsObj.phone_number = phone_number;
    }else{
      userDetailsObj.phone_number = null;
    }
    if (name) {
      userDetailsObj.name = name;
    }else{
      userDetailsObj.name = null;
    }
    if(fcm_token){
      userDetailsObj.fcm_token = fcm_token;
    }else{
      userDetailsObj.fcm_token = null;
    }

    userDetailsObj.google_address = null;
    userDetailsObj.user_address = null;
    userDetailsObj.city = null;
    userDetailsObj.state = null;
    userDetailsObj.gender = null;
    userDetailsObj.blood_group = null;
    userDetailsObj.is_active = true;
    user = await User.create({ ...userDetailsObj });
    new_user = true;
  }
  else
  {
    if(user.is_active == false)
    {
      return next(
        new ErrorResponse(`User deactivated!`, 404)
      );
    }
  }
  var token = jwt.sign({ data: user._id }, dbConfig.JWT_SECRET, {
    expiresIn: '12h',
  });

  if(fcm_token != null)
  {
    await User.findOneAndUpdate({_id: user._id}, {fcm_token: fcm_token});
  }

  user = await User.findOne({_id: user._id});
  console.log(user);



  const userData = {
    _id: user._id,
    name: user.name,
    email_id: user.email_id,
    uid: user.uid,
    gender: user.gender,
    avatar: user.avatar,
    country_code: user.country_code,
    phone_number: user.phone_number,
    google_address: user.google_address,
    user_address: user.user_address,
    city: user.city,
    state: user.state,
    blood_group: user.blood_group,
    x_auth_token: token,
    is_active: user.is_active,
    new_user: new_user,
    fcm_token: user.fcm_token
  }
  res.status(200).json({ success: true, data: userData });
});



//add edit user details
exports.addEditUserDetails = asyncHandler(async (req, res, next) => {
    var {gender, country_code, phone_number, avatar, name, 
      google_address, user_address, city, state, blood_group, _id} = req.body;
  const user = await User.findOneAndUpdate({ _id: _id },  {
    gender: gender,
    avatar: avatar,
    country_code: country_code,
    phone_number: phone_number,
    google_address: google_address,
    user_address: user_address,
    city: city,
    state: state,
    blood_group: blood_group,
    name: name
  } , {
      new: true
  });
  if (!user) {
    return next(
      new ErrorResponse(`No such user`, 404)
    );
  }
  res.status(200).json({ success: true, data: user });
});


//delete user
exports.deleteUser = asyncHandler(async (req, res, next) => {
  // var {public_key} = req.body;
  const user = await User.findOne().where('_id').equals(req.user._id);

  if (!user) {
    return next(
      new ErrorResponse(`No such user`, 404)
    );
  }
  var deleteUser = await User.findOneAndDelete({_id: req.user._id});
  res.status(200).json({ success: true, data: deleteUser });
});

//edit settings
exports.editSettings = asyncHandler(async (req, res, next) => {
  var {push_notification, silent_mode, vibration_mode} = req.body;
  const user = await User.findOneAndUpdate({ _id: req.user._id },  {
    push_notification: push_notification,
    silent_mode: silent_mode,
    vibration_mode: vibration_mode
  } , {
      new: true
  });
  if (!user) {
    return next(
      new ErrorResponse(`No such user`, 404)
    );
  }
res.status(200).json({ success: true, data: user });
});


