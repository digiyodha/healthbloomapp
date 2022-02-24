import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:health_bloom/services/api/networking.dart';
import 'package:health_bloom/services/api/networkmanager/auth_networkmanager.dart';
import 'package:health_bloom/services/api/repository/auth_repository.dart';
import 'package:health_bloom/view/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences sp;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
