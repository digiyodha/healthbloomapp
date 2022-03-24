import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:health_bloom/main.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:health_bloom/view/homepage/home_page.dart';
import 'package:health_bloom/view/walkthrough/walkthrough.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String id;

  getData() {
    id = sp.getString("id");
    if (id == null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Walkthrough();
      }));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomePage();
      }));
    }
  }

  Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).whenComplete(() => getData());

    var initialzationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(
        android: initialzationSettingsAndroid,
        iOS: IOSInitializationSettings());

    flutterNotification.initialize(initializationSettings,
        onSelectNotification: selectNotification);

    FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        RemoteNotification notification = message.notification;

        if (notification != null) {}
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print(message.data.toString());

      if (sp.getBool("generalNotifications")) {
        bool _sound = sp.getBool("generalSilent");
        bool _vibration = sp.getBool("generalVibration");

        RemoteNotification notification = message.notification;
        AndroidNotification android = message.notification?.android;
        print(notification);
        print(android);
        if (notification != null && android != null) {
          String encodedData = "{\"log_id\": ${message.data["log_id"]},"
              "\"body\": \"${message.data["body"]}\","
              "\"title\": \"${message.data["title"]}\","
              "\"dataTitle\": \"${message.data["dataTitle"]}\","
              "\"dataBody\": \"${message.data["dataBody"]}\"}";
          print("SHOW NOTIICATION");

          flutterNotification.show(
              message.notification.hashCode,
              message.data["title"],
              message.data["body"],
              NotificationDetails(
                  android: getDetails(_sound,_vibration), iOS: IOSNotificationDetails()),
              payload: encodedData);
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
  }

  AndroidNotificationDetails getDetails(bool sound,bool vibration){
    if(sound && vibration){
      return androidDetailsWithSoundVibration;
    }else if(sound){
      return androidDetailsWithSound;
    }else if(vibration){
      return androidDetailsWithVibration;
    }else{
      return androidDetailsWithoutSoundVibration;
    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              color: kMainColor,
            ),
            Positioned(
              top: 50,
              bottom: 10,
              left: -200,
              right: -100,
              child: SafeArea(
                child: RotationTransition(
                  turns: new AlwaysStoppedAnimation(15 / 360),
                  child: ClipOval(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      width: (MediaQuery.of(context).size.height * 0.9) * 0.9,
                      color: kWhite.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              bottom: 50,
              left: -80,
              right: -50,
              child: SafeArea(
                child: RotationTransition(
                  turns: new AlwaysStoppedAnimation(20 / 360),
                  child: ClipOval(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      width: (MediaQuery.of(context).size.height * 0.9),
                      color: kWhite.withOpacity(0.9),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Image.asset("assets/icons/logo.png")],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
