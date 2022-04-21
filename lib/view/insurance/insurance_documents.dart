import 'dart:io';
import 'dart:typed_data';

import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:health_bloom/model/request/request.dart';
import 'package:health_bloom/view/insurance/widgets/insaurance_doc_card.dart';
import 'package:provider/provider.dart';

import '../../components/textbuilder.dart';
import '../../model/response/response.dart';
import '../../model/response/search_insurance_response.dart';
import '../../services/api/repository/auth_repository.dart';
import '../../utils/colors.dart';
import '../../utils/loading.dart';
import '../../utils/text_field/custom_text_field.dart';

class InsuranceDocuments extends StatefulWidget {
  final SearchInsuranceResponseDatum insurance;
  final String userid;
  final DateTime dob;
  const InsuranceDocuments({Key key, this.insurance, this.userid, this.dob})
      : super(key: key);

  @override
  State<InsuranceDocuments> createState() => _InsuranceDocumentsState();
}

class _InsuranceDocumentsState extends State<InsuranceDocuments> {
  TextEditingController _fromDate = TextEditingController();
  TextEditingController _toDate = TextEditingController();

  TextEditingController search = TextEditingController();
  DateTime selectedDob;
  DateTime selectedStartDate;
  DateTime selectedEndDate;
  bool _loading = false;
  GetDocumentsFamilyResponse _currentResponse;

  List<GetDocumentsFamilyResponseCommonObject> _sortedDocs = [];
  List<String> _shareIds = [];
  int currentIndex;
  // Future<void> _dobPicker(BuildContext context) async {
  //   final DateTime picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDob ?? DateTime.now(),
  //       firstDate: DateTime(1950, 8),
  //       lastDate: DateTime(2200));
  //   if (picked != null) {
  //     setState(() {
  //       selectedDob = picked;
  //     });
  //     search.text =
  //         "${selectedDob.day}-${selectedDob.month}-${selectedDob.year}";
  //     // getDocumentsFamily();
  //   }
  // }

