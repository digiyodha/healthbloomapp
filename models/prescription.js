var mongoose     = require('mongoose');
var Schema       = mongoose.Schema;


var PrescriptionSchema = new Schema({
    doctor_name: String,
    clinic_name: String,
    consultation_date: Date,
    user_ailment: String,
    doctor_advice: String,
    prescription_image: [{
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
},  {
    timestamps: true
});

prescription = mongoose.model("Prescription", PrescriptionSchema);


module.exports = {
    Prescription: prescription,
}