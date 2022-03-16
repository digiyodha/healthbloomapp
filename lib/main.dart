import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:health_bloom/services/api/networking.dart';

import 'package:health_bloom/services/api/networkmanager/auth_networkmanager.dart';
import 'package:health_bloom/services/api/repository/auth_repository.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:health_bloom/view/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

SharedPreferences sp;
const debug = true;

FlutterLocalNotificationsPlugin flutterNotification = FlutterLocalNotificationsPlugin();

notificationInit(){
  var androidInitilize = new AndroidInitializationSettings('app_icon');
  var iOSinitilize = new IOSInitializationSettings();
  var initilizationsSettings = new InitializationSettings(
      android: androidInitilize, iOS: iOSinitilize);

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

  await flutterNotification.show(
      0,
      "Health Bloom",
      "Its time for you to drink water.",
      generalNotificationDetails,);

  // await flutterNotification.periodicallyShow(
  //     1,
  //     "Health Bloom",
  //     "Its time for you to drink water.",
  //     RepeatInterval.everyMinute,
  //     generalNotificationDetails,
  //     androidAllowWhileIdle: true
  // );
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    if(task == "waterReminder")
      showNotification(); //simpleTask will be emitted here.
    return Future.value(false);
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  notificationInit();
  await Firebase.initializeApp();

  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );

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
