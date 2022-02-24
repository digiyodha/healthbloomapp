import 'package:flutter/material.dart';
import 'package:health_bloom/main.dart';
import 'package:health_bloom/view/homepage/home_page.dart';
import 'package:health_bloom/view/walkthrough/walkthrough.dart';

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

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).whenComplete(() => getData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset("assets/icons/logo.png")],
        ),
      ),
    );
  }
}
