var mongoose     = require('mongoose');
var Schema       = mongoose.Schema;

var BillSchenma = new Schema({
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
}, {strict: false});

bill = mongoose.model("Bill", BillSchenma);

module.exports = {
    Bill: bill,
}