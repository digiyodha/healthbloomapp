var mongoose     = require('mongoose');
var Schema       = mongoose.Schema;
const jwt = require("jsonwebtoken");
var bcrypt     = require('bcrypt');

var UserSchema = new Schema({
    name: String,
    email_id: String,
    password: String,
    country_code: String,
    phone_number: String,
    gender: {
      type: String,
      enum: ['Male', 'Female', 'Other'],
      default: 'Male'
    },
    google_address: String,
    user_address: String,
    city: String,
    state: String,
    blood_group: {
      type: String,
      enum: ['A+', 'B+', 'AB+', 'O+', 'A-', 'B-', 'AB-', 'O-'],
      default: 'O+'
    }
}, {strict: false}, {
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