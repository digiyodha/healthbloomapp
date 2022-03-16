const asyncHandler = require("../middlewares/asyncHandler");
const ErrorResponse = require("../utils/ErrorResponse");
const {User} = require("../models/user");
const {Family} = require("../models/family");
const {Bill} = require("../models/bill");
const { Medicine, TimeMedicine } = require("../models/medicine");
const { Insurance } = require("../models/insurance");
const { Prescription } = require("../models/prescription");
const { Report } = require("../models/report");
var fns = require('date-fns');
const { Console } = require("@sentry/node/dist/integrations");



//add Medicine
exports.addMedicine = asyncHandler(async (req, res, next) => {
    var {medicine_name, amount, dosage, doses, duration, time, start_date,
        reminder_time, alarm_timer, patient, description} = req.body;
    const medicine = await Medicine.create({
        medicine_name: medicine_name,
        amount: amount,
        dosage: dosage,
        doses: doses,
        duration: duration,
        start_date: start_date,
        reminder_time: reminder_time,
        alarm_timer: alarm_timer,
        patient: patient, 
        user_id: req.user._id,
        description: description
    });

    var timePromise = await time.map(async function(timestamp){

        var timeMedicine = await TimeMedicine.create({
            start_time: timestamp,
            original_time: timestamp,
            end_time: fns.addDays(new Date(timestamp), parseInt(duration)),
            medicine_id: medicine._id,
            is_active: true,
            user_id: req.user._id

        });
        console.log(timeMedicine);
    });
    await Promise.all(timePromise);
    if(!medicine)
    {
        return next(
        new ErrorResponse(`Medicine creation unsuccessful`, 404)
        );
    }
    res.status(200).json({ success: true, data: medicine });
});

//edit Medicine
exports.editMedicine = asyncHandler(async (req, res, next) => {
    var {medicine_name, amount, dosage, doses, duration, time, start_date,
        reminder_time, alarm_timer, patient, _id, description} = req.body;


    const medicine = await Medicine.findOneAndUpdate({_id: _id},{
        medicine_name: medicine_name,
        amount: amount,
        dosage: dosage,
        doses: doses,
        duration: duration,
        start_date: start_date,
        reminder_time: reminder_time,
        alarm_timer: alarm_timer,
        patient: patient, 
        user_id: req.user._id,
        description: description
    });

    await TimeMedicine.deleteMany({medicine_id: _id});

    var timePromise = await time.map(async function(timestamp){

        var timeMedicine = await TimeMedicine.create({
            original_time: timestamp,
            start_time: timestamp,
            end_time: fns.addDays(new Date(timestamp), parseInt(duration)),
            medicine_id: _id,
            is_active: true,
            user_id: req.user._id
        });
        console.log(timeMedicine);
    });
    await Promise.all(timePromise);

    if(!medicine)
    {
        return next(
        new ErrorResponse(`Medicine updation unsuccessful`, 404)
        );
    }
    res.status(200).json({ success: true, data: medicine });
});

//search Medicine
exports.searchMedicine = asyncHandler(async (req, res, next) => {
    var {name} = req.body;
    // const bill = await Bill.find({$text: {$search: name}});
    const medicineObject = await Medicine.find({$or: [
        {
            medicine_name: {
                $regex: name,
                $options: 'i'
            }
        }
    ],  
        user_id: req.user.id});

    var medicine_object = [];
    var medicinePromise = await medicineObject.map(async function(medicine){
        var patientObject = await Family.findOne({_id: medicine.patient});
        var userObject = await User.findOne({_id: medicine.user_id});
        var timeObject = await TimeMedicine.find({medicine_id: medicine._id});
        var amount = parseInt(medicine.amount);
        var duration = parseInt(medicine.duration);
        var endTime = fns.addDays(new Date(medicine.start_date), duration);


        var number_of_tablets = 0;
        var timePromise = await timeObject.map(async function(tm){

            const days = fns.eachDayOfInterval({
                start: new Date(tm.original_time),
                end: new Date(tm.start_time)
            })

            var number_of_days = days.length;

            number_of_tablets += number_of_days;
        });
        await Promise.all(timePromise);

        var total_tablets = timeObject.length * medicine.duration;


        console.log(number_of_tablets);
        console.log(total_tablets);

        var durationAfterDate = duration;
        if(fns.isBefore(Date.now(), endTime))
        {
            durationAfterDate = fns.differenceInDays(
                new Date(endTime),
                Date.now()
            );
        }


        var nextMedicineDose = await TimeMedicine.find({
            user_id: req.user._id,
            is_active: true,
            medicine_id: medicine._id
        }
        ).sort({'start_time': 1}).limit(1);

        medicine_object.push({
            _id: medicine._id,
            medicine_name: medicine.medicine_name,
            amount: medicine.amount,
            dosage: medicine.dosage,
            doses: medicine.doses,
            duration: medicine.duration,
            timeObject: timeObject,
            start_date: medicine.start_date,
            reminder_time: medicine.reminder_time,
            alarm_timer: medicine.alarm_timer,
            patient: patientObject,
            user_id: medicine.user_id,
            description: medicine.description,
            start_hour: nextMedicineDose.length != 0 ? nextMedicineDose[0].start_time : null,
            total_tablets: amount * total_tablets,
            tablets_left:  amount * (total_tablets - number_of_tablets),
            duration_left: durationAfterDate

        });
    });
    await Promise.all(medicinePromise);
    res.status(200).json({ success: true, data: medicine_object });
});

