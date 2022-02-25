var mongoose     = require('mongoose');
var Schema       = mongoose.Schema;

var ReportSchema = new Schema({
    name: String,
    date: Date,
    description: String,
    report_image: [{
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
}, {strict: false});

report = mongoose.model("Report", ReportSchema);

module.exports = {
    Report: report,
}