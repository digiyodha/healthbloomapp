import 'package:flutter/material.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/model/request/get_mdecine_request.dart';
import 'package:health_bloom/model/response/get_medicine_response.dart';
import 'package:health_bloom/services/api/repository/auth_repository.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:health_bloom/view/medicine/add_medicine.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AboutMedicine extends StatefulWidget {
  final String id;
  const AboutMedicine({Key key, this.id}) : super(key: key);

  @override
  State<AboutMedicine> createState() => _AboutMedicineState();
}

class _AboutMedicineState extends State<AboutMedicine> {
  bool setAlarm = false;
  String remainderTime = 'Weekly';

  GetMedicineResponse _getMedicine;
  Future<GetMedicineResponse> getMedicine() async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    GetMedicineResponse _response =
        await adminAPI.getMedicineAPI(GetMedicineRequest(id: widget.id));

    return _getMedicine = _response;
  }

  @override
  void initState() {
    super.initState();
    getMedicine();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: TextBuilder(
            text: "About Medicine",
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  if (_getMedicine.data.patient != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddMedicine(
                          id: _getMedicine.data.id,
                          getMedicine: _getMedicine.data,
                          searchMedicine: null,
                          getNextMedicine: null,
                        ),
                      ),
                    ).whenComplete(() {
                      setState(() {
                        getMedicine();
                      });
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Patient not found'),
                    ));
                  }
                },
                icon: Icon(Icons.edit))
          ],
        ),
        backgroundColor: kMainColor,
        body: SafeArea(
          child: FutureBuilder<GetMedicineResponse>(
            future: getMedicine(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 50,left: 5,right: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: kWhite,
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.white,
                                      kWhite,
                                      kMainColorExtraLite.withOpacity(0.8)
                                    ],
                                    stops: [
                                      0.3,
                                      0.6,
                                      0.9
                                    ]
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 5,
                                      offset: Offset(0.0,2.0)
                                    )
                                  ]
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 40.0),
                                        TextBuilder(
                                          text: snapshot.data.data.description
                                              .toString(),
                                          height: 1.3,
                                          // textOverflow: TextOverflow.ellipsis,
                                          fontSize: 12,
                                          // maxLines: 6,
                                          color: kMainColor,
                                          fontWeight: FontWeight.w400,
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 6.0),
                                        Center(
                                          child: TextBuilder(
                                            text: snapshot
                                                    .data.data.medicineName ??
                                                '',
                                            fontSize: 24,
                                            fontWeight: FontWeight.w800,
                                            color: kMainColor,
                                          ),
                                        ),
                                        const SizedBox(height: 6.0),
                                        Center(
                                          child: TextBuilder(
                                            text:
                                                'Dosage : ${snapshot.data.data.dosage}mg',
                                            fontSize: 12,
                                            // maxLines: 6,
                                            color: kMainColor,
                                            fontWeight: FontWeight.w400,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        const SizedBox(height: 30.0),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            TextBuilder(
                                              text: "Dose",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: kMainColor,
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                TextBuilder(
                                                  fontSize: 14,
                                                  text: snapshot.data.data
                                                              .timeObject.length !=
                                                          1
                                                      ? '${snapshot.data.data.timeObject.length.toString()} times | '
                                                      : '${snapshot.data.data.timeObject.length.toString()} time | ',
                                                  color: kMainColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                TextBuilder(
                                                  text: snapshot
                                                      .data.data.timeObject
                                                      .map((e) =>
                                                          DateFormat('hh:mm a')
                                                              .format(e.startTime))
                                                      .toList()
                                                      .join(', ')
                                                      .toString()
                                                      .replaceAll('[]', ''),
                                                  color: kMainColor,
                                                  fontWeight: FontWeight.w500,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              width: 100,
                              child: Center(
                                child: Card(
                                  elevation: 3,
                                  clipBehavior: Clip.antiAlias,
                                  shadowColor: Color(0xffEDE8FB),
                                  color: Color(0xffF9F9FB),
                                  margin: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: ClipOval(
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xffEDE8FB),
                                            offset: Offset(15, 15),
                                            spreadRadius: 15,
                                            blurRadius: 20,
                                            blurStyle: BlurStyle.outer,
                                          ),
                                        ],
                                        color: Colors.white,
                                      ),
                                      child: Image.asset(
                                          'assets/images/drug1.png'),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 25.0),
                        Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextBuilder(
                                  text: 'Next Dose',
                                  fontSize: 12,
                                  color: kMainColor,
                                  fontWeight: FontWeight.w400,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 10.0),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.watch_later_outlined,
                                      color: kMainColor,
                                      size: 26,
                                    ),
                                    const SizedBox(width: 8.0),
                                    TextBuilder(
                                      text:
                                          '${DateFormat('hh:mm a').format(snapshot.data.data.startHour).toString()}',
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      color: kMainColor,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20.0),
                                Wrap(
                                  runSpacing: 5,
                                  children: [
                                    TextBuilder(
                                      text: 'Program:',
                                      fontSize: 15,
                                      color: kMainColor,
                                      fontWeight: FontWeight.w800,
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(width: 5,),
                                    TextBuilder(
                                      fontSize: 14,
                                      text: 'Total ${snapshot.data.data.duration ?? "-"} days'.toString(),
                                      color: kMainColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 5),
                                      width: 1,
                                      height: 16,
                                      color: kMainColor,
                                    ),
                                    TextBuilder(
                                      fontSize: 14,
                                      text: '${snapshot.data.data.durationLeft ?? "-"} days left'.toString(),
                                      color: kMainColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16.0),
                                Wrap(
                                  runSpacing: 5,
                                  children: [
                                    TextBuilder(
                                      text: 'Quantity:',
                                      fontSize: 15,
                                      color: kMainColor,
                                      fontWeight: FontWeight.w800,
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(width: 5,),
                                    TextBuilder(
                                      fontSize: 14,
                                      text: '${snapshot.data.data.totalTablets
                                          .toString()} Tablets',
                                      color: kMainColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 5),
                                      width: 1,
                                      height: 16,
                                      color: kMainColor,
                                    ),
                                    TextBuilder(
                                      fontSize: 14,
                                      text: '${snapshot.data.data.tabletsLeft.toString()} Tablets Left',
                                      color: kMainColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            },
          ),
        ));
  }
}
