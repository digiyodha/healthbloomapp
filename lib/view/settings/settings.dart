import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_bloom/main.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:health_bloom/view/feedback/feedback_page.dart';
import 'package:health_bloom/view/profile/profile.dart';

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
        backgroundColor: kMainColor,
        drawer: CustomDrawer(
          selected: 7,
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kMainColor,
          title: Text("Settings"),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.only(left: 16, top: 16, right: 16),
          padding: EdgeInsets.only(left: 8, top: 4, right: 8),
          decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16))),
          child: Column(
            children: [
              SizedBox(height: 14),
              ListTile(
                title: Text(
                  "Push Notifications",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                trailing: CupertinoSwitch(
                  activeColor: kMainColor,
                  value: _notifications,
                  onChanged: (v) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                title: Text(
                  "Vibration mode",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                trailing: CupertinoSwitch(
                  activeColor: kMainColor,
                  value: _vibration,
                  onChanged: (v) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                title: Text(
                  "Silent mode",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                trailing: CupertinoSwitch(
                  activeColor: kMainColor,
                  value: _silent,
                  onChanged: (v) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
              ListTile(
                onTap: () {},
                title: Text(
                  "Privacy Policy",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                title: Text(
                  "Terms of use",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                title: Text(
                  "Account",
                  style: TextStyle(
                    fontSize: 16,
                  ),
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
                title: Text(
                  "Feedback",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                title: Text(
                  "Updates",
                  style: TextStyle(
                    fontSize: 16,
                  ),
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
                title: Text(
                  "About",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