function dynamicSort(property) {
    var sortOrder = 1;
    if(property[0] === "-") {
        sortOrder = -1;
        property = property.substr(1);
    }
    return function (a,b) {
        /* next line works with strings and numbers, 
         * and you may want to customize it to your needs
         */
        var result = (a[property] < b[property]) ? -1 : (a[property] > b[property]) ? 1 : 0;
        return result * sortOrder;
    }
}

//next 10 Med0icines
exports.getNextMedicinesByTime = asyncHandler(async (req, res, next) => {

    var date_time = Date.now();

    await TimeMedicine.updateMany({
        end_time: {$lt: date_time},
        user_id: req.user._id,
        is_active: 1
    }, {$set: {is_active: 0}});

    await TimeMedicine.updateMany({
        start_time: {$lt: date_time},
        user_id: req.user._id,
        is_active: 1
    }, [{$set: {start_time: {$add: ['$start_time', 24*60*60000]}}}]);


    console.log(req.user._id);
    var timeMedicine = await TimeMedicine.find({
            user_id: req.user._id,
            is_active: true
        }
    ).sort({'start_time': 1}).limit(10);

    var medicine_object = [];
    var medicinePromise = await timeMedicine.map(async function(tm){
        console.log(tm);
        var medicine = await Medicine.findOne({_id: tm.medicine_id});
        var patientObject = await Family.findOne({_id: medicine.patient});
        var timeObject = await TimeMedicine.find({medicine_id: medicine._id});
        var amount = parseInt(medicine.amount);
        var duration = parseInt(medicine.duration);
        var endTime = fns.addDays(new Date(medicine.start_date), duration);


        var number_of_tablets = 0;
        var timePromise = await timeObject.map(async function(tm){

            const days = fns.eachDayOfInterval({
                start: new Date(tm.original_time),
                end: new Date(tm.start_time)
            })

            var number_of_days = days.length;

            number_of_tablets += number_of_days;
        });
        await Promise.all(timePromise);

        var total_tablets = timeObject.length * medicine.duration;


        console.log(number_of_tablets);
        console.log(total_tablets);

        var durationAfterDate = duration;
        if(fns.isBefore(Date.now(), endTime))
        {
            durationAfterDate = fns.differenceInDays(
                new Date(endTime),
                Date.now()
            );
        }

        medicine_object.push({
            _id: medicine._id,
            medicine_name: medicine.medicine_name,
            amount: medicine.amount,
            dosage: medicine.dosage,
            doses: medicine.doses,
            duration: medicine.duration,
            timeObject: timeObject,
            start_date: medicine.start_date,
            reminder_time: medicine.reminder_time,
            alarm_timer: medicine.alarm_timer,
            patient: patientObject,
            user_id: medicine.user_id,
            start_hour: tm.start_time,
            description: medicine.description,
            total_tablets: amount * total_tablets,
            tablets_left:  amount * (total_tablets - number_of_tablets),
            duration_left: durationAfterDate
        });
    });
    await Promise.all(medicinePromise);

    medicine_object.sort(dynamicSort("start_hour"));

    res.status(200).json({ success: true, data: medicine_object});
});


//delete medicine
exports.deleteMedicine = asyncHandler(async (req, res, next) => {
    var {_id} = req.body;
    const medicine = await Medicine.findOneAndDelete({_id: _id});
    await TimeMedicine.deleteMany({medicine_id: _id});
    if(!medicine)
    {
        return next(
        new ErrorResponse(`Medicine id invalid`, 404)
        );
    }
    res.status(200).json({ success: true, data: medicine });
});

