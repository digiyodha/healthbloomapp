import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:health_bloom/main.dart';
import 'package:health_bloom/view/water_intake/water_settings.dart';
import '../../components/custom_contained_button.dart';
import '../../utils/drawer/custom_drawer.dart';
import '../homepage/home_page.dart';

class WaterIntake extends StatefulWidget {
  const WaterIntake({Key key}) : super(key: key);

  @override
  State<WaterIntake> createState() => _WaterIntakeState();
}

class _WaterIntakeState extends State<WaterIntake> {
  int _glassCount = 0;
  double _percent;
  DateTime _today = DateTime.now();
  int _waterInMl;
  int _totalIntakeDaily;
  int _glassVolume;

  getData() {
    setState(() {
      _waterInMl = null;
    });

    if (sp.getInt("dailyIntake") == null) {
      sp.setInt("dailyIntake", 1500);
      _totalIntakeDaily = 1500;
    } else {
      _totalIntakeDaily = sp.getInt("dailyIntake");
    }

    if (sp.getInt("glassVolume") == null) {
      sp.setInt("glassVolume", 300);
      _glassVolume = 300;
    } else {
      _glassVolume = sp.getInt("glassVolume");
    }

    if (sp.getString("${_today.day}/${_today.month}/${_today.year}") != null) {
      _waterInMl = int.parse(
          sp.getString("${_today.day}/${_today.month}/${_today.year}"));
      if (_waterInMl > _totalIntakeDaily) _waterInMl = _totalIntakeDaily;
    } else {
      sp.setString("${_today.day}/${_today.month}/${_today.year}", "0");
      _waterInMl = 0;
    }

    _percent = (_waterInMl / _totalIntakeDaily);
    setState(() {});
  }

  addData() {
    sp.setString(
        "${_today.day}/${_today.month}/${_today.year}", _waterInMl.toString());
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async{
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
        drawer: CustomDrawer(
          selected: 2,
        ),
        backgroundColor: kWhite,
        appBar: AppBar(
          iconTheme: IconThemeData(color: kBlack),
          elevation: 0,
          backgroundColor: kWhite,
          actions: [
            IconButton(
              onPressed: () {
                showGeneralDialog(
                    context: context,
                    pageBuilder: (_, __, ___) {
                      return WaterSettings();
                    }).whenComplete(() {
                  getData();
                });
              },
              icon: Icon(Icons.settings_outlined),
            ),
            SizedBox(
              width: 4,
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              flex: 6,
              child: Column(
                children: [
                  Spacer(),
                  Text(
                    "HYDRATION",
                    style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: kMainColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Today You took",
                    style: TextStyle(
                        fontSize: 28, fontWeight: FontWeight.w600, color: kBlack),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${sp.getString("${_today.day}/${_today.month}/${_today.year}") ?? ""} ml ",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: kMainColor),
                      ),
                      Text(
                        "of water ",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: kBlack),
                      ),
                      Image.asset(
                        "assets/images/water_drop.png",
                        height: 26,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Almost there! Keep hydrated",
                    style: TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w600, color: kGrey6),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: 63,
                      width: 60,
                      margin: EdgeInsets.only(
                          left: _percent > 0.05
                              ? (_size.width - 60) * _percent - 10
                              : 20),
                      child: Stack(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                color: kMainColor, shape: BoxShape.circle),
                            child: Center(
                              child: Text(
                                "${sp.getString("${_today.day}/${_today.month}/${_today.year}") ?? ""}",
                                style: TextStyle(fontSize: 16, color: kWhite),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Transform.rotate(
                                  angle: 150,
                                  child: Container(
                                    height: 16,
                                    width: 16,
                                    color: kMainColor,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    height: 55,
                    width: _size.width - 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Color(0xff5ED4E2)),
                    child: Row(
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                          height: double.infinity,
                          width: (_size.width - 60 - 8) * _percent,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Color(0xff7FE3F0)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (_percent > 0.2)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: CircleAvatar(
                                    radius: 3,
                                    backgroundColor: kWhite.withOpacity(0.5),
                                  ),
                                ),
                              if (_percent > 0.4)
                                Padding(
                                  padding: const EdgeInsets.only(top: 25),
                                  child: CircleAvatar(
                                    radius: 4,
                                    backgroundColor: kWhite.withOpacity(0.5),
                                  ),
                                ),
                              if (_percent > 0.6)
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: CircleAvatar(
                                    radius: 6,
                                    backgroundColor: kWhite.withOpacity(0.7),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Poor",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: _percent < 0.25
                                  ? FontWeight.w600
                                  : FontWeight.w400),
                        ),
                        Text(
                          "Good",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: _percent < 0.5 && _percent > 0.25
                                  ? FontWeight.w600
                                  : FontWeight.w400),
                        ),
                        Text(
                          "Almost",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: _percent < 0.75 && _percent > 0.5
                                  ? FontWeight.w600
                                  : FontWeight.w400),
                        ),
                        Text(
                          "Perfect!",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: _percent > 0.75
                                  ? FontWeight.w600
                                  : FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffF5F6FA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            if (_glassCount > 0)
                              setState(() {
                                _glassCount--;
                              });
                          },
                          child: AnimatedContainer(
                            margin: EdgeInsets.only(left: 20),
                            duration: Duration(milliseconds: 200),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: _glassCount > 0
                                    ? kMainColor
                                    : Color(0xffD5D8DF)),
                            child: Center(
                              child: Icon(
                                Icons.remove,
                                color: kWhite,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(36),
                            color: kWhite,
                            // boxShadow: [
                            //   BoxShadow(
                            //       color: Colors.black12,
                            //       blurRadius: 10,
                            //     offset: Offset(0.0,5.0)
                            //   )
                            // ]
                          ),
                          child: Center(
                            child: Image.asset(
                              "assets/images/water_glass_3.png",
                              height: 70,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _glassCount++;
                            });
                          },
                          child: AnimatedContainer(
                            margin: EdgeInsets.only(right: 20),
                            duration: Duration(milliseconds: 200),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: kMainColor),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: kWhite,
                                size: 26,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    RichText(
                      text: TextSpan(
                          text: "${_glassCount}x ",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: kBlack),
                          children: [
                            TextSpan(
                              text: "Glass $_glassVolume ml",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: kBlack),
                            )
                          ]),
                    ),
                    Spacer(),
                    CustomContainedButton(
                      height: 54,
                      textSize: 16,
                      disabledColor: kGreyLite,
                      text: "Add Drink",
                      onPressed: () {
                        if (_glassCount != 0) {
                          _waterInMl = int.parse(sp.getString(
                              "${_today.day}/${_today.month}/${_today.year}"));
                          _waterInMl += _glassVolume * _glassCount;
                          _glassCount = 0;
                          addData();
                          getData();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Please add the water quantity first!"),
                          ));
                        }
                      },
                      width: double.infinity,
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.handHoldingWater,
                            size: 16,
                          ),
                          SizedBox(
                            width: 14,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
