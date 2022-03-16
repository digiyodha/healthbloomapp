import 'package:flutter/material.dart';
import 'package:health_bloom/components/medicine_card.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/model/request/delete_mdecine_request.dart';
import 'package:health_bloom/model/request/search_mdecine_request.dart';
import 'package:health_bloom/model/response/delete_medicine_response.dart';
import 'package:health_bloom/model/response/search_medicne_response.dart';
import 'package:health_bloom/services/api/repository/auth_repository.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:health_bloom/utils/loading.dart';
import 'package:health_bloom/view/medicine/add_medicine.dart';
import 'package:health_bloom/view/medicine/list_about_medicine.dart';
import 'package:provider/provider.dart';

class ListMedicine extends StatefulWidget {
  const ListMedicine({Key key}) : super(key: key);

  @override
  State<ListMedicine> createState() => _ListMedicineState();
}

class _ListMedicineState extends State<ListMedicine> {
  bool _isLoading = false;
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

  Future<DeleteMedicineResponse> deleteMedicine(
      DeleteMedicineRequest request) async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    DeleteMedicineResponse _response =
        await adminAPI.deleteMedicineAPI(request);
    return _response;
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
        title: TextBuilder(
          text: "Medicines",
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
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
                      color: Colors.black45,
                      colorBlendMode: BlendMode.hardLight,
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
                        width: double.infinity,
                        margin: EdgeInsets.only(
                            bottom: 0, left: 18, right: 18, top: 20),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: kMainColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16))),
                        child: _currentResponse == null
                            ? Center(
                                child: CircularProgressIndicator(
                                    color: Colors.white),
                              )
                            : _currentResponse.data.isNotEmpty
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
                                              childAspectRatio: 0.65,
                                              crossAxisSpacing: 16,
                                              mainAxisSpacing: 16),
                                      itemBuilder:
                                          (BuildContext context, int i) {
                                        final medicine =
                                            _currentResponse.data[i];
                                        return MedicineCard(
                                          onTap: () {
                                            if (medicine.patient != null)
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ListAboutMedicine(
                                                    id: medicine.id,
                                                  ),
                                                ),
                                              ).whenComplete(() {
                                                setState(() {
                                                  searchMedicine();
                                                });
                                              });
                                          },
                                          medicineName:
                                              medicine.medicineName ?? '',
                                          time: medicine.startHour,
                                          dosages: medicine.dosage ?? '',
                                          height: double.infinity,
                                          width: double.infinity,
                                          padding: EdgeInsets.zero,
                                          hideIcon: true,
                                          edit: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AddMedicine(
                                                  id: medicine.id,
                                                  getNextMedicine: null,
                                                  getMedicine: null,
                                                  searchMedicine: medicine,
                                                ),
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
                                                return AlertDialog(
                                                  title: Text(
                                                      'Delete ${medicine.medicineName}'),
                                                  content:
                                                      Text('Are you sure!'),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: TextBuilder(
                                                            text: 'No')),
                                                    MaterialButton(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6)),
                                                      color: Color(0xffFF9B91),
                                                      onPressed: () async {
                                                        DeleteMedicineRequest
                                                            _request =
                                                            DeleteMedicineRequest(
                                                                id: medicine
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
                                                            content: Text(
                                                                'deleted.'),
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
                                                  searchMedicine();
                                                }));
                                          },
                                        );
                                      },
                                    ),
                                  )
                                : Container(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.center,
                                    child: Center(
                                      child: TextBuilder(
                                        text: 'No Medicine Found',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          if (_isLoading) LoadingWidget(color: Colors.white)
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AddMedicine();
            })).whenComplete(() => setState(() {
                  searchMedicine();
                }));
          },
          backgroundColor: Color(0xffFF9B91),
          child: Center(
            child: Icon(
              Icons.add,
              color: kWhite,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
