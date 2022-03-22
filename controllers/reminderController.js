const asyncHandler = require("../middlewares/asyncHandler");
const ErrorResponse = require("../utils/ErrorResponse");
const {User} = require("../models/user");
const {Family} = require("../models/family");
const {Reminder} = require("../models/reminder");



//add Reminder
exports.addReminder = asyncHandler(async (req, res, next) => {
    var {reminder_type, family, date_time, description} = req.body;
    const reminder = await Reminder.create({
        reminder_type: reminder_type,
        family: family,
        date_time: date_time, 
        description: description,  
        user_id: req.user._id
    });
    if(!reminder)
    {
        return next(
        new ErrorResponse(`Reminder creation unsuccessful`, 404)
        );
    }
    res.status(200).json({ success: true, data: reminder });
});

//edit Reminder
exports.editReminder = asyncHandler(async (req, res, next) => {
    var {reminder_type, family, date_time, description, _id} = req.body;
    const reminder = await Reminder.findOneAndUpdate({_id: _id},{
        reminder_type: reminder_type,
        family: family,
        date_time: date_time, 
        description: description,  
    }, {new: true});
    console.log(reminder);
    if(!reminder)
    {
        return next(
        new ErrorResponse(`Reminder updation unsuccessful`, 404)
        );
    }
    res.status(200).json({ success: true, data: reminder });
});

//get all Reminder
exports.getAllReminder = asyncHandler(async (req, res, next) => {
    
    var reminderObject = await Reminder.find({user_id: req.user._id}).sort([['date_time', 1]]);;

    var reminder_object = [];

    var reminderPromise = await reminderObject.map(async function(reminder){
        var familyObject = await Family.findOne({_id: reminder.family});

        reminder_object.push({
            _id: reminder._id,
            reminder_type: reminder.reminder_type,
            date_time: reminder.date_time,
            description: reminder.description,
            familyObject: familyObject,
            user_id: reminder.user_id
        });
    });
    await Promise.all(reminderPromise);
    res.status(200).json({ success: true, data: reminder_object });
});


//delete reminder
exports.deleteReminder = asyncHandler(async (req, res, next) => {
    var {_id} = req.body;
    const reminder = await Reminder.findOneAndDelete({_id: _id});
    if(!reminder)
    {
        return next(
        new ErrorResponse(`Reminder id invalid`, 404)
        );
    }
    res.status(200).json({ success: true, data: reminder });
});

//get reminder
exports.getReminder = asyncHandler(async (req, res, next) => {
    var {_id} = req.body;
    const reminder = await Reminder.findOne({_id: _id});
    if(!reminder)
    {
        return next(
        new ErrorResponse(`Reminder id invalid`, 404)
        );
    }
    var familyObject = await Family.findOne({_id: reminder.family});

    var reminder_object = {
        _id: reminder._id,
        reminder_type: reminder.reminder_type,
        familyObject: familyObject,
        description: reminder.description,
        date_time: reminder.date_time,
        user_id: reminder.user_id
    };
    
    res.status(200).json({ success: true, data: reminder_object });
});


//get reminder by family
exports.getReminderFamily = asyncHandler(async (req, res, next) => {
    var {family} = req.body;
    var reminder_object = [];
    const reminderObject = await Reminder.find({family: family}).sort([['date_time', 1]]);

    var reminderPromise = await reminderObject.map(async function(reminder){
        var familyObject = await Family.findOne({_id: reminder.family});

        reminder_object.push({
            _id: reminder._id,
            reminder_type: reminder.reminder_type,
            familyObject: familyObject,
            description: reminder.description,
            date_time: reminder.date_time,
            user_id: reminder.user_id
        });
    });
    await Promise.all(reminderPromise);
    res.status(200).json({ success: true, data: reminder_object });
});