//get medicine
exports.getMedicine = asyncHandler(async (req, res, next) => {


    // var timeeObject = await TimeMedicine.find({});

    // var medicinePromise = await timeeObject.map(async function(tm){
    //     var medicine = await Medicine.findOne({_id: tm.medicine_id});

    //     if(medicine)
    //     {
    //     let reminder_date = medicine.start_date;
    //     let reminder_time = tm.start_time;

    //     console.log(reminder_date);
    //     console.log(reminder_time);
    //     let reminder_date_time = reminder_date.toString().substr(0, 11) + reminder_time.toString().substr(11);
        
    //     console.log(new Date(reminder_date_time));
    //     console.log("-------");
    //             await TimeMedicine.update({_id: tm._id}, {original_time: reminder_date_time});

    //     }

    // });

    // await Promise.all(medicinePromise);

    var {_id} = req.body;
    const medicine = await Medicine.findOne({_id: _id});
    if(!medicine)
    {
        return next(
        new ErrorResponse(`Medicine id invalid`, 404)
        );
    }
    var patientObject = await Family.findOne({_id: medicine.patient});
    var userObject = await User.findOne({_id: medicine.user_id});
    var timeObject = await TimeMedicine.find({medicine_id: medicine._id});
    var amount = parseInt(medicine.amount);
    var duration = parseInt(medicine.duration);
    var endTime = fns.addDays(new Date(medicine.start_date), duration);


    var number_of_tablets = 0;
    var timePromise = await timeObject.map(async function(tm){

        const days = fns.eachDayOfInterval({
            start: new Date(tm.original_time),
            end: new Date(tm.start_time)
          })

        var number_of_days = days.length;

        number_of_tablets += number_of_days;
    });
    await Promise.all(timePromise);

    var total_tablets = timeObject.length * medicine.duration;


    console.log(number_of_tablets);
    console.log(total_tablets);

    var durationAfterDate = duration;
    if(fns.isBefore(Date.now(), endTime))
    {
         durationAfterDate = fns.differenceInDays(
            new Date(endTime),
            Date.now()
        );
    }

    var nextMedicineDose = await TimeMedicine.find({
        user_id: req.user._id,
        is_active: true,
        medicine_id: medicine._id
    }
    ).sort({'start_time': 1});

    console.log(nextMedicineDose.length)

    var medicine_object = {
        _id: medicine._id,
        medicine_name: medicine.medicine_name,
        amount: medicine.amount,
        dosage: medicine.dosage,
        doses: medicine.doses,
        duration: medicine.duration,
        timeObject: timeObject,
        start_date: medicine.start_date,
        reminder_time: medicine.reminder_time,
        alarm_timer: medicine.alarm_timer,
        patient: patientObject,
        // user: userObject
        user_id: medicine.user_id,
        description: medicine.description,
        start_hour: nextMedicineDose.length != 0 ? nextMedicineDose[0].start_time : null,
        total_tablets: amount * total_tablets,
        tablets_left:  amount * (total_tablets - number_of_tablets),
        duration_left: durationAfterDate


    };
    res.status(200).json({ success: true, data: medicine_object });
});


//get medicine by family
exports.getMedicineFamily = asyncHandler(async (req, res, next) => {
    var {patient} = req.body;
    const medicineObject = await Medicine.find({patient: patient});
    var medicine_object = [];
    var medicinePromise = await medicineObject.map(async function(medicine){
        var patientObject = await Family.findOne({_id: medicine.patient});
        var userObject = await User.findOne({_id: medicine.user_id});
        var timeObject = await TimeMedicine.find({medicine_id: medicine._id});
        var amount = parseInt(medicine.amount);
        var duration = parseInt(medicine.duration);
        var endTime = fns.addDays(new Date(medicine.start_date), duration);


        var number_of_tablets = 0;
        var timePromise = await timeObject.map(async function(tm){

            const days = fns.eachDayOfInterval({
                start: new Date(tm.original_time),
                end: new Date(tm.start_time)
            })

            var number_of_days = days.length;

            number_of_tablets += number_of_days;
        });
        await Promise.all(timePromise);

        var total_tablets = timeObject.length * medicine.duration;


        console.log(number_of_tablets);
        console.log(total_tablets);

        var durationAfterDate = duration;
        if(fns.isBefore(Date.now(), endTime))
        {
            durationAfterDate = fns.differenceInDays(
                new Date(endTime),
                Date.now()
            );
        }

        var nextMedicineDose = await TimeMedicine.find({
            user_id: req.user._id,
            is_active: true,
            medicine_id: medicine._id
        }
        ).sort({'start_time': 1});


        medicine_object.push({
            _id: medicine._id,
            medicine_name: medicine.medicine_name,
            amount: medicine.amount,
            dosage: medicine.dosage,
            doses: medicine.doses,
            duration: medicine.duration,
            timeObject: timeObject,
            start_date: medicine.start_date,
            reminder_time: medicine.reminder_time,
            alarm_timer: medicine.alarm_timer,
            patient: patientObject,
            description: medicine.description,
            // user: userObject
            user_id: medicine.user_id,
            start_hour: nextMedicineDose.length != 0 ? nextMedicineDose[0].start_time : null,
            total_tablets: amount * total_tablets,
            tablets_left:  amount * (total_tablets - number_of_tablets),
            duration_left: durationAfterDate

        });
    });
    await Promise.all(medicinePromise);
    res.status(200).json({ success: true, data: medicine_object });
});
