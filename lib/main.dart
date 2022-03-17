import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:health_bloom/services/api/networking.dart';

import 'package:health_bloom/services/api/networkmanager/auth_networkmanager.dart';
import 'package:health_bloom/services/api/repository/auth_repository.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:health_bloom/view/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

SharedPreferences sp;
const debug = true;

FlutterLocalNotificationsPlugin flutterNotification =
    FlutterLocalNotificationsPlugin();

notificationInit() {
  var androidInitilize = new AndroidInitializationSettings('app_icon');
  var iOSinitilize = new IOSInitializationSettings();
  var initilizationsSettings =
      new InitializationSettings(android: androidInitilize, iOS: iOSinitilize);

  flutterNotification.initialize(initilizationsSettings,
      onSelectNotification: (String payload) {});
}

Future showNotification() async {
  var androidDetails = new AndroidNotificationDetails(
    "Channel ID",
    "Desi programmer",
    importance: Importance.max,
    channelDescription: "This is my channel",
  );
  var iSODetails = new IOSNotificationDetails();
  var generalNotificationDetails =
      new NotificationDetails(android: androidDetails, iOS: iSODetails);

  //time zone
  tz.initializeTimeZones();
  String dtz = await FlutterNativeTimezone.getLocalTimezone();
  if (dtz == "Asia/Calcutta") {
    dtz = "Asia/Kolkata";
  }
  final localTimeZone = tz.getLocation(dtz);
  tz.setLocalLocation(localTimeZone);

  // await flutterNotification.show(
  //     0,
  //     "Health Bloom",
  //     "Its time for you to drink water.",
  //     generalNotificationDetails,);

  // await flutterNotification.periodicallyShow(
  //     1,
  //     "Health Bloom",
  //     "Its time for you to drink water.",
  //     RepeatInterval.everyMinute,
  //     generalNotificationDetails,
  //     androidAllowWhileIdle: true
  // );

  // var time = Time(12, 34, 0);
  // await flutterNotification.showDailyAtTime(
  //     2,
  //     'notification title',
  //     'message here',
  //     time,
  //     generalNotificationDetails,
  //     payload: 'new payload');

  // TimeOfDay _wakeTime = TimeOfDay(hour: int.parse(sp.getString("wakeTime").split(":")[0]), minute: int.parse(sp.getString("wakeTime").split(":")[1]));
  // TimeOfDay _sleepTime = TimeOfDay(hour: int.parse(sp.getString("sleepTime").split(":")[0]), minute: int.parse(sp.getString("sleepTime").split(":")[1]));
  // int _interval = sp.getInt("hrs");
  // int _currentHr = _wakeTime.hour;
  // int _toDays = 0;
  // int _notificationId = 0;
  //
  // while(_toDays <= 30){
  //
  //   while(_currentHr < _sleepTime.hour){
  //
  //     tz.TZDateTime _t = tz.TZDateTime(tz.local,DateTime.now().year,DateTime.now().month,DateTime.now().day,_currentHr,21).add(Duration(days: _toDays));
  //     print("${_t.day}/${_t.month}/${_t.year}/${_t.hour}/${_t.minute}/");
  //     await flutterNotification.zonedSchedule(
  //       _notificationId,
  //       "Health Bloom",
  //       "Its time for you to drink water.",
  //       _t,
  //       generalNotificationDetails,
  //       uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
  //       androidAllowWhileIdle: true,
  //       matchDateTimeComponents: DateTimeComponents.time,
  //     );
  //
  //     _notificationId++;
  //     _currentHr = _currentHr + _interval;
  //
  //   }
  //
  //   _currentHr = _wakeTime.hour;
  //   _toDays++;
  // }


  await flutterNotification.zonedSchedule(
    1,
    "Health Bloom",
    "Its time for you to drink water.",
    tz.TZDateTime(tz.local,DateTime.now().year,DateTime.now().month,DateTime.now().day,7,1),
    generalNotificationDetails,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    androidAllowWhileIdle: true,
    matchDateTimeComponents: DateTimeComponents.time,
  );

  await flutterNotification.zonedSchedule(
    2,
    "Health Bloom",
    "Its time for you to drink water.",
    tz.TZDateTime(tz.local,DateTime.now().year,DateTime.now().month,DateTime.now().day,9,1),
    generalNotificationDetails,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    androidAllowWhileIdle: true,
    matchDateTimeComponents: DateTimeComponents.time,
  );

  await flutterNotification.zonedSchedule(
    3,
    "Health Bloom",
    "Its time for you to drink water.",
    tz.TZDateTime(tz.local,DateTime.now().year,DateTime.now().month,DateTime.now().day,11,1),
    generalNotificationDetails,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    androidAllowWhileIdle: true,
    matchDateTimeComponents: DateTimeComponents.time,
  );

  await flutterNotification.zonedSchedule(
    4,
    "Health Bloom",
    "Its time for you to drink water.",
    tz.TZDateTime(tz.local,DateTime.now().year,DateTime.now().month,DateTime.now().day,13,1),
    generalNotificationDetails,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    androidAllowWhileIdle: true,
    matchDateTimeComponents: DateTimeComponents.time,
  );

  await flutterNotification.zonedSchedule(
    5,
    "Health Bloom",
    "Its time for you to drink water.",
    tz.TZDateTime(tz.local,DateTime.now().year,DateTime.now().month,DateTime.now().day,15,1),
    generalNotificationDetails,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    androidAllowWhileIdle: true,
    matchDateTimeComponents: DateTimeComponents.time,
  );

  await flutterNotification.zonedSchedule(
    6,
    "Health Bloom",
    "Its time for you to drink water.",
    tz.TZDateTime(tz.local,DateTime.now().year,DateTime.now().month,DateTime.now().day,17,1),
    generalNotificationDetails,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    androidAllowWhileIdle: true,
    matchDateTimeComponents: DateTimeComponents.time,
  );

  await flutterNotification.zonedSchedule(
    7,
    "Health Bloom",
    "Its time for you to drink water.",
    tz.TZDateTime(tz.local,DateTime.now().year,DateTime.now().month,DateTime.now().day,19,1),
    generalNotificationDetails,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    androidAllowWhileIdle: true,
    matchDateTimeComponents: DateTimeComponents.time,
  );

  await flutterNotification.zonedSchedule(
    8,
    "Health Bloom",
    "Its time for you to drink water.",
    tz.TZDateTime(tz.local,DateTime.now().year,DateTime.now().month,DateTime.now().day,21,1),
    generalNotificationDetails,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    androidAllowWhileIdle: true,
    matchDateTimeComponents: DateTimeComponents.time,
  );

}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    if (task == "waterReminder")
      showNotification(); //simpleTask will be emitted here.
    return Future.value(false);
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  notificationInit();
  await Firebase.initializeApp();

  // Workmanager().initialize(
  //     callbackDispatcher, // The top level function, aka callbackDispatcher
  //     isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  // );

  await FlutterDownloader.initialize(debug: debug);
  sp = await SharedPreferences.getInstance();
  String baseUrl = "https://health-bloom.herokuapp.com/";

  Provider.debugCheckInvalidValueType = null;
  NetworkManager networkManager = await getAuthNetworkManager(baseUrl);
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
