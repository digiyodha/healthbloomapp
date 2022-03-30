import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_bloom/components/custom_contained_button.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/main.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:health_bloom/view/feedback/feedback_page.dart';
import 'package:health_bloom/view/profile/profile.dart';
import 'package:health_bloom/view/splash/splash_screen.dart';

import '../../utils/drawer/custom_drawer.dart';
import '../homepage/home_page.dart';

class Settings extends StatefulWidget {
  const Settings({Key key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _notifications;
  bool _vibration;
  bool _silent;

  getData() {
    _notifications = sp.getBool("generalNotifications");
    _vibration = sp.getBool("generalVibration");
    _silent = sp.getBool("generalSilent");
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
        return true;
      },
      child: Scaffold(
        key: _key,
        backgroundColor: Color(0xffFAFAFA),
        drawer: CustomDrawer(
          selected: 7,
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xffFAFAFA),
          leading: InkWell(
            onTap: () {
              _key.currentState.openDrawer();
            },
            child: Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
          title: TextBuilder(
            text: "Settings",
            color: Colors.black,
          ),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.only(left: 8, right: 8),
          padding: EdgeInsets.only(left: 8, right: 8),
          decoration: BoxDecoration(
            color: Color(0xffFAFAFA),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shadowColor: Colors.white,
                    clipBehavior: Clip.antiAlias,
                    elevation: 3,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, bottom: 10, top: 25),
                          child: TextBuilder(
                            text: 'Notifications Settings',
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        ListTile(
                          title: TextBuilder(
                            text: "Push Notifications",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          subtitle: TextBuilder(
                            text: 'Recive weekly push notifications',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          trailing: CupertinoSwitch(
                            activeColor: kMainColor,
                            value: _notifications,
                            onChanged: (v) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    "New settings will be effective after app restart."),
                              ));
                              sp.setBool("generalNotifications", v);
                              setState(() {
                                _notifications = v;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: TextBuilder(
                            text: "Vibration mode",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          subtitle: TextBuilder(
                            text: 'Recive vibration on notification time',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          trailing: CupertinoSwitch(
                            activeColor: kMainColor,
                            value: _vibration,
                            onChanged: (v) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    "New settings will be effective after app restart."),
                              ));
                              sp.setBool("generalVibration", v);
                              setState(() {
                                _vibration = v;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: TextBuilder(
                            text: "Silent mode",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          subtitle: TextBuilder(
                            text: 'Tap to silence',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          trailing: CupertinoSwitch(
                            activeColor: kMainColor,
                            value: _silent,
                            onChanged: (v) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    "New settings will be effective after app restart."),
                              ));
                              sp.setBool("generalSilent", v);
                              setState(() {
                                _silent = v;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shadowColor: Colors.white,
                    clipBehavior: Clip.antiAlias,
                    elevation: 3,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, bottom: 10, top: 25),
                          child: TextBuilder(
                            text: 'Others',
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        ListTile(
                          onTap: () {},
                          title: TextBuilder(
                            text: "Privacy Policy",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.black,
                            size: 15,
                          ),
                        ),
                        ListTile(
                          onTap: () {},
                          title: TextBuilder(
                            text: "Terms of use",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.black,
                            size: 15,
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Profile(),
                              ),
                            );
                          },
                          title: TextBuilder(
                            text: "Account",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.black,
                            size: 15,
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FeedbackPage(),
                              ),
                            );
                          },
                          title: TextBuilder(
                            text: "Feedback",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.black,
                            size: 15,
                          ),
                        ),
                        ListTile(
                          onTap: () {},
                          title: TextBuilder(
                            text: "Updates",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.black,
                            size: 15,
                          ),
                        ),
                        ListTile(
                          onTap: () {},
                          title: TextBuilder(
                            text: "About",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.black,
                            size: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                CustomContainedButton(
                  height: 58,
                  textSize: 16,
                  disabledColor: kGreyLite,
                  text: "Logout",
                  onPressed: () async {
                    await _signOut();
                    sp.clear();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SplashScreen();
                    }));
                  },
                  width: double.infinity,
                  borderRadius: 30,
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}
