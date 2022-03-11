var mongoose     = require('mongoose');
var Schema       = mongoose.Schema;

var FeedbackOptionsSchema = new Schema({
    feedback_name: String 
},{
    timestamps: true
});

var FeedbackFormSchema = new Schema({
    experience: {
        type: String,
        enum : ['Extremely Sad', 'Sad', 'Satisfied', 'Happy', 'Extremely Happy'],
        default: 'Satisfied'
    },
    description: String,
    user_id: {
      type: Schema.Types.ObjectId,
      ref: 'User'
    }
},  {
    timestamps: true
});

var UserFeedbackSchema = new Schema({
    feedback_id: {
        type: Schema.Types.ObjectId,
        ref: 'FeedbackForm'
    },
    user_id: {
        type: Schema.Types.ObjectId,
        ref: 'User'
    },
    option_id: {
        type: Schema.Types.ObjectId,
        ref: 'FeedbackOptions'
    }
},  {
    timestamps: true
});

feedbackOptions = mongoose.model("FeedbackOptions", FeedbackOptionsSchema);
feedbackForm = mongoose.model("FeedbackForm", FeedbackFormSchema);
userFeedback = mongoose.model("UserFeedback", UserFeedbackSchema);



module.exports = {
    FeedbackForm: feedbackForm,
    FeedbackOptions: feedbackOptions,
    UserFeedback: userFeedback
}