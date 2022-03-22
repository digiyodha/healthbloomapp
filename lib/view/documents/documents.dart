import 'package:flutter/material.dart';
import 'package:health_bloom/components/custom_tab.dart';
import 'package:health_bloom/components/medical_bills_card.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/model/request/get_documents_request.dart';
import 'package:health_bloom/model/request/request.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:health_bloom/utils/loading.dart';
import 'package:health_bloom/view/documents/view_bill_documents.dart';
import 'package:health_bloom/view/documents/view_prescription_documents.dart';
import 'package:health_bloom/view/documents/view_report_documents.dart';

import 'package:health_bloom/view/prescription/add_prescription.dart';
import 'package:health_bloom/view/report/add_report.dart';
import 'package:provider/provider.dart';

import '../../model/response/response.dart';
import '../../services/api/repository/auth_repository.dart';
import '../../utils/drawer/custom_drawer.dart';
import '../../utils/text_field/custom_text_field.dart';
import '../bill/add_bill.dart';
import '../homepage/home_page.dart';

class Documents extends StatefulWidget {
  const Documents({Key key}) : super(key: key);

  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  TextEditingController _fromDate = TextEditingController();
  TextEditingController _toDate = TextEditingController();
  TextEditingController search = TextEditingController();
  DateTime selectedStartDate;
  DateTime selectedEndDate;
  int currentIndex = 0;
  bool _loading = false;
  GetAllDocumentsResponse _currentResponse;

