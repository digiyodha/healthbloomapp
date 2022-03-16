var mongoose     = require('mongoose');
var Schema       = mongoose.Schema;


var MedicineSchema = new Schema({
    medicine_name: String,
    amount: Number,
    dosage: String,
    doses: String,
    duration: String,
    start_date: Date,
    description: String,
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

var TimeSchema = new Schema({
    start_time: Date,
    end_time: Date,
    original_time: Date,
    medicine_id: {
        type: Schema.Types.ObjectId,
        ref: 'Medicine'
    },
    is_active: {
        type: Boolean,
        defaultValue: true
    },
    user_id: {
        type: Schema.Types.ObjectId,
        ref: 'User'
      }
},{
    timestamps: true
});

medicine = mongoose.model("Medicine", MedicineSchema);
timeMedicine = mongoose.model("TimeMedicine", TimeSchema);



module.exports = {
    Medicine: medicine,
    TimeMedicine: timeMedicine
}