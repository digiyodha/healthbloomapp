var mongoose     = require('mongoose');
var Schema       = mongoose.Schema;

var BillSchema = new Schema({
    name: String,
    amount: Number,
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

var BillAssetSchema = new Schema({
    bill_id:{
        type: Schema.Types.ObjectId,
        ref: 'Bill'
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


bill = mongoose.model("Bill", BillSchema);
billAsset = mongoose.model("BillAsset", BillAssetSchema);

module.exports = {
    Bill: bill,
    BillAsset: billAsset
}