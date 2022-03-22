var mongoose     = require('mongoose');
var Schema       = mongoose.Schema;

var ReminderSchema = new Schema({
    reminder_type: {
        type: String,
        enum: [null, 'CheckUp', 'Doctor Appointment', 'Test', 'Task', 'Medical Refilling'],
    },
    date_time: Date,
    description: String,
    family: {
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


reminder = mongoose.model("Reminder", ReminderSchema);


module.exports = {
    Reminder: reminder,
}