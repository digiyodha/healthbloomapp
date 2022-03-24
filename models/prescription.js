var mongoose     = require('mongoose');
var Schema       = mongoose.Schema;


var PrescriptionSchema = new Schema({
    doctor_name: String,
    clinic_name: String,
    consultation_date: Date,
    user_ailment: String,
    doctor_advice: String,
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

var PrescriptionAssetSchema = new Schema({
    prescription_id:{
        type: Schema.Types.ObjectId,
        ref: 'Prescription'
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


prescription = mongoose.model("Prescription", PrescriptionSchema);
prescriptionAsset = mongoose.model("PrescriptionAsset", PrescriptionAssetSchema);



module.exports = {
    Prescription: prescription,
    PrescriptionAsset: prescriptionAsset
}