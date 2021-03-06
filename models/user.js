var mongoose     = require('mongoose');
var Schema       = mongoose.Schema;
const jwt = require("jsonwebtoken");
var bcrypt     = require('bcrypt');

var UserSchema = new Schema({
    name: String,
    email_id: String,
    country_code: String,
    phone_number: String,
    gender: {
      type: String,
      enum: [null, 'Male', 'Female', 'Other'],
    },
    age: Number,
    // google_address: String,
    // user_address: String,
    latitude: String,
    longitude: String,
    city: String,
    state: String,
    avatar: String,
    blood_group: {
      type: String,
      enum: [null, 'A+', 'B+', 'AB+', 'O+', 'A-', 'B-', 'AB-', 'O-'],
    },
    uid: String,
    is_active: {
      type: Boolean,
      default: true
    },
    fcm_token: String,
    push_notification: {
      type: Boolean,
      default: true
    },
    vibration_mode: {
      type: Boolean,
      default: true
    },
    silent_mode: {
      type: Boolean,
      default: false
    }

}, {
  timestamps: true
});






// // Verify a password
// UserSchema.methods.verifyPassword = async function (plainPassword) {
//   return await bcrypt.compare(plainPassword, this.password);
// };

// // Sign and return a jwt
// UserSchema.methods.getJwtToken = function (userId) {
//   return jwt.sign({ data: userId }, "turtletechsai", {
//     expiresIn: '12h',
//   });
// };




user = mongoose.model("User", UserSchema);

module.exports = {
  User: user,
 

}