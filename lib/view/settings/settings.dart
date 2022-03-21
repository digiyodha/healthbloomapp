import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_bloom/utils/colors.dart';
import '../../utils/drawer/custom_drawer.dart';

class Settings extends StatefulWidget {
  const Settings({Key key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _notifications = false;
  bool _vibration = false;
  bool _silent = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
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
          margin: EdgeInsets.only(left: 16,top: 16,right: 16),
          padding: EdgeInsets.only(left: 8,top: 4,right: 8),
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16)
            )
          ),
          child: Column(
            children: [
              SizedBox(height: 14,),
              ListTile(
                title: Text("Push Notifications",
                style: TextStyle(
                  fontSize: 16,
                ),),
                trailing: CupertinoSwitch(
                  activeColor: kMainColor,
                    value: _notifications,
                    onChanged: (v) {
                      setState(() {
                        _notifications = v;
                      });
                    },
                ),
              ),
              SizedBox(height: 0,),
              ListTile(
                title: Text("Vibration mode",
                  style: TextStyle(
                      fontSize: 16,
                  ),),
                trailing: CupertinoSwitch(
                  activeColor: kMainColor,
                  value: _vibration,
                  onChanged: (v) {
                    setState(() {
                      _vibration = v;
                    });
                  },
                ),
              ),
              SizedBox(height: 0,),
              ListTile(
                title: Text("Silent mode",
                  style: TextStyle(
                      fontSize: 16,
                  ),),
                trailing: CupertinoSwitch(
                  activeColor: kMainColor,
                  value: _silent,
                  onChanged: (v) {
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
    );
  }
}