  Future<void> _startDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedStartDate) {
      setState(() {
        selectedStartDate = picked;
      });
      _fromDate.text =
          "${selectedStartDate.day}-${selectedStartDate.month}-${selectedStartDate.year}";
      getDocuments();
    }
  }

  Future<void> _endDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedStartDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedEndDate) {
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
      getDocuments();
    }
  }

  List<GetAllDocumentsResponseBill> foundBill = [];
  List<GetAllDocumentsResponseBill> foundReport = [];
  List<GetAllDocumentsResponsePrescription> foundPrescription = [];
  Future getDocuments() async {
    foundBill.clear();
    foundReport.clear();
    foundPrescription.clear();
    setState(() {
      _currentResponse = null;
    });
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    GetAllDocumentsResponse _response = await adminAPI.getDocumentsAPI(
        GetDocumentsRequest(
            fromDate: selectedStartDate ?? null,
            toDate: selectedEndDate ?? null));
    _response.data.bill.forEach((element) {
      foundBill.add(element);
    });
    _response.data.report.forEach((element) {
      foundReport.add(element);
    });
    _response.data.prescription.forEach((element) {
      foundPrescription.add(element);
    });
    setState(() {
      _currentResponse = _response;
    });
  }

  @override
  void initState() {
    super.initState();
    getDocuments();
  }

  onSearch(String search) {
    print('Search Query $search');
    setState(() {
      foundBill = _currentResponse.data.bill
          .where((e) =>
              e.name.toLowerCase().contains(search.toLowerCase()) ||
              e.patient.name.toLowerCase().contains(search.toLowerCase()))
          .toList();

      foundReport = _currentResponse.data.report
          .where((e) =>
              e.name.toLowerCase().contains(search.toLowerCase()) ||
              e.patient.name.toLowerCase().contains(search.toLowerCase()))
          .toList();

      foundPrescription = _currentResponse.data.prescription
          .where((e) =>
              e.patient.name.toString().toLowerCase().contains(search.toLowerCase()) ||
              e.doctorName.toLowerCase().contains(search.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
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
          selected: 3,
        ),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
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
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
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
                top: 180,
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
                        onChanged: (value) => onSearch(value),
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
                      const SizedBox(height: 24.0),
                      Container(
                        color: Colors.white,
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTab(
                                onTap: () {
                                  setState(() {
                                    currentIndex = 0;
                                  });
                                },
                                icon: 'assets/icons/bill.png',
                                title: 'Bills',
                                isSelected: currentIndex == 0,
                              ),
                            ),
                            Expanded(
                              child: CustomTab(
                                onTap: () {
                                  setState(() {
                                    currentIndex = 1;
                                  });
                                },
                                icon: 'assets/icons/business-report.png',
                                title: 'Reports',
                                isSelected: currentIndex == 1,
                              ),
                            ),
                            Expanded(
                              child: CustomTab(
                                onTap: () {
                                  setState(() {
                                    currentIndex = 2;
                                  });
                                },
                                icon: 'assets/icons/medical-prescription.png',
                                title: 'Prescriptions',
                                isSelected: currentIndex == 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: _currentResponse != null
                            ? getList()
                            : LoadingWidget(),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              if (_loading) LoadingWidget()
            ],
          ),
        ),
      ),
    );
  }

  Widget getList() {
    print("Response ${_currentResponse.toJson()}");

    if (currentIndex == 0)
      return foundBill.isNotEmpty
          ? ListView.builder(
              padding: EdgeInsets.only(top: 16, bottom: 20),
              itemCount: foundBill.length,
              physics: ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return MedicalBillsCard(
                  nameOfBill: foundBill[index].name,
                  nameOfPatients: foundBill[index].patient != null
                      ? foundBill[index].patient.name
                      : "-",
                  dateOfBill: foundBill[index].patient != null
                      ? foundBill[index].date
                      : null,
                  avatar: foundBill[index].patient != null
                      ? foundBill[index].patient.avatar
                      : '',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewBillDocuments(
                          bill: foundBill[index],
                        ),
                      ),
                    );
                  },
                  edit: () {
                    if (foundBill[index].patient != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddBill(
                            bill: foundBill[index],
                          ),
                        ),
                      ).whenComplete(() => setState(() {
                            getDocuments();
                          }));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Patient not found'),
                      ));
                    }
                  },
                  delete: () async {
                    setState(() {
                      _loading = true;
                    });
                    final adminAPI =
                        Provider.of<NetworkRepository>(context, listen: false);
                    DeleteBillResponse _response = await adminAPI.deleteBillAPI(
                        DeleteDocumentRequest(id: foundBill[index].id));
                    if (_response.success) {
                      setState(() {
                        _loading = false;
                      });

                      getDocuments();
                    }
                  },
                );
              },
            )
          : Center(
              child: TextBuilder(text: 'no results found!'),
            );

    if (currentIndex == 1)
      return foundReport.isNotEmpty
          ? ListView.builder(
              padding: EdgeInsets.only(top: 16, bottom: 20),
              itemCount: foundReport.length,
              physics: ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return MedicalBillsCard(
                  nameOfBill: foundReport[index].name,
                  nameOfPatients: foundReport[index].patient != null
                      ? foundReport[index].patient.name
                      : "-",
                  dateOfBill: foundReport[index].patient != null
                      ? foundReport[index].date
                      : null,
                  avatar: foundReport[index].patient != null
                      ? foundReport[index].patient.avatar
                      : '',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewReportDocuments(
                          report: foundReport[index],
                        ),
                      ),
                    );
                  },
                  edit: () {
                    if (foundReport[index].patient != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddReport(report: foundReport[index]),
                        ),
                      ).whenComplete(() => setState(() {
                            getDocuments();
                          }));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Patient not found'),
                      ));
                    }
                  },
                  delete: () async {
                    setState(() {
                      _loading = true;
                    });
                    final adminAPI =
                        Provider.of<NetworkRepository>(context, listen: false);
                    DeleteReportResponse _response =
                        await adminAPI.deleteReportAPI(
                            DeleteDocumentRequest(id: foundReport[index].id));
                    if (_response.success) {
                      setState(() {
                        _loading = false;
                      });

                      getDocuments();
                    }
                  },
                );
              },
            )
          : Center(
              child: TextBuilder(text: 'no results found!'),
            );
    if (currentIndex == 2)
      return foundPrescription.isNotEmpty
          ? ListView.builder(
              padding: EdgeInsets.only(top: 16, bottom: 20),
              itemCount: foundPrescription.length,
              physics: ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return MedicalBillsCard(
                  nameOfBill: 'Dr. ' + foundPrescription[index].doctorName,
                  nameOfPatients: foundPrescription[index].patient != null
                      ? foundPrescription[index].patient.name
                      : "-",
                  dateOfBill: foundPrescription[index].patient != null
                      ? foundPrescription[index].consultationDate
                      : null,
                  avatar: foundPrescription[index].patient != null
                      ? foundPrescription[index].patient.avatar
                      : '',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewPrescriptionDocuments(
                          prescriprion: foundPrescription[index],
                        ),
                      ),
                    );
                  },
                  edit: () {
                    if (foundPrescription[index].patient != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddPrescription(
                              prescription: foundPrescription[index]),
                        ),
                      ).whenComplete(() => setState(() {
                            getDocuments();
                          }));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Patient not found'),
                      ));
                    }
                  },
                  delete: () async {
                    setState(() {
                      _loading = true;
                    });
                    final adminAPI =
                        Provider.of<NetworkRepository>(context, listen: false);
                    DeletePrescriptionResponse _response = await adminAPI
                        .deletePrescriptionAPI(DeleteDocumentRequest(
                            id: foundPrescription[index].id));
                    if (_response.success) {
                      setState(() {
                        _loading = false;
                      });
                      getDocuments();
                    }
                  },
                );
              },
            )
          : Center(
              child: TextBuilder(text: 'no results found!'),
            );
    return Container();
  }
}
