var mongoose     = require('mongoose');
var Schema       = mongoose.Schema;

var BillSchema = new Schema({
    name: String,
    amount: Number,
    date: Date,
    description: String,
    bill_image: [{
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
}, {strict: false}, {
    timestamps: true
});

BillSchema.index({'$**': 'text'});

bill = mongoose.model("Bill", BillSchema);


module.exports = {
    Bill: bill,
}