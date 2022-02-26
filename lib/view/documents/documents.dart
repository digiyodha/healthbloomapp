import 'package:flutter/material.dart';
import 'package:health_bloom/components/custom_tab.dart';
import 'package:health_bloom/components/medical_bills_card.dart';
import 'package:health_bloom/model/request/get_documents_request.dart';
import 'package:health_bloom/model/response/get_docuemnets_respnse.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:health_bloom/utils/loading.dart';
import 'package:health_bloom/view/bill/edit_bill.dart';
import 'package:provider/provider.dart';

import '../../services/api/repository/auth_repository.dart';

import '../../utils/text_field/custom_text_field.dart';

class Documents extends StatefulWidget {
  const Documents({Key key}) : super(key: key);

  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  TextEditingController _fromDate = TextEditingController();
  TextEditingController _toDate = TextEditingController();
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  int currentIndex = 0;
  bool _loading = false;

  Future<void> _startDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedStartDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedStartDate) {
      setState(() {
        selectedStartDate = picked;
      });
      _fromDate.text =
          "${selectedStartDate.day}/${selectedStartDate.month}/${selectedStartDate.year}";
    }
  }

  Future<void> _endDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedEndDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedEndDate) {
      setState(() {
        selectedEndDate = picked;
      });
      _toDate.text =
          "${selectedEndDate.day}/${selectedEndDate.month}/${selectedEndDate.year}";
    }
  }

  Future<GetDocumentsResponse> getDocuments() async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    GetDocumentsResponse _response = await adminAPI.getDocumentsAPI(
        GetDocumentsRequest(
            fromDate: selectedStartDate, toDate: selectedEndDate));
    return _response;
  }

  @override
  void initState() {
    super.initState();
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
              child: SingleChildScrollView(
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
                    FutureBuilder<GetDocumentsResponse>(
                      future: getDocuments(),
                      builder: (context, data) {
                        if (data.hasData) {
                          return ListView.builder(
                            itemCount: data.data.data.bill.length,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              print('Bill count ' +
                                  data.data.data.bill.length.toString());
                              return MedicalBillsCard(
                                nameOfBill: data.data.data.bill[index].name,
                                nameOfPatients: 'Patient Name',
                                dateOfBill: data.data.data.bill[index].date,
                                onTap: () {},
                                edit: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditBill(),
                                    ),
                                  );
                                },
                                delete: () {},
                              );
                            },
                          );
                        } else if (data.hasError) {
                          return Text("${data.error}");
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
          if (_loading) LoadingWidget()
        ],
      ),
    );
  }
}
