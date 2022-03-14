const jwt = require("jsonwebtoken");
const {User} = require("../models/user");
const {Admin} = require("../models/admin");
const ErrorResponse = require("../utils/ErrorResponse");
const asyncHandler = require("./asyncHandler");
const dbConfig = require('.././config/database.js');


// Make access to routes private
exports.protect = asyncHandler(async (req, res, next) => {
  // let token = req.headers.authorization;

  // if (
  //   req.headers.authorization &&
  //   req.headers.authorization.startsWith("Bearer")
  // ) {
  //   token = req.headers.authorization.split(" ")[1];
  // } else if (req.cookies["TOKEN"]) {
  //   token = req.cookies["TOKEN"];
  // }

  let token = req.headers['x-auth-token'] || req.query['validate-token'];

  if (!token) {
    return next(new ErrorResponse(`Not authorized to access this route`, 401));
  }

  try {
    console.log(token);
    // Attach found user to req.body
    const { data: userId } = jwt.verify(token, dbConfig.JWT_SECRET);
    console.log(jwt.verify(token, dbConfig.JWT_SECRET));
    req.user = await User.findById(userId);
    next();
  } catch (error) {
    next(new ErrorResponse(`Not authorized to access this route`, 401));
  }
});


exports.adminProtect = asyncHandler(async (req, res, next) => {
  let token = req.headers['x-auth-token'] || req.query['validate-token'];

  if (!token) {
    return next(new ErrorResponse(`Not authorized to access this route`, 401));
  }

  try {
    console.log(token);
    // Attach found user to req.body
    const { data: userId } = jwt.verify(token, dbConfig.JWT_SECRET);
    console.log(jwt.verify(token, dbConfig.JWT_SECRET));
    req.user = await Admin.findById(userId);
    next();
  } catch (error) {
    next(new ErrorResponse(`Not authorized to access this route`, 401));
  }
});