  Future<void> _startDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedStartDate ?? DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedStartDate = picked;
      });
      _fromDate.text =
          "${selectedStartDate.day}-${selectedStartDate.month}-${selectedStartDate.year}";
      getDocumentsFamily();
    }
  }

  Future<void> _endDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedStartDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null) {
      setState(() {
        selectedEndDate = picked;
      });
      if (selectedEndDate.isBefore(selectedStartDate)) {
        selectedEndDate = null;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('End date should be greater than start date'),
        ));
      }
      _toDate.text =
          "${selectedEndDate.day}-${selectedEndDate.month}-${selectedEndDate.year}";
      getDocumentsFamily();
    }
  }

  bool slectedValue = false;
  Future getDocumentsFamily() async {
    setState(() {
      _currentResponse = null;
      _sortedDocs.clear();
      _shareIds.clear();
    });
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    GetDocumentsFamilyRequest _request = GetDocumentsFamilyRequest(
        fromDate: selectedStartDate ?? null,
        toDate: selectedEndDate ?? null,
        patient: widget.userid);
    print(_request.toJson().toString());
    GetDocumentsFamilyResponse _response =
        await adminAPI.getDocumentsFamilyAPI(_request);

    _currentResponse = _response;
    _currentResponse.data.report.forEach((element) {
      _sortedDocs.add(GetDocumentsFamilyResponseCommonObject(
          id: element.id,
          name: element.name,
          date: element.date,
          description: element.description,
          images: element.reportImage,
          patient: element.patient,
          userId: element.userId,
          dateOfBirth: widget.dob,
          type: "Report"));
    });

    _currentResponse.data.prescription.forEach((element) {
      _sortedDocs.add(GetDocumentsFamilyResponseCommonObject(
          id: element.id,
          name: element.doctorName,
          date: element.consultationDate,
          description: element.doctorAdvice,
          images: element.prescriptionImage,
          patient: element.patient,
          userId: element.userId,
          clinicName: element.clinicName,
          userAilment: element.userAilment,
          dateOfBirth: widget.dob,
          type: "Prescription"));
    });

    _currentResponse.data.bill.forEach((element) {
      _sortedDocs.add(GetDocumentsFamilyResponseCommonObject(
          id: element.id,
          name: element.name,
          date: element.date,
          description: element.description,
          images: element.billImage,
          patient: element.patient,
          userId: element.userId,
          amount: element.amount,
          dateOfBirth: widget.dob,
          type: "Bill"));
    });

    await Future.delayed(Duration(seconds: 1));
    // _sortedDocs.forEach((element) {
    //   print('Dosument List Response ${element.dateOfBirth}');
    // });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getDocumentsFamily();
    _shareIds.clear();
  }

  // _runFilter(String enteredKeyword) {
  //   print('Search Query $enteredKeyword');
  //   List<GetDocumentsFamilyResponseCommonObject> results = [];
  //   if (enteredKeyword.isEmpty) {
  //     // if the search field is empty or only contains white-space, we'll display all users
  //     results = _sortedDocs;
  //   } else {
  //     results = _sortedDocs
  //         .where((e) => e.patient.name
  //             .toString()
  //             .toLowerCase()
  //             .contains(enteredKeyword.toString().toLowerCase()))
  //         .toList();
  //     // we use the toLowerCase() method to make it case-insensitive
  //   }

  //   // Refresh the UI
  //   setState(() {
  //     _sortedDocs = results;
  //   });
  // }

  // onSearch(String search) {
  //   print('Search Query $search');
  //   setState(() {
  //     _sortedDocs = _sortedDocs
  //         .where((e) => e.patient.name
  //             .toString()
  //             .toLowerCase()
  //             .contains(search.toString().toLowerCase()))
  //         .toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          iconTheme: IconThemeData(color: kWhite),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: TextBuilder(
            text: "Documents",
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
          centerTitle: true,
        ),
        backgroundColor: kWhite,
        body: _currentResponse != null
            ? Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 300,
                      width: double.infinity,
                      child: Image.asset(
                        "assets/images/medical_bill.jpg",
                        fit: BoxFit.cover,
                        color: Colors.black45,
                        colorBlendMode: BlendMode.hardLight,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    top: 100,
                    child: Container(
                      padding: EdgeInsets.only(top: 40, left: 24, right: 24),
                      decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30))),
                      child: Column(
                        children: [
                          CustomTextField(
                            maxLines: 1,
                            controller: search,
                            label: "Search",
                            textInputType: TextInputType.name,
                            onChanged: (value) {
                              setState(() {});
                            },
                            // sufix: InkWell(
                            //   onTap: () {
                            //     _dobPicker(context);
                            //   },
                            //   child: Icon(Icons.today),
                            // ),
                            // onChanged: (val) => _runFilter(val),
                            // onChanged: (value) => onSearch(value),
                            onTap: () {},
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  readOnly: true,
                                  maxLines: 1,
                                  controller: _fromDate,
                                  label: "Start Date",
                                  textInputType: TextInputType.text,
                                  onChanged: (val) {},
                                  onTap: () {
                                    _startDate(context);
                                  },
                                ),
                              ),
                              const SizedBox(width: 20.0),
                              Expanded(
                                child: CustomTextField(
                                  readOnly: true,
                                  maxLines: 1,
                                  controller: _toDate,
                                  label: "End Date",
                                  textInputType: TextInputType.text,
                                  onChanged: (val) {},
                                  onTap: () {
                                    _endDate(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          _sortedDocs.isNotEmpty
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        slectedValue = !slectedValue;
                                        print(
                                            '_shareIds ${_shareIds.toList()}');
                                        setState(() {
                                          if (slectedValue == true) {
                                            _sortedDocs.forEach((e) {
                                              _shareIds.add(e.id);
                                              print(
                                                  '_shareIds ${_shareIds.toList()}');
                                            });
                                          } else {
                                            _shareIds.clear();
                                          }
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextBuilder(
                                          text: _shareIds.isEmpty
                                              ? 'Select All'
                                              : 'Deselect All',
                                          fontSize: 16,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),

                          Expanded(
                            child: _sortedDocs.isNotEmpty
                                ? ListView.builder(
                                    padding: EdgeInsets.all(0),
                                    itemCount: _sortedDocs.length,
                                    itemBuilder: (context, index) {
                                      print(
                                          '_sortedDocs.length ${_sortedDocs.length}');

                                      if ('${_sortedDocs[index].name}'
                                              .toString()
                                              .toLowerCase()
                                              .contains(search.text
                                                  .toString()
                                                  .toLowerCase()) ||
                                          '${_sortedDocs[index].patient.name}'
                                              .toString()
                                              .toLowerCase()
                                              .contains(search.text
                                                  .toString()
                                                  .toLowerCase()) ||
                                          '${_sortedDocs[index].date.day}-${_sortedDocs[index].date.month}-${_sortedDocs[index].date.year}'
                                              .toString()
                                              .toLowerCase()
                                              .contains(search.text
                                                  .toString()
                                                  .toLowerCase())) {
                                        return InsuranceDocCard(
                                          nameOfBill:
                                              "${_sortedDocs[index].type}: " +
                                                  _sortedDocs[index].name,
                                          nameOfPatients:
                                              _sortedDocs[index].patient.name,
                                          dateOfBill: _sortedDocs[index].date,
                                          avatar: _sortedDocs[index]
                                                  .patient
                                                  .avatar ??
                                              '',
                                          // // selected: slectedValue,
                                          // value: slectedValue,
                                          value: _shareIds
                                              .contains(_sortedDocs[index].id),
                                          onTap: (bool v) {
                                            print(
                                                '_shareIds ${_shareIds.toList()}');
                                            slectedValue = v;
                                            setState(
                                              () {
                                                if (slectedValue == true) {
                                                  _shareIds.add(
                                                      _sortedDocs[index].id);
                                                } else {
                                                  _shareIds.remove(
                                                      _sortedDocs[index].id);
                                                }
                                              },
                                            );
                                            slectedValue = v;
                                          },
                                          edit: () {},
                                          delete: () {},
                                          showIcons: false,
                                        );
                                      }

                                      return Container();
                                    },
                                  )
                                : Center(
                                    child: TextBuilder(
                                        text: 'No documents found!'),
                                  ),
                          ),
                          // Expanded(
                          //   child: _currentResponse != null
                          //       ? getList()
                          //       : LoadingWidget(),
                          // ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                  if (_loading)
                    LoadingWidget(
                      color: kGrey7,
                    )
                ],
              )
            : LoadingWidget(),
        floatingActionButton: _shareIds.isNotEmpty
            ? FloatingActionButton(
                backgroundColor: kMainColor,
                child: Icon(
                  Icons.share,
                  color: kWhite,
                  size: 26,
                ),
                onPressed: () async {
                  setState(() {
                    _loading = true;
                  });
                  String _temp = "";
                  Map<String, List<int>> _files = {};

                  for (String element in _shareIds) {
                    List<GetDocumentsFamilyResponseCommonObject> _tempList =
                        _sortedDocs.where((e) => element == e.id).toList();

                    _temp = _temp + _tempList[0].name;
                    _temp = _temp + "\n";
                    _temp = _temp + _tempList[0].patient.name;
                    _temp = _temp + "\n";
                    _temp = _temp + _tempList[0].description;
                    _temp = _temp + "\n";
                    _temp = _temp + "\n";

                    for (var element in _tempList[0].images) {
                      var request = await HttpClient()
                          .getUrl(Uri.parse(element.assetUrl));
                      var response = await request.close();
                      Uint8List bytes =
                          await consolidateHttpClientResponseBytes(response);

                      _files[element.assetName] = bytes;
                    }
                  }

                  if (_files.isNotEmpty) {
                    await Share.files('Files', _files, '*/*', text: _temp);
                  } else {
                    Share.text('Files', _temp, 'text/plain');
                  }

                  setState(() {
                    _loading = false;
                  });
                },
              )
            : null,
      ),
    );
  }

  Widget getList() {
    return _sortedDocs.isNotEmpty
        ? ListView.builder(
            padding: EdgeInsets.all(0),
            itemCount: _sortedDocs.length,
            itemBuilder: (context, index) {
              print('_sortedDocs.length ${_sortedDocs.length}');

              return InsuranceDocCard(
                nameOfBill:
                    "${_sortedDocs[index].type}: " + _sortedDocs[index].name,
                nameOfPatients: _sortedDocs[index].patient.name,
                dateOfBill: _sortedDocs[index].date,
                avatar: _sortedDocs[index].patient.avatar ?? '',
                // // selected: slectedValue,
                // value: slectedValue,
                value: _shareIds.contains(_sortedDocs[index].id),
                onTap: (bool v) {
                  print('_shareIds ${_shareIds.toList()}');
                  slectedValue = v;
                  setState(
                    () {
                      if (slectedValue == true) {
                        _shareIds.add(_sortedDocs[index].id);
                      } else {
                        _shareIds.remove(_sortedDocs[index].id);
                      }
                    },
                  );
                  slectedValue = v;
                },
                edit: () {},
                delete: () {},
                showIcons: false,
              );
            },
          )
        : Center(
            child: TextBuilder(text: 'No documents found!'),
          );
  }
}

class ShareFilesTemp {
  String name;
  Uint8List file;
  ShareFilesTemp({this.name, this.file});
}
