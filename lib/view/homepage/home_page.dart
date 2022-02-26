import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/model/response/get_user_response.dart';
import 'package:health_bloom/services/api/repository/auth_repository.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:health_bloom/view/bill/add_bill.dart';
import 'package:health_bloom/view/report/add_report.dart';
import 'package:hexagon/hexagon.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/drawer/custom_drawer.dart';
import '../family_members/family_members.dart';
import '../prescription/add_prescription.dart';
import '../water_intake/water_intake.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _bottomNavIndex = 0;
  bool _fabOpened = false;
  Animation<double> _translateButton;
  Animation<Color> _buttonColor;
  Animation<Color> _iconColor;
  AnimationController _animationController;
  double _fabHeight = 56.0;
  Curve _curve = Curves.ease;
  DateTime today = DateTime.now();
  Future _futureUser;
  Future<GetUserResponse> getUser() async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    GetUserResponse _response = await adminAPI.getUserAPI();
    return _response;
  }

  @override
  void initState() {
    super.initState();
    _futureUser = getUser();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            if (mounted) {
              setState(() {
                // getLog(logId: widget.datum.id,canLoad: false);
              });
            }
          });

    _buttonColor = ColorTween(begin: kMainColor, end: Colors.white).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.00, 1.00, curve: Curves.linear)));

    _iconColor = ColorTween(begin: kWhite, end: kGrey7).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.00, 1.00, curve: Curves.linear)));

    _translateButton = Tween<double>(begin: _fabHeight, end: -14).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.00, 0.75, curve: _curve)));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        drawer: CustomDrawer(
          selected: 0,
        ),
        backgroundColor: kWhite,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                SizedBox(
                  height: 18,
                ),
                FutureBuilder<GetUserResponse>(
                  future: _futureUser,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 26,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.wb_sunny,
                                      color: kMainColor,
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "${DateFormat('EEEE, d MMM, yyyy').format(today)}" ??
                                          '',
                                      style: TextStyle(
                                          fontSize: 12,
                                          letterSpacing: 1.5,
                                          color: kMainColor,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "Hi, ${snapshot.data.data.name.toString()}",
                                  style: TextStyle(
                                      fontSize: 34,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 46,
                            width: 46,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage(snapshot.data.data.avatar ??
                                    'https://winfort.net/wp-content/themes/consultix-1/images/no-image-found-360x260.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Center(
                      child: TextBuilder(
                        text: 'Loading',
                        color: Colors.white,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xffF5F6FA)),
                  child: Row(
                    children: [
                      HexagonWidget.pointy(
                        width: 80,
                        height: 80,
                        elevation: 5,
                        cornerRadius: 16,
                        color: kMainColor,
                        padding: 0,
                        child: Center(
                          child: Text(
                            "40",
                            style: TextStyle(fontSize: 30, color: kWhite),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Health Score",
                              style: TextStyle(
                                  color: kBlack,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Check your progress of medicine completion for today",
                              style: TextStyle(color: kGrey6, fontSize: 14),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Read more",
                              style: TextStyle(
                                  color: kMainColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Medicines",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      Icons.more_horiz,
                      color: kGreyText,
                      size: 28,
                    )
                  ],
                ),
                SizedBox(
                  height: 14,
                ),
                GridView(
                  padding: EdgeInsets.only(bottom: 34),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16),
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xff8B80F8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "MEDICINE",
                            style: TextStyle(
                                fontSize: 12,
                                color: kWhite,
                                letterSpacing: 1.5),
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 100,
                              width: 100,
                              child: Image.asset("assets/images/drug1.png"),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "9:00 AM",
                            style: TextStyle(
                                fontSize: 22,
                                color: kWhite,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "Dosage - 10 mg",
                            style: TextStyle(
                                fontSize: 14,
                                color: kWhite.withOpacity(0.6),
                                fontWeight: FontWeight.w400),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xffAF8EFF),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "MEDICINE",
                            style: TextStyle(
                                fontSize: 12,
                                color: kWhite,
                                letterSpacing: 1.5),
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 100,
                              width: 100,
                              child: Image.asset("assets/images/drug2.png"),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "9:30 AM",
                            style: TextStyle(
                                fontSize: 22,
                                color: kWhite,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "Dosage - 5 mg",
                            style: TextStyle(
                                fontSize: 14,
                                color: kWhite.withOpacity(0.6),
                                fontWeight: FontWeight.w400),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xffFFA38E),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "MEDICINE",
                            style: TextStyle(
                                fontSize: 12,
                                color: kWhite,
                                letterSpacing: 1.5),
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 100,
                              width: 100,
                              child: Image.asset("assets/images/drug2.png"),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "11:00 AM",
                            style: TextStyle(
                                fontSize: 22,
                                color: kWhite,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "Dosage - 8 mg",
                            style: TextStyle(
                                fontSize: 14,
                                color: kWhite.withOpacity(0.6),
                                fontWeight: FontWeight.w400),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return WaterIntake();
                        }));
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xff8B80F8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "WATER",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: kWhite,
                                  letterSpacing: 1.5),
                            ),
                            Spacer(),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 100,
                                width: 100,
                                child: Image.asset(
                                    "assets/images/water_glass.png"),
                              ),
                            ),
                            Spacer(),
                            Text(
                              "750 ml",
                              style: TextStyle(
                                  fontSize: 22,
                                  color: kWhite,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              "Last updates 3m ago",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: kWhite.withOpacity(0.6),
                                  fontWeight: FontWeight.w400),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return FamilyMembers();
                        }));
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xff4C5A81),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "FAMILY MEMBERS",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: kWhite,
                                  letterSpacing: 1.5),
                            ),
                            Spacer(),
                            Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.supervised_user_circle_sharp,
                                color: kWhite,
                                size: 100,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "9:00 AM",
                              style: TextStyle(
                                  fontSize: 22,
                                  color: kWhite,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              "Dosage - 10 mg",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: kWhite.withOpacity(0.6),
                                  fontWeight: FontWeight.w400),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        floatingActionButton: CircleAvatar(
          radius: _fabOpened ? 120 : 30,
          backgroundColor: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (_fabOpened)
                Column(
                  children: [
                    Transform(
                      transform: Matrix4.translationValues(
                          0.0, _translateButton.value * 3.0, 0.0),
                      child: addPrescription(),
                    ),
                    Transform(
                      transform: Matrix4.translationValues(
                          0.0, _translateButton.value * 2.0, 0.0),
                      child: addReport(),
                    ),
                    Transform(
                      transform: Matrix4.translationValues(
                          0.0, _translateButton.value, 0.0),
                      child: addBill(),
                    ),
                  ],
                ),
              buttonFAB()
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar(
          elevation: 20,
          height: 60,
          icons: [
            Icons.home,
            Icons.mic_rounded,
            Icons.list,
            Icons.person,
          ],
          activeIndex: _bottomNavIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.defaultEdge,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          onTap: (index) => setState(() => _bottomNavIndex = index),
          activeColor: kBlack,
          inactiveColor: kGreyLite,
          //other params
        ),
      ),
    );
  }

  Widget addReport() {
    return Container(
      margin: EdgeInsets.only(right: 24.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: kGrey2,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 5)
                ]),
            child: Text(
              'Report',
              style: TextStyle(
                  fontSize: 20, color: kGrey7, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          FloatingActionButton(
            heroTag: "suggestion",
            backgroundColor: kMainColor,
            onPressed: () {
              animate();
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AddReport();
              }));
            },
            child: Center(
              child: Container(
                width: 22,
                height: 22,
                child: Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget addBill() {
    return Container(
      margin: EdgeInsets.only(right: 24.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: kGrey2,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 5)
                ]),
            child: Text(
              'Bill',
              style: TextStyle(
                  fontSize: 20, color: kGrey7, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          FloatingActionButton(
            heroTag: "schedule",
            backgroundColor: kMainColor,
            onPressed: () {
              animate();
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AddBill();
              }));
            },
            child: Center(
              child: Container(
                width: 25,
                height: 25,
                child: Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonFAB() {
    return FloatingActionButton(
      heroTag: "FAB",
      onPressed: () {
        animate();
      },
      backgroundColor: kMainColor,
      tooltip: 'Toggle',
      child: _fabOpened
          ? Icon(
              Icons.close,
              color: kWhite,
            )
          : Icon(
              Icons.add,
              color: kWhite,
            ),
    );
  }

  Widget addPrescription() {
    return Container(
      margin: EdgeInsets.only(right: 24.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: kGrey2,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 5)
                ]),
            child: Text(
              'Prescription',
              style: TextStyle(
                  fontSize: 20, color: kGrey7, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          FloatingActionButton(
            foregroundColor: Colors.white,
            heroTag: "event",
            backgroundColor: kMainColor,
            onPressed: () {
              animate();
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AddPrescription();
              }));
            },
            child: Center(
              child: Container(
                width: 22,
                height: 22,
                child: Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }

  animate() {
    if (!_fabOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    _fabOpened = !_fabOpened;
  }
}
