import 'package:flutter/material.dart';
import 'package:health_bloom/main.dart';
import 'package:health_bloom/utils/colors.dart';
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
    );
  }
}
