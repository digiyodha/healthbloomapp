var mongoose     = require('mongoose');
var Schema       = mongoose.Schema;

var ReportSchema = new Schema({
    name: String,
    date: Date,
    description: String,
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


var ReportAssetSchema = new Schema({
    report_id:{
        type: Schema.Types.ObjectId,
        ref: 'Report'
    },
    asset_url:String,
    asset_type: {
        type: String,
        enum : ['Image', 'Video', 'Document'],
        default: 'Image'
    },
    asset_name: String,
    asset_size: Number,
    thumbnail_url: String,
},  {
    timestamps: true
});

report = mongoose.model("Report", ReportSchema);
reportAsset = mongoose.model("ReportAsset", ReportAssetSchema);


module.exports = {
    Report: report,
    ReportAsset: reportAsset
}