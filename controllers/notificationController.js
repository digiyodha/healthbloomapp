
var admin = require("firebase-admin");

var serviceAccount = require("../googlecred.json");
const { User } = require("../models/user");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});


exports.sendNotificationToUser = async function(title, body, user_id){

    console.log(user_id);

    var token;
    var user = await User.findOne({_id: user_id});
    if(user.fcm_token!=null){
      token = user.fcm_token;
    }
    

    if(token){

      var message = {
        notification:{
          title: title,
          body: body
        },
        data:{
          title: title,
          body: body,
          click_action: "FLUTTER_NOTIFICATION_CLICK"
        },
        token: token
      };


      admin.messaging().send(message).then((response)=>{
        console.log("Successfully sent message" + response);
      }).catch((error)=>{
        console.log(error);
      });
    }


  }

