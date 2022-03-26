var mongoose     = require('mongoose');
var Schema       = mongoose.Schema;


var WaterCheckSchema = new Schema({
    target_amount: Number,
    daily_water_consumed: Number,
    date: Date,
    user_id: {
      type: Schema.Types.ObjectId,
      ref: 'User'
    }
},  {
    timestamps: true
});


var MedicineCheckSchema = new Schema({
    medicine_time: Date,
    check: {
        type: Boolean,
        default: false
    },
    user_id: {
      type: Schema.Types.ObjectId,
      ref: 'User'
    },
    medicine_id: {
        type: Schema.Types.ObjectId,
        ref: 'Medicine'
      }
},  {
    timestamps: true
});



waterCheck = mongoose.model("WaterCheck", WaterCheckSchema);
medicineCheck = mongoose.model("MedicineCheck", MedicineCheckSchema);


module.exports = {
    WaterCheck: waterCheck,
    MedicineCheck: medicineCheck
}