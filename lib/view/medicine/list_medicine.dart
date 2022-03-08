import 'package:flutter/material.dart';
import 'package:health_bloom/model/request/search_mdecine_request.dart';
import 'package:health_bloom/model/response/search_medicne_response.dart';
import 'package:health_bloom/services/api/repository/auth_repository.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:health_bloom/utils/loading.dart';
import 'package:health_bloom/view/medicine/view_medicine.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ListMedicine extends StatefulWidget {
  const ListMedicine({Key key}) : super(key: key);

  @override
  State<ListMedicine> createState() => _ListMedicineState();
}

class _ListMedicineState extends State<ListMedicine> {
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
    });
  }

  @override
  void initState() {
    super.initState();
    searchMedicine();
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
        title: Text("Medicines"),
        centerTitle: true,
      ),
      body: Container(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 300,
                width: double.infinity,
                child: Image.asset(
                  "assets/images/medicines-list.jpg",
                  fit: BoxFit.cover,
                  color: Colors.black,
                  colorBlendMode: BlendMode.softLight,
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 300,
                width: double.infinity,
                color: kMainColor.withOpacity(0.3),
              ),
            ),
            Column(
              children: [
                SizedBox(height: 100),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        bottom: 0, left: 18, right: 18, top: 20),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: kMainColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16))),
                    child: _currentResponse != null
                        ? Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: GridView.builder(
                              itemCount: _currentResponse.data.length,
                              padding: EdgeInsets.only(bottom: 34),
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.75,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 16),
                              itemBuilder: (BuildContext context, int i) {
                                final medicine = _currentResponse.data[i];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ViewMedicine(
                                          medicne: medicine,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Color(0xffAF8EFF),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          medicine.medicineName ?? '',
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
                                                "assets/images/drug2.png"),
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          '${DateFormat('hh:mm a').format(medicine.time.first).toString()}' ??
                                              '',
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: kWhite,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          "Dosage - ${medicine.dosage.toString()} mg" ??
                                              '',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: kWhite.withOpacity(0.6),
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            child: LoadingWidget(
                              color: Colors.white,
                            ),
                          ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
