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


// //register
// exports.registerUser = asyncHandler(async (req, res, next) => {
//   var {email_id, name, password} = req.body;

//   var user = await User.findOne({
//     'email_id': email_id,
//     'password': password
//   });
//   if(!user)
//   {
//     const userDetailsObj = {};
//     if (email_id) {
//         userDetailsObj.email_id = email_id;
//     }
//     if (password) {
//         userDetailsObj.password = password;
//     }
//     if (name) {
//         userDetailsObj.name = name;
//     }

//     userDetailsObj.country_code = "";
//     userDetailsObj.phone_number = "";
//     userDetailsObj.google_address = "";
//     userDetailsObj.user_address = "";
//     userDetailsObj.city = "";
//     userDetailsObj.state = "";
//     userDetailsObj.avatar = "";
//     user = await User.create({ ...userDetailsObj });
//   }
//   else
//   {
//     return next(
//       new ErrorResponse(`User already exists, please login!`, 404)
//     );
//   }
//   res.status(200).json({ success: true, data: user });
// });

//register login
exports.registerLoginUser = asyncHandler(async (req, res, next) => {
  var {email_id, uid, avatar, phone_number, country_code, name} = req.body;

  var user = await User.findOne({
    'uid': uid
  });
  if(!user)
  {
    const userDetailsObj = {};
    if (email_id) {
        userDetailsObj.email_id = email_id;
    }else{
      userDetailsObj.email_id = "";
    }
    if (uid) {
        userDetailsObj.uid = uid;
    }else{
      userDetailsObj.uid = "";
    }
    if (avatar) {
        userDetailsObj.avatar = avatar;
    }else{ 
      userDetailsObj.avatar = "";
    }
    if (country_code) {
      userDetailsObj.country_code = country_code;
    }else{
      userDetailsObj.country_code = "";
    }
    if (phone_number) {
      userDetailsObj.phone_number = phone_number;
    }else{
      userDetailsObj.phone_number = "";
    }
    if (name) {
      userDetailsObj.name = name;
    }else{
      userDetailsObj.name = "";
    }

    userDetailsObj.google_address = "";
    userDetailsObj.user_address = "";
    userDetailsObj.city = "";
    userDetailsObj.state = "";
    user = await User.create({ ...userDetailsObj });
  }
  var token = jwt.sign({ data: user._id }, dbConfig.JWT_SECRET, {
    expiresIn: '12h',
  });

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
    x_auth_token: token
  }
  res.status(200).json({ success: true, data: userData });
});


// //login
// exports.loginUser = asyncHandler(async (req, res, next) => {
//   var {email_id, password} = req.body;

//   var user = await User.findOne({
//     'email_id': email_id
//   });
//   if(!user)
//   {
//     return next(
//       new ErrorResponse(`User doesn't exist, please register!`, 404)
//     );
//   }

//   user = await User.findOne({
//     'email_id': email_id,
//     'password': password
//   });
//   console.log(user);
//   if(!user)
//   {
//     return next(
//       new ErrorResponse(`Password incorrrect!`, 404)
//     );
//   }
  
//   var token = jwt.sign({ data: user._id }, dbConfig.JWT_SECRET, {
//     expiresIn: '12h',
//   });

//   const userData = {
//     email_id: user.email_id,
//     _id: user._id,
//     x_auth_token: token
//   }
//   res.status(200).json({ success: true, data: userData });
// });



//add edit user details
exports.addEditUserDetails = asyncHandler(async (req, res, next) => {
    var {gender, country_code, phone_number, avatar, 
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
    blood_group: blood_group
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

