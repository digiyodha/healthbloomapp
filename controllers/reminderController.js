const asyncHandler = require("../middlewares/asyncHandler");
const ErrorResponse = require("../utils/ErrorResponse");
const {User} = require("../models/user");
const {Family} = require("../models/family");
const {Reminder} = require("../models/reminder");
var cron = require('node-cron');
const schedule = require('node-schedule');
const { sendNotificationToUser } = require("./notificationController");
const { Medicine, TimeMedicine } = require("../models/medicine");
var fns = require('date-fns');
const { dynamicSort } = require("./medicineController");


// //schedule Reminder
// exports.scheduleReminder = asyncHandler(async (req, res, next) => {
    
//     // cron.schedule('* * * * *', () => {
//     //     console.log('running a task every minute');
//     // });

    
//     const date = new Date("2022-03-22T10:41:26.332Z");

//     console.log(new Date());

//     const job = schedule.scheduleJob(date, function(){
//     console.log('The world is going to end today.');
//     });
    
//     res.status(200).json({ success: true, data: null });
// });



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


    var date = new Date(date_time);
    console.log(date);
    const job = schedule.scheduleJob(reminder._id.toString(), date, async function(){
        console.log('Reminder done!');
        await sendNotificationToUser(reminder_type, description, req.user._id);
    });


    res.status(200).json({ success: true, data: reminder });
});

//edit Reminder
exports.editReminder = asyncHandler(async (req, res, next) => {
    var {reminder_type, family, date_time, description, _id} = req.body;

    const cancelJob = schedule.scheduledJobs[_id.toString()];
    if (cancelJob == null) {
      console.log("Job not found!");
    }
    cancelJob.cancel();

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

    var date = new Date(date_time);
    console.log(date);
    const job = schedule.scheduleJob(_id.toString(), date, async function(){
        console.log('Reminder done!');
        await sendNotificationToUser(reminder_type, description, req.user._id);
    });

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
            user_id: reminder.user_id,
            type: 'Reminder'
        });
    });
    await Promise.all(reminderPromise);


    var medicineObject = await Medicine.find({user_id: req.user._id});
    var medicinePromise = await medicineObject.map(async function(medicine){
        var timeObject = await TimeMedicine.find({medicine_id: medicine._id});
        var familyObject = await Family.findOne({_id: medicine.patient});

        var timeMedicinePromise = await timeObject.map(async function(timeMedicine){

            if(medicine.reminder_time == 'Daily')
            {
                var start = timeMedicine.original_time;
                for(var i=0; i<parseInt(medicine.duration); i++)
                {
                    var date = new Date(start);
                    console.log(date);
                    reminder_object.push({
                        _id: timeMedicine._id,
                        reminder_type: 'Medicine',
                        date_time: start,
                        description: medicine.medicine_name,
                        familyObject: familyObject,
                        user_id: medicine.user_id,
                        type: 'Medicine'
                    });
                    start = fns.addDays(date, 1);
                }
            }
            else if(medicine.reminder_time == 'Weekly')
            {
                var start = timeMedicine.original_time;
                for(var i=0; i<parseInt(medicine.duration); i+=7)
                {
                    var date = new Date(start);
                    console.log(date);
                    reminder_object.push({
                        _id: timeMedicine._id,
                        reminder_type: 'Medicine',
                        date_time: start,
                        description: medicine.medicine_name,
                        familyObject: familyObject,
                        user_id: medicine.user_id,
                        type: 'Medicine'
                    });
                    start = fns.addDays(date, 7);
                }
            }
            else if(medicine.reminder_time == 'Monthly')
            {
                var start =  timeMedicine.original_time;
                for(var i=0; i<parseInt(medicine.duration); i+=30)
                {
                    var date = new Date(start);
                    console.log(date);
                    reminder_object.push({
                        _id: timeMedicine._id,
                        reminder_type: 'Medicine',
                        date_time: start,
                        description: medicine.medicine_name,
                        familyObject: familyObject,
                        user_id: medicine.user_id,
                        type: 'Medicine'
                    });
                    start = fns.addDays(date, 30);
                }
            }
        });
        await Promise.all(timeMedicinePromise);
    });
    await Promise.all(medicinePromise);

    reminder_object.sort(dynamicSort("date_time"));

    res.status(200).json({ success: true, data: reminder_object });
});


//delete reminder
exports.deleteReminder = asyncHandler(async (req, res, next) => {
    var {_id} = req.body;

    const cancelJob = schedule.scheduledJobs[_id.toString()];
    if (cancelJob == null) {
      console.log("Job not found!");
    }
    cancelJob.cancel();
    
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
