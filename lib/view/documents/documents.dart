import 'package:flutter/material.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/model/request/get_documents_request.dart';
import 'package:health_bloom/model/response/get_docuemnets_respnse.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:health_bloom/utils/loading.dart';
import 'package:provider/provider.dart';
import '../../components/custom_contained_button.dart';
import '../../model/response/get_all_member_response.dart';
import '../../services/api/repository/auth_repository.dart';
// ignore: unused_import
import '../../utils/drop_down/custom_dropdown.dart';
import '../../utils/text_field/custom_text_field.dart';

class Documents extends StatefulWidget {
  const Documents({Key key}) : super(key: key);

  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  TextEditingController _date = TextEditingController();

  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();

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
      _date.text =
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
      _date.text =
          "${selectedEndDate.day}/${selectedEndDate.month}/${selectedEndDate.year}";
    }
  }

  Future<GetDocumentsResponse> getDocuments(GetDocumentsRequest request) async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    GetDocumentsResponse _response = await adminAPI.getDocumentsAPI(request);
    return _response;
  }

  Future<GetAllMemberResponse> getAllmember() async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    GetAllMemberResponse _response = await adminAPI.getAllMemberAPI();
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
                    CustomTextField(
                      readOnly: true,
                      maxLines: 1,
                      controller: _date,
                      label: "Date of Bill",
                      textInputType: TextInputType.text,
                      onChanged: () {},
                      onTap: () {
                        _startDate(context);
                      },
                    ),
                    ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 100,
                          width: double.infinity,
                          child: Row(
                            children: [
                              Container(
                                height: 100,
                                decoration: BoxDecoration(),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: kWhite,
                                  child: Center(
                                    child: Icon(
                                      Icons.person,
                                      color: kGrey4,
                                      size: 40,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Color(0xffA283F9),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextBuilder(
                                      text: 'Name of Bill',
                                      color: Colors.white,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    const SizedBox(height: 10.0),
                                    TextBuilder(
                                      text: 'Patient Name',
                                      color: Colors.white,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    const SizedBox(height: 20.0),
                                    Row(
                                      children: [],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
            color: kWhite),
        padding: EdgeInsets.symmetric(horizontal: 24),
        height: 80,
        child: Align(
          alignment: Alignment.center,
          child: CustomContainedButton(
            height: 58,
            textSize: 16,
            disabledColor: kGreyLite,
            text: "Submit",
            onPressed: () async {
              // if (_billName.text.isNotEmpty &&
              //     _amount.text.isNotEmpty &&
              //     _date.text.isNotEmpty &&
              //     _description.text.isNotEmpty &&
              //     _familyMember.text.isNotEmpty) {
              //   setState(() {
              //     _loading = true;
              //   });
              //   DocumentsRequest _request = DocumentsRequest(
              //       name: _billName.text,
              //       amount: double.parse(_amount.text),
              //       date: selectedDate,
              //       description: _description.text,
              //       patient: _memberId,
              //       billImage: files);
              //   print(_request.toJson().toString());
              //   DocumentsResponse _response = await Documents(_request);
              //   if (_response.success) {
              //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //       content: Text("Added successfully!"),
              //     ));
              //     await Future.delayed(Duration(seconds: 1));
              //     Navigator.pop(context);
              //   }
              // } else {
              //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //     content: Text("Please fill all the details"),
              //   ));
              // }
            },
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
