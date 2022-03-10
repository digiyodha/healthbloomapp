var mongoose     = require('mongoose');
var Schema       = mongoose.Schema;

var InsuranceSchema = new Schema({
    organisation_name: String,
    insurance_image: [{
        type: String
    }],
    patient: {
        type: Schema.Types.ObjectId,
        ref: 'Family'
    },
    user_id: {
      type: Schema.Types.ObjectId,
      ref: 'User'
    }
},{
    timestamps: true
});


insurance = mongoose.model("Insurance", InsuranceSchema);


module.exports = {
    Insurance: insurance,
}