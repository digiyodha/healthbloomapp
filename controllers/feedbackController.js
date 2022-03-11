const asyncHandler = require("../middlewares/asyncHandler");
const ErrorResponse = require("../utils/ErrorResponse");
const {User} = require("../models/user");
const {Family} = require("../models/family");
const {Bill} = require("../models/bill");
const { FeedbackOptions, FeedbackForm, UserFeedback } = require("../models/feedback");



//add Feedback Options
exports.addFeedbackOptions = asyncHandler(async (req, res, next) => {
    var {feedback_name} = req.body;
    const feedback = await FeedbackOptions.create({
        feedback_name: feedback_name
    });
    if(!feedback)
    {
        return next(
        new ErrorResponse(`Feedback options creation unsuccessful`, 404)
        );
    }
    res.status(200).json({ success: true, data: feedback });
});

//delete Feedback Options
exports.deleteFeedbackOptions = asyncHandler(async (req, res, next) => {
    var {_id} = req.body;
    const feedback = await FeedbackOptions.findOneAndDelete({
        _id: _id
    });
    res.status(200).json({ success: true, data: feedback });
});

//get Feedback Options
exports.getFeedbackOptions = asyncHandler(async (req, res, next) => {
    const feedback = await FeedbackOptions.find({});
    if(!feedback)
    {
        return next(
        new ErrorResponse(`Feedback options creation unsuccessful`, 404)
        );
    }
    res.status(200).json({ success: true, data: feedback });
});

//add Feedback
exports.addFeedback = asyncHandler(async (req, res, next) => {
    var {experience, description, feedback_options} = req.body;
    const feedbackForm = await FeedbackForm.create({
        experience: experience,
        description: description,
        user_id: req.user._id
    });
    if(!feedbackForm)
    {
        return next(
        new ErrorResponse(`Feedback creation unsuccessful`, 404)
        );
    }

    var feedbackOptionsPromise = await feedback_options.map(async function(options_id){
        await UserFeedback.create({
            feedback_id: feedbackForm._id,
            option_id: options_id,
            user_id: req.user._id
        });

    });
    await Promise.all(feedbackOptionsPromise);
    res.status(200).json({ success: true, data: feedbackForm });
});

//get feedback
exports.getFeedback = asyncHandler(async (req, res, next) => {
    
    var feedbackForm = await FeedbackForm.find({user_id: req.user._id});

    var feedback_object = [];
    var feedbackPromise = await feedbackForm.map(async function(feedback){
        var userFeedback = await UserFeedback.find({feedback_id: feedback._id});
        
        var feedbackOptions = [];
        var userFeedbackPromise = await userFeedback.map(async function(userFeedback){
            var feedback_options = await FeedbackOptions.findOne({_id: userFeedback.option_id});

            
            feedbackOptions.push({
                option_id: feedback_options._id,
                feedback_name: feedback_options.feedback_name
            });
            
        });
        await Promise.all(userFeedbackPromise);

        feedback_object.push({
            experience: feedback.experience,
            description: feedback.description,
            user_id: feedback.user_id,
            feedbackOptions: feedbackOptions
        });
    });
    await Promise.all(feedbackPromise);

    res.status(200).json({ success: true, data: feedback_object });
});
