import 'package:flutter/material.dart';
import 'package:health_bloom/components/medicine_card.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/model/request/delete_mdecine_request.dart';
import 'package:health_bloom/model/request/search_mdecine_request.dart';
import 'package:health_bloom/model/response/delete_medicine_response.dart';
import 'package:health_bloom/model/response/get_all_member_response.dart';
import 'package:health_bloom/model/response/get_user_response.dart';
import 'package:health_bloom/model/response/search_medicne_response.dart';
import 'package:health_bloom/services/api/repository/auth_repository.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:health_bloom/view/bill/add_bill.dart';
import 'package:health_bloom/view/medicine/add_medicine.dart';
import 'package:health_bloom/view/medicine/list_medicine.dart';
import 'package:health_bloom/view/medicine/view_medicine.dart';
import 'package:health_bloom/view/report/add_report.dart';
import 'package:hexagon/hexagon.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../utils/custom_bnb.dart';
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
  bool _fabOpened = false;
  Animation<double> _translateButton;
  Animation<Color> _buttonColor;
  Animation<Color> _iconColor;
  AnimationController _animationController;
  bool _loading = false;
  double _fabHeight = 56.0;
  Curve _curve = Curves.ease;
  DateTime today = DateTime.now();
  DateTime _today = DateTime.now();
  int _waterInMl;
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  Future<GetUserResponse> getUser() async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    GetUserResponse _response = await adminAPI.getUserAPI();
    return _response;
  }

  Future _getMembers;
  Future<GetAllMemberResponse> getAllmember() async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    GetAllMemberResponse _response = await adminAPI.getAllMemberAPI();
    return _response;
  }

  SearchMedicineResponse _currentResponse;
  Future searchMedicine() async {
    setState(() {
      _currentResponse = null;
    });
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    SearchMedicineResponse _response =
        await adminAPI.searchMedicineAPI(SearchMedicineRequest(name: ''));
    setState(() {
      _currentResponse = _response;
      print("Search Medicine Response ${_currentResponse.toJson()}");
      _loading = false;
    });
  }

  Future<DeleteMedicineResponse> deleteMedicine(
      DeleteMedicineRequest request) async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    DeleteMedicineResponse _response =
        await adminAPI.deleteMedicineAPI(request);
    return _response;
  }

  getData() {
    setState(() {
      _waterInMl = null;
    });
    if (sp.getString("${_today.day}/${_today.month}/${_today.year}") != null) {
      _waterInMl = int.parse(
          sp.getString("${_today.day}/${_today.month}/${_today.year}"));
    } else {
      sp.setString("${_today.day}/${_today.month}/${_today.year}", "0");
      _waterInMl = 0;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getMembers = getAllmember();
    getData();
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
    searchMedicine();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        key: _drawerKey,
        drawer: CustomDrawer(
          selected: 0,
        ),
        backgroundColor: kWhite,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                SizedBox(height: 18),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              _drawerKey.currentState.openDrawer();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Icon(Icons.menu),
                            ),
                          ),
                          SizedBox(height: 26),
                          Row(
                            children: [
                              Icon(
                                Icons.wb_sunny,
                                color: kMainColor,
                                size: 15,
                              ),
                              SizedBox(width: 4),
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
                          SizedBox(height: 4),
                          Text(
                            "Hi, ${sp.getString('name') ?? "User"}",
                            style: TextStyle(
                                fontSize: 34, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    sp.getString('profileImage') != null &&
                            sp.getString('profileImage') != ""
                        ? Container(
                            height: 46,
                            width: 46,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image:
                                    NetworkImage(sp.getString('profileImage')),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(
                            height: 46,
                            width: 46,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.person,
                                color: kGrey4,
                                size: 40,
                              ),
                            ),
                          )
                  ],
                ),
                SizedBox(height: 24),
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
                SizedBox(height: 24),
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
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListMedicine(),
                          ),
                        ).whenComplete(() {
                          setState(() {
                            searchMedicine();
                          });
                        });
                      },
                      child: Icon(
                        Icons.more_horiz,
                        color: kGreyText,
                        size: 28,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 14),
                _currentResponse == null
                    ? CircularProgressIndicator()
                    : _currentResponse.data.isNotEmpty
                        ? Container(
                            width: double.infinity,
                            height: _currentResponse.data.length != 0 ? 220 : 0,
                            child: ListView.builder(
                              itemCount: _currentResponse.data.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: ScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemBuilder: (BuildContext context, int index) {
                                return MedicineCard(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ViewMedicine(
                                          medicne: _currentResponse.data[index],
                                        ),
                                      ),
                                    );
                                  },
                                  medicineName:
                                      _currentResponse.data[index].medicineName,
                                  time: _currentResponse.data[index].time.first,
                                  dosages: _currentResponse.data[index].dosage,
                                  edit: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddMedicine(
                                            medicine:
                                                _currentResponse.data[index]),
                                      ),
                                    ).whenComplete(() {
                                      setState(() {
                                        searchMedicine();
                                      });
                                    });
                                  },
                                  delete: () {
                                    showDialog(
                                      context: context,
                                      useSafeArea: true,
                                      barrierDismissible: true,
                                      builder: (context) {
                                        return FutureBuilder(
                                          builder: (context, snapshot) {
                                            return AlertDialog(
                                              title: Text(
                                                  'Delete ${_currentResponse.data[index].medicineName}'),
                                              content: Text('Are you sure!'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: TextBuilder(
                                                        text: 'No')),
                                                MaterialButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                  color: Color(0xffFF9B91),
                                                  onPressed: () async {
                                                    DeleteMedicineRequest
                                                        _request =
                                                        DeleteMedicineRequest(
                                                            id: _currentResponse
                                                                .data[index]
                                                                .id);
                                                    DeleteMedicineResponse
                                                        _response =
                                                        await deleteMedicine(
                                                            _request);

                                                    print(
                                                        'Delete Medicine Request ${_request.toJson()}');
                                                    print(
                                                        'Delete Medicine Response ${_response.toJson()}');
                                                    if (_response.success ==
                                                        true) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                        content:
                                                            Text('deleted.'),
                                                      ));

                                                      Navigator.pop(
                                                          context, true);
                                                    }
                                                  },
                                                  child: TextBuilder(
                                                    text: 'Yes',
                                                    color: Colors.white,
                                                  ),
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ).whenComplete(() => setState(() {
                                          searchMedicine();
                                        }));
                                  },
                                );
                              },
                            ),
                          )
                        : Center(
                            child: TextBuilder(text: 'No Medicine Found'),
                          ),
                SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Water Intake & Family Member",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // Icon(
                    //   Icons.more_horiz,
                    //   color: kGreyText,
                    //   size: 28,
                    // )
                  ],
                ),
                SizedBox(height: 14),
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
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return WaterIntake();
                        })).whenComplete(() {
                          getData();
                          setState(() {});
                        });
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
                              "$_waterInMl ml",
                              style: TextStyle(
                                  fontSize: 22,
                                  color: kWhite,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              "Consumed today",
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
                        })).whenComplete(() {
                          setState(() {
                            _getMembers = getAllmember();
                          });
                        });
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
                            FutureBuilder<GetAllMemberResponse>(
                              future: _getMembers,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<DateTime> time = snapshot.data.data
                                          .map((e) => e.updatedAt)
                                          .toList() ??
                                      [];
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data.data.length != 0
                                            ? "${snapshot.data.data.length.toString()} Family Members"
                                            : 'No Family Members',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: kWhite,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(height: 6),
                                      Text(
                                        snapshot.data.data.length != 0 &&
                                                time.isNotEmpty
                                            ? "Updated at - ${today.difference(time.first).inHours.toString() + ' hours ago'}"
                                            : "Updated at - ${today.difference(today).inHours.toString() + ' hours ago'}",
                                        // "Time - ${DateFormat('hh:mm a').format().toString()}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: kWhite.withOpacity(0.6),
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  );
                                } else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }
                                return Center(
                                    child: TextBuilder(
                                  text: 'Fetching users...',
                                  color: Colors.white,
                                ));
                              },
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _settingModalBottomSheet(context);
          },
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: CustomBnb(
          current: 0,
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
          SizedBox(width: 16),
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

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: new Icon(Icons.add),
                title: Text('Bill'),
                onTap: () {
                  Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddBill()))
                      .whenComplete(() => Navigator.pop(context));
                },
              ),
              ListTile(
                leading: new Icon(Icons.add),
                title: new Text('Report'),
                onTap: () {
                  Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddReport()))
                      .whenComplete(() => Navigator.pop(context));
                },
              ),
              ListTile(
                leading: new Icon(Icons.add),
                title: new Text('Prescription'),
                onTap: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddPrescription()))
                      .whenComplete(() => Navigator.pop(context));
                },
              ),
              ListTile(
                leading: new Icon(Icons.add),
                title: new Text('Medicine'),
                onTap: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddMedicine()))
                      .whenComplete(() {
                    setState(() {
                      Navigator.pop(context);
                      searchMedicine();
                    });
                  });
                },
              ),
              // ListTile(
              //   leading: new Icon(Icons.add),
              //   title: new Text('Insurance'),
              //   onTap: () {
              //     Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) => AddInsurance()))
              //         .whenComplete(() => Navigator.pop(context));
              //   },
              // ),
            ],
          ),
        );
      },
    );
  }
}
