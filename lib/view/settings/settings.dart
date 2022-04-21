import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_bloom/components/custom_contained_button.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/main.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:health_bloom/view/about/about_app.dart';

import 'package:health_bloom/view/feedback/feedback_page.dart';
import 'package:health_bloom/view/main_view.dart';
import 'package:health_bloom/view/profile/profile.dart';
import 'package:health_bloom/view/settings/privacy_policy.dart';
import 'package:health_bloom/view/settings/terms_of_use.dart';
import 'package:health_bloom/view/splash/splash_screen.dart';
import 'package:new_version/new_version.dart';

import '../../utils/drawer/custom_drawer.dart';

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

  // GlobalKey _aboutApp = GlobalKey();
  // GlobalKey _aboutDev = GlobalKey();

  @override
  void initState() {
    super
        .initState(); // Instantiate NewVersion manager object (Using GCP Console app as example)

    getData();
  }

  final newVersion = NewVersion(
    androidId: 'com.example.health_bloom', iOSId: 'com.example.healthBloom',
    // androidId: 'com.adbytee.mera_desh',
    // iOSId: 'com.adbytee.mera_desh',
  );
  basicStatusCheck(NewVersion newVersion) {
    newVersion.showAlertIfNecessary(context: context);
  }

  advancedStatusCheck(NewVersion newVersion) async {
    final status = await newVersion.getVersionStatus();

    if (status != null) {
      print('Release Note : ' + status.releaseNotes);
      print('App Store Link : ' + status.appStoreLink);
      print('Local Version : ' + status.localVersion);
      print('Store Version : ' + status.storeVersion);
      print('Canupdate : ' + status.canUpdate.toString());
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        dialogTitle: 'Update App?',
        dialogText:
            'A new version of Health Bloom is available! Version ${status.storeVersion} is now available - you have ${status.localVersion} \n\nWould you like to update it now?',
        allowDismissal: true,
      );
    }
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    // final appcastURL =
    //     'https://raw.githubusercontent.com/larryaasen/upgrader/master/test/testappcast.xml';
    // final cfg = AppcastConfiguration(url: appcastURL, supportedOS: [
    //   'android',
    // ]);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainView(),
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PrivacyPolicy(),
                              ),
                            );
                          },
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TermsOfUse(),
                              ),
                            );
                          },
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
                          onTap: () async {
                            if (Platform.isAndroid) {
                              print('If Part is running');

                              final uri = Uri.https(
                                  "play.google.com",
                                  "/store/apps/details",
                                  {"id": "${newVersion.androidId}"});
                              final response = await http.get(uri);
                              if (response.statusCode != 200) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      'Can\'t find an app in the Play Store with the id: ${newVersion.androidId}'),
                                ));
                              } else {
                                print('Inside Else Part is running');
                                advancedStatusCheck(newVersion);
                              }
                            } else {
                              print('Else Part is running');
                              advancedStatusCheck(newVersion);
                            }
                          },
                          title: TextBuilder(
                            text: "Updates",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          // trailing: Icon(
                          //   Icons.arrow_forward_ios_rounded,
                          //   color: Colors.black,
                          //   size: 15,
                          // ),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AboutApp(),
                              ),
                            );
                          },
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
                        const SizedBox(height: 10.0),
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
