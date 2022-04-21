import 'dart:typed_data';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:health_bloom/services/api/networking.dart';
import 'package:health_bloom/services/api/networkmanager/auth_networkmanager.dart';
import 'package:health_bloom/services/api/repository/auth_repository.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:health_bloom/view/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  notificationInit();
  await Firebase.initializeApp();
  sp = await SharedPreferences.getInstance();
  String baseUrl =
      "http://ec2-34-221-91-192.us-west-2.compute.amazonaws.com:3000/";

  Provider.debugCheckInvalidValueType = null;
  NetworkManager networkManager = await getAuthNetworkManager(baseUrl);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  vibrationPattern[0] = 0;
  vibrationPattern[1] = 1000;
  vibrationPattern[2] = 5000;
  vibrationPattern[3] = 2000;

  // runApp(DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => MyApp(
  //     networkManager: networkManager,
  //   ),
  // ));

  runApp(MyApp(
    networkManager: networkManager,
  ));
}

class MyApp extends StatelessWidget {
  final NetworkManager networkManager;
  MyApp({Key key, this.networkManager}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<NetworkRepository>(
          create: (_) => NetworkRepository(apiClient: networkManager),
        ),
      ],
      child: MaterialApp(
        // useInheritedMediaQuery: true,
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        title: 'Health Bloom',
        theme: ThemeData(
          primarySwatch: kPrimaryColorMaterial,
        ),
        home: SplashScreen(),
      ),
    );
  }
}

final Int64List vibrationPattern = Int64List(4);

SharedPreferences sp;
const debug = true;

FlutterLocalNotificationsPlugin flutterNotification =
    FlutterLocalNotificationsPlugin();

var androidDetailsWithSoundVibration = new AndroidNotificationDetails(
  "sound and vibration channel",
  "sound and vibration channel",
  importance: Importance.max,
  priority: Priority.high,
  channelDescription: "This is my channel",
  playSound: true,
  enableVibration: true,
  vibrationPattern: vibrationPattern,
);

var androidDetailsWithoutSoundVibration = new AndroidNotificationDetails(
  "no sound and vibration channel",
  "no sound and vibration channel",
  importance: Importance.max,
  priority: Priority.high,
  channelDescription: "This is my channel",
  playSound: false,
  enableVibration: false,
);

var androidDetailsWithSound = new AndroidNotificationDetails(
  "sound channel",
  "sound channel",
  importance: Importance.max,
  priority: Priority.high,
  channelDescription: "This is my channel",
  playSound: true,
  enableVibration: false,
);

var androidDetailsWithVibration = new AndroidNotificationDetails(
  "vibration channel",
  "vibration channel",
  importance: Importance.max,
  priority: Priority.high,
  channelDescription: "This is my channel",
  playSound: false,
  enableVibration: true,
  vibrationPattern: vibrationPattern,
);

notificationInit() {
  var androidInitilize = new AndroidInitializationSettings('app_icon');
  var iOSinitilize = new IOSInitializationSettings();
  var initilizationsSettings =
      new InitializationSettings(android: androidInitilize, iOS: iOSinitilize);

  flutterNotification.initialize(initilizationsSettings,
      onSelectNotification: (String payload) {});
}

Future showNotification() async {
  var iSODetails = new IOSNotificationDetails();
  var generalNotificationDetails = new NotificationDetails(
      android: androidDetailsWithSoundVibration, iOS: iSODetails);

  //time zone
  tz.initializeTimeZones();
  String dtz = await FlutterNativeTimezone.getLocalTimezone();
  if (dtz == "Asia/Calcutta") {
    dtz = "Asia/Kolkata";
  }
  final localTimeZone = tz.getLocation(dtz);
  tz.setLocalLocation(localTimeZone);

  TimeOfDay _wakeTime = TimeOfDay(
      hour: int.parse(sp.getString("wakeTime").split(":")[0]),
      minute: int.parse(sp.getString("wakeTime").split(":")[1]));
  TimeOfDay _sleepTime = TimeOfDay(
      hour: int.parse(sp.getString("sleepTime").split(":")[0]),
      minute: int.parse(sp.getString("sleepTime").split(":")[1]));
  int _interval = sp.getInt("hrs");
  int _currentHr = _wakeTime.hour;
  int _notificationId = 0;

  while (_currentHr <= _sleepTime.hour) {
    tz.TZDateTime _t = tz.TZDateTime(tz.local, DateTime.now().year,
        DateTime.now().month, DateTime.now().day, _currentHr, 1);
    print("${_t.day}/${_t.month}/${_t.year}/${_t.hour}/${_t.minute}/");
    await flutterNotification.zonedSchedule(
      _notificationId,
      "Health Bloom",
      "Its time for you to drink water.",
      _t,
      generalNotificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    _notificationId++;
    _currentHr = _currentHr + _interval;
  }
}
