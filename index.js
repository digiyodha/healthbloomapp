var express = require('express')
var app  = express()
var bodyParser = require('body-parser')
var mongoose = require('mongoose');
const dbConfig = require('./config/database.js');
const errorHandler = require("./middlewares/ErrorHandler");
const cors = require('cors');
const toJson = require('@meanie/mongoose-to-json');
const Sentry = require("@sentry/node");
const Tracing = require("@sentry/tracing");
const http = require("http");




mongoose.Promise = global.Promise;
mongoose.plugin(toJson);

// Connecting to the database
mongoose.connect(dbConfig.url, {
    useNewUrlParser: true
}).then(() => {
    console.log("Successfully connected to the database");
}).catch(err => {
    console.log('Could not connect to the database. Exiting now...', err);
    process.exit();
});


app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());
app.use(cors());


Sentry.init({
  dsn: "https://f4cbf80c69444372b28776eacdec5434@o736915.ingest.sentry.io/5785058",
  integrations: [
    // enable HTTP calls tracing
    new Sentry.Integrations.Http({ tracing: true }),
  ],

  // We recommend adjusting this value in production, or using tracesSampler
  // for finer control
  tracesSampleRate: 1.0,
});

app.get('/', (req, res) => res.send('OK'));
app.use("/v1/users", require("./routers/userRouter"));
app.use("/v1/family", require("./routers/familyRouter"));
app.use("/v1/bill", require("./routers/billRouter"));
app.use("/v1/report", require("./routers/reportRouter"));
app.use("/v1/prescription", require("./routers/prescriptionRouter"));
app.use("/v1/document", require("./routers/documentRouter"));
app.use("/v1/insurance", require("./routers/insuranceRouter"));
app.use("/v1/medicine", require("./routers/medicineRouter"));
app.use("/v1/feedback", require("./routers/feedbackRouter"));
app.use("/v1/admin", require("./routers/adminRouter"));
app.use("/v1/map", require("./routers/mapRouter"));
app.use("/v1/reminder", require("./routers/reminderRouter"));
app.use("/v1/check", require("./routers/checkRouter"));









// app.use("/api/v1/attempts", require("./routers/attemptRouter"));

app.use(errorHandler);


var port = process.env.PORT || 3000

// Catch all route
app.use("*", (req, res) => {
  res.status(404).json({
    error: "Not a valid route",
  });
});





// var router = express.Router();


// router.get('/', function(req, res) {
//     res.json({ "message": 'hooray! welcome to our api!' });
// });


// app.use('/api', router);


app.listen(port)
console.log('Server Started')
