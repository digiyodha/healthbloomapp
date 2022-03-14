var mongoose     = require('mongoose');
var Schema       = mongoose.Schema;
const jwt = require("jsonwebtoken");
var bcrypt     = require('bcrypt');

var AdminSchema = new Schema({
    email_id: String,
    password: String,
}, {
  timestamps: true
});


admin = mongoose.model("Admin", AdminSchema);

module.exports = {
  Admin: admin,
}