import 'package:cron/cron.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';
import '../../main.dart';
import '../../utils/colors.dart';

class WaterSettings extends StatefulWidget {
  const WaterSettings({Key key}) : super(key: key);

  @override
  _WaterSettingsState createState() => _WaterSettingsState();
}

class _WaterSettingsState extends State<WaterSettings> {
  bool _notifications = false;

  Cron cron = Cron();

  @override
  void initState() {
    super.initState();

    if (sp.getBool("waterNotification") == null) {
      sp.setBool("waterNotification", false);
      _notifications = false;
    } else {
      _notifications = sp.getBool("waterNotification");
    }

    if (sp.getInt("hrs") == null) {
      sp.setInt("hrs", 1);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          margin: EdgeInsets.only(left: 80),
          decoration: BoxDecoration(color: kWhite),
          child: InkWell(
            onTap: () {},
            child: Column(
              children: [
                SafeArea(
                  child: Container(),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "GENERAL",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: kGrey5,
                            letterSpacing: 1.5),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      InkWell(
                        onTap: () {
                          showCupertinoModalPopup(
                              context: context,
                              builder: (_) => Container(
                                    width: double.infinity,
                                    height: 250,
                                    child: CupertinoPicker(
                                      backgroundColor: Colors.white,
                                      itemExtent: 30,
                                      scrollController:
                                          FixedExtentScrollController(
                                              initialItem: 20),
                                      children: _waterQuantity
                                          .map(
                                            (e) => Text(e.toString()),
                                          )
                                          .toList(),
                                      onSelectedItemChanged: (value) {
                                        setState(() {
                                          sp.setInt("dailyIntake",
                                              _waterQuantity[value]);
                                        });
                                      },
                                    ),
                                  ));
                        },
                        child: Container(
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Goal of the Day",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "${sp.getInt("dailyIntake")}ml",
                                style: TextStyle(
                                  color: kMainColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showCupertinoModalPopup(
                              context: context,
                              builder: (_) => Container(
                                    width: double.infinity,
                                    height: 250,
                                    child: CupertinoPicker(
                                      backgroundColor: Colors.white,
                                      itemExtent: 30,
                                      scrollController:
                                          FixedExtentScrollController(
                                              initialItem: 0),
                                      children: _waterQuantity
                                          .map(
                                            (e) => Text(e.toString()),
                                          )
                                          .toList(),
                                      onSelectedItemChanged: (value) {
                                        setState(() {
                                          sp.setInt("glassVolume",
                                              _waterQuantity[value]);
                                        });
                                      },
                                    ),
                                  ));
                        },
                        child: Container(
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Amount of 1 cup",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "${sp.getInt("glassVolume")}ml",
                                style: TextStyle(
                                  color: kMainColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: kGrey3,
                ),
                SizedBox(
                  height: 14,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "APP SETTINGS",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: kGrey5,
                            letterSpacing: 1.5),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Notifications",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              Switch(
                                  value: _notifications,
                                  onChanged: (v) {
                                    sp.setBool("waterNotification", v);

                                    if(v){

                                      Workmanager().registerPeriodicTask(
                                        "2",
                                        "waterReminder",
                                        // When no frequency is provided the default 15 minutes is set.
                                        // Minimum frequency is 15 min. Android will automatically change your frequency to 15 min if you have configured a lower frequency.
                                        frequency: Duration(minutes: 16),
                                      );
                                      
                                      //showNotification();
                                    }else{
                                      //flutterNotification.cancelAll();
                                      Workmanager().cancelByUniqueName("2");
                                    }

                                    setState(() {
                                      _notifications = v;
                                    });
                                  }),
                            ],
                          ),
                        ),
                      ),
                      if (_notifications)
                        InkWell(
                          onTap: () {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (_) => Container(
                                      width: double.infinity,
                                      height: 250,
                                      child: CupertinoPicker(
                                        backgroundColor: Colors.white,
                                        itemExtent: 30,
                                        scrollController:
                                            FixedExtentScrollController(
                                                initialItem: 0),
                                        children: _hrs
                                            .map(
                                              (e) => Text(e.toString()),
                                            )
                                            .toList(),
                                        onSelectedItemChanged: (value) {
                                          setState(() {
                                            sp.setInt("hrs", _hrs[value]);
                                          });
                                        },
                                      ),
                                    ));
                          },
                          child: Container(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Set time reminder",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Every ${sp.getInt("hrs")} hr",
                                  style: TextStyle(
                                    color: kMainColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<int> _hrs = [1, 2, 3, 4, 5, 6, 7, 8];

  List<int> _waterQuantity = [
    100,
    200,
    300,
    400,
    500,
    600,
    700,
    800,
    900,
    1000,
    1100,
    1200,
    1300,
    1400,
    1500,
    1600,
    1700,
    1800,
    1900,
    2000,
    2100,
    2200,
    2300,
    2400,
    2500,
    2600,
    2700,
    2800,
    2900,
    3000,
    3100,
    3200,
    3300,
    3400,
    3500,
    3600,
    3700,
    3800,
    3900,
    4000,
    4100,
    4200,
    4300,
    4400,
    4500,
    4600,
    4700,
    4800,
    4900,
    5000,
    5100,
    5200,
    5300,
    5400,
    5500,
    5600,
    5700,
    5800,
    5900,
    6000,
    6100,
    6200,
    6300,
    6400,
    6500,
    6600,
    6700,
    6800,
    6900,
    7000,
    7100,
    7200,
    7300,
    7400,
    7500,
    7600,
    7700,
    7800,
    7900,
    8000
  ];
}
