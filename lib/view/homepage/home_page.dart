import 'package:flutter/material.dart';
import 'package:health_bloom/components/medicine_card.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/model/request/delete_mdecine_request.dart';
import 'package:health_bloom/model/request/get_next_medicine_response.dart';
import 'package:health_bloom/model/response/delete_medicine_response.dart';
import 'package:health_bloom/model/response/get_all_member_response.dart';
import 'package:health_bloom/model/response/get_user_response.dart';
import 'package:health_bloom/services/api/repository/auth_repository.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:health_bloom/utils/custom_add_element_bs.dart';
import 'package:health_bloom/view/bill/add_bill.dart';
import 'package:health_bloom/view/medicine/about_medicine.dart';
import 'package:health_bloom/view/medicine/add_medicine.dart';
import 'package:health_bloom/view/medicine/list_medicine.dart';

import 'package:health_bloom/view/profile/profile.dart';
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

class _HomePageState extends State<HomePage> {
  bool _loading = false;
  DateTime todayTime = DateTime.now().toUtc();
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

  Future<GetNextMedicineResponse> getNextMedicine() async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    GetNextMedicineResponse _response = await adminAPI.getNextMedicineAPI();
    return _response;
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
    getNextMedicine();
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
                        ? InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Profile()));
                            },
                            child: Container(
                              height: 46,
                              width: 46,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      sp.getString('profileImage')),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Profile()));
                            },
                            child: Container(
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
                            getNextMedicine();
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
                FutureBuilder<GetNextMedicineResponse>(
                  future: getNextMedicine(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // snapshot.data.data
                      //     .sort((a, b) => a.startHour.compareTo(b.startHour));
                      return snapshot.data.data.isNotEmpty
                          ? Container(
                              width: double.infinity,
                              height: snapshot.data.data.length == 0 ? 40 : 220,
                              child: ListView.builder(
                                itemCount: snapshot.data.data.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: ScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemBuilder: (BuildContext context, int i) {
                                  return MedicineCard(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AboutMedicine(
                                              id: snapshot.data.data[i].id),
                                        ),
                                      ).whenComplete(() {
                                        setState(() {
                                          getNextMedicine();
                                        });
                                      });
                                    },
                                    medicineName:
                                        snapshot.data.data[i].medicineName,
                                    time: snapshot.data.data[i].startHour,
                                    dosages: snapshot.data.data[i].dosage,
                                    edit: () {
                                      if (snapshot.data.data[i].patient !=
                                          null) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AddMedicine(
                                              id: snapshot.data.data[i].id,
                                              getNextMedicine:
                                                  snapshot.data.data[i],
                                              getMedicine: null,
                                            ),
                                          ),
                                        ).whenComplete(() {
                                          setState(() {
                                            getNextMedicine();
                                          });
                                        });
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text('Patient not found'),
                                        ));
                                      }
                                    },
                                    delete: () {
                                      showDialog(
                                        context: context,
                                        useSafeArea: true,
                                        barrierDismissible: true,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(
                                                'Delete ${snapshot.data.data[i].medicineName}'),
                                            content: Text('Are you sure!'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child:
                                                      TextBuilder(text: 'No')),
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
                                                          id: snapshot
                                                              .data.data[i].id);
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
                                                        .showSnackBar(SnackBar(
                                                      content: Text('deleted.'),
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
                                      ).whenComplete(() => setState(() {
                                            getNextMedicine();
                                          }));
                                    },
                                    hideIcon: true,
                                  );
                                },
                              ),
                            )
                          : Row(
                              children: [
                                TextBuilder(
                                  text: 'No Medicine Found',
                                  color: Colors.black,
                                ),
                              ],
                            );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Center(child: CircularProgressIndicator());
                  },
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
                                size: 90,
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
                                            ? snapshot.data.data.length == 1
                                                ? "${snapshot.data.data.length.toString()} Family Member"
                                                : "${snapshot.data.data.length.toString()} Family Members"
                                            : 'No Family Members',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: kWhite,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      snapshot.data.data.length != 0 &&
                                              time.isNotEmpty
                                          ? SizedBox(height: 6)
                                          : SizedBox(),
                                      snapshot.data.data.length != 0 &&
                                              time.isNotEmpty
                                          ? FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                today
                                                            .difference(
                                                                time.first)
                                                            .inHours ==
                                                        0
                                                    ? "Updated at - ${DateFormat('hh:mm a').format(time.first.toLocal())}"
                                                    : "Updated at - ${today.difference(time.first.toLocal()).inHours.toString() + ' hours ago'}",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color:
                                                        kWhite.withOpacity(0.6),
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            )
                                          : SizedBox(),
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
                            // Spacer(),
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
            showModalBottomSheet(
              context: context,
              builder: (BuildContext bc) {
                return CustomAddElementBs(
                  onChanged: () {
                    setState(() {
                      Navigator.pop(context);
                      getNextMedicine();
                    });
                  },
                );
              },
            );
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
}
