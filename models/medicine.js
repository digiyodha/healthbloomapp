var mongoose     = require('mongoose');
var Schema       = mongoose.Schema;


var MedicineSchema = new Schema({
    medicine_name: String,
    amount: Number,
    dosage: String,
    doses: String,
    duration: String,
    time: [{
        type: Date
    }],
    start_date: Date,
    reminder_time: {
        type: String,
        enum : ['Daily', 'Weekly', 'Monthly'],
        default: 'Daily'
    },
    alarm_timer: {
        type: Boolean,
        default: false
    },
    patient: {
        type: Schema.Types.ObjectId,
        ref: 'Family'
    },
    user_id: {
      type: Schema.Types.ObjectId,
      ref: 'User'
    }
}, {
    timestamps: true
});

medicine = mongoose.model("Medicine", MedicineSchema);


module.exports = {
    Medicine: medicine,
}