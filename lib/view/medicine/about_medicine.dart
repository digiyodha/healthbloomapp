import 'package:flutter/material.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/model/request/get_mdecine_request.dart';
import 'package:health_bloom/model/response/get_medicine_response.dart';
import 'package:health_bloom/services/api/repository/auth_repository.dart';
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
                },
                icon: Icon(Icons.edit))
          ],
        ),
        backgroundColor: Color(0xffA283F9),
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
                            Container(
                              height: 375,
                              width: double.infinity,
                            ),
                            SizedBox(
                              height: 320,
                              width: double.infinity,
                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 50.0),
                                      Center(
                                        child: TextBuilder(
                                          text:
                                              snapshot.data.data.medicineName ??
                                                  '',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Center(
                                        child: TextBuilder(
                                          text:
                                              'Dosage : ${snapshot.data.data.dosage}mg',
                                          fontSize: 14,
                                          color: Color(0xff5D5D5D),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      TextBuilder(
                                        text: snapshot.data.data.description
                                            .toString(),
                                        height: 1.3,
                                        textOverflow: TextOverflow.ellipsis,
                                        fontSize: 14,
                                        maxLines: 6,
                                        color: Color(0xff5D5D5D),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      const SizedBox(height: 25.0),
                                      Row(
                                        children: [
                                          TextBuilder(
                                            fontSize: 14,
                                            text: snapshot.data.data.timeObject
                                                        .length !=
                                                    1
                                                ? '${snapshot.data.data.timeObject.length.toString()} times | '
                                                : '${snapshot.data.data.timeObject.length.toString()} time | ',
                                            color: Color(0xff5D5D5D),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          TextBuilder(
                                            text: snapshot.data.data.timeObject
                                                .map((e) =>
                                                    DateFormat('hh:mm a')
                                                        .format(e.startTime))
                                                .toList()
                                                .join(', ')
                                                .toString()
                                                .replaceAll('[]', ''),
                                            color: Color(0xff5D5D5D),
                                            fontWeight: FontWeight.w500,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              width: 100,
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
                                    child:
                                        Image.asset('assets/images/drug1.png'),
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
                                  color: Color(0xff5D5D5D),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                                const SizedBox(height: 10.0),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.watch_later_outlined,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(width: 5.0),
                                    TextBuilder(
                                      text:
                                          '${DateFormat('hh:mm a').format(snapshot.data.data.startHour).toString()}',
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                Row(
                                  children: [
                                    TextBuilder(
                                      fontSize: 14,
                                      text: 'Program  |',
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    const SizedBox(width: 5.0),
                                    TextBuilder(
                                      fontSize: 14,
                                      text: 'Total *',
                                      color: Color(0xff5D5D5D),
                                      fontWeight: FontWeight.w500,
                                    )
                                  ],
                                ),
                                const SizedBox(height: 50.0),
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
