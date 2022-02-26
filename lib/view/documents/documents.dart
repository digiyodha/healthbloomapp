import 'package:flutter/material.dart';
import 'package:health_bloom/components/custom_tab.dart';
import 'package:health_bloom/components/medical_bills_card.dart';
import 'package:health_bloom/model/request/get_documents_request.dart';
import 'package:health_bloom/model/request/request.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:health_bloom/utils/loading.dart';
import 'package:health_bloom/view/bill/edit_bill.dart';
import 'package:health_bloom/view/prescription/add_prescription.dart';
import 'package:health_bloom/view/report/add_report.dart';
import 'package:provider/provider.dart';

import '../../model/response/response.dart';
import '../../services/api/repository/auth_repository.dart';
import '../../utils/text_field/custom_text_field.dart';
import '../bill/add_bill.dart';

class Documents extends StatefulWidget {
  const Documents({Key key}) : super(key: key);

  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  TextEditingController _fromDate = TextEditingController();
  TextEditingController _toDate = TextEditingController();
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
          "${selectedStartDate.day}/${selectedStartDate.month}/${selectedStartDate.year}";
      getDocuments();
    }
  }

  Future<void> _endDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedEndDate) {
      setState(() {
        selectedEndDate = picked;
      });
      _toDate.text =
          "${selectedEndDate.day}/${selectedEndDate.month}/${selectedEndDate.year}";
      getDocuments();
    }
  }

  Future getDocuments() async {
    setState(() {
      _currentResponse = null;
    });
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    GetAllDocumentsResponse _response = await adminAPI.getDocumentsAPI(
        GetDocumentsRequest(
            fromDate: selectedStartDate ?? null, toDate: selectedEndDate ?? null));
    setState(() {
      _currentResponse = _response;
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getDocuments();
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
        title: Text("Medical Bills"),
        centerTitle: true,
      ),
      backgroundColor: kWhite,
      body: Stack(
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
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          readOnly: true,
                          maxLines: 1,
                          controller: _fromDate,
                          label: "Start Date",
                          textInputType: TextInputType.text,
                          onChanged: () {},
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
                          onChanged: () {},
                          onTap: () {
                            _endDate(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
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
                    child: _currentResponse != null ? getList() : LoadingWidget(),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
          if (_loading) LoadingWidget()
        ],
      ),
    );
  }

  Widget getList(){
    if(currentIndex == 0)
      return ListView.builder(
        padding: EdgeInsets.only(top: 16,bottom: 20),
        itemCount: _currentResponse.data.bill.length,
        physics: ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return MedicalBillsCard(
            nameOfBill: _currentResponse.data.bill[index].name,
            nameOfPatients: _currentResponse.data.bill[index].patient != null ? _currentResponse.data.bill[index].patient.name : "-",
            dateOfBill: _currentResponse.data.bill[index].date,
            onTap: () {},
            edit: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBill(
                    bill: _currentResponse.data.bill[index],
                  ),
                ),
              );
            },
            delete: () async{
              setState(() {
                _loading = true;
              });
              final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
              DeleteBillResponse _response = await adminAPI.deleteBillAPI(DeleteDocumentRequest(id: _currentResponse.data.bill[index].id));
              if(_response.success){
                getDocuments();
              }
            },
          );
        },
      );
    if(currentIndex == 1)
      return ListView.builder(
        padding: EdgeInsets.only(top: 16,bottom: 20),
        itemCount: _currentResponse.data.report.length,
        physics: ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return MedicalBillsCard(
            nameOfBill: _currentResponse.data.report[index].name,
            nameOfPatients: _currentResponse.data.report[index].patient != null ? _currentResponse.data.report[index].patient.name : "-",
            dateOfBill: _currentResponse.data.report[index].date,
            onTap: () {},
            edit: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddReport(
                    report : _currentResponse.data.report[index]
                  ),
                ),
              );
            },
            delete: () async{
              setState(() {
                _loading = true;
              });
              final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
              DeleteReportResponse _response = await adminAPI.deleteReportAPI(DeleteDocumentRequest(id: _currentResponse.data.report[index].id));
              if(_response.success){
                getDocuments();
              }
            },
          );
        },
      );
    if(currentIndex == 2)
      return ListView.builder(
        padding: EdgeInsets.only(top: 16,bottom: 20),
        itemCount: _currentResponse.data.prescription.length,
        physics: ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return MedicalBillsCard(
            nameOfBill: _currentResponse.data.prescription[index].doctorName,
            nameOfPatients: _currentResponse.data.prescription[index].patient != null ? _currentResponse.data.prescription[index].patient.name : "-",
            dateOfBill: _currentResponse.data.prescription[index].consultationDate,
            onTap: () {},
            edit: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPrescription(
                    prescription : _currentResponse.data.prescription[index]
                  ),
                ),
              );
            },
            delete: () async{
              setState(() {
                _loading = true;
              });
              final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
              DeletePrescriptionResponse _response = await adminAPI.deletePrescriptionAPI(DeleteDocumentRequest(id: _currentResponse.data.prescription[index].id));
              if(_response.success){
                getDocuments();
              }
            },
          );
        },
      );
    return Container();
  }
}
