import 'package:flutter/material.dart';
import 'package:health_bloom/model/request/request.dart';
import 'package:health_bloom/view/insurance/widgets/insaurance_card.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import '../../components/textbuilder.dart';
import '../../model/response/response.dart';
import '../../model/response/search_insurance_response.dart';
import '../../services/api/repository/auth_repository.dart';
import '../../utils/colors.dart';
import '../../utils/downloader.dart';
import '../../utils/loading.dart';
import '../../utils/text_field/custom_text_field.dart';

class InsuranceDocuments extends StatefulWidget {
  final SearchInsuranceResponseDatum insurance;
  const InsuranceDocuments({Key key,this.insurance}) : super(key: key);

  @override
  State<InsuranceDocuments> createState() => _InsuranceDocumentsState();
}

class _InsuranceDocumentsState extends State<InsuranceDocuments> {
  TextEditingController _fromDate = TextEditingController();
  TextEditingController _toDate = TextEditingController();
  DateTime selectedStartDate;
  DateTime selectedEndDate;
  bool _loading = false;
  GetDocumentsFamilyResponse _currentResponse;
  List<GetDocumentsFamilyResponseCommonObject> _sortedDocs = [];
  List<String> _shareIds = [];

  Future<void> _startDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
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
        patient: widget.insurance.patient.id
    );
    print(_request.toJson().toString());
    GetDocumentsFamilyResponse _response = await adminAPI.getDocumentsFamilyAPI(_request);

    _currentResponse = _response;

    _currentResponse.data.report.forEach((element) {
      _sortedDocs.add(
          GetDocumentsFamilyResponseCommonObject(
            id: element.id,
            name: element.name,
            date: element.date,
            description: element.description,
            images: element.reportImage,
            patient: element.patient,
            userId: element.userId,
            type: "Report"
          )
      );
    });

    _currentResponse.data.prescription.forEach((element) {
      _sortedDocs.add(
          GetDocumentsFamilyResponseCommonObject(
              id: element.id,
              name: element.doctorName,
              date: element.consultationDate,
              description: element.doctorAdvice,
              images: element.prescriptionImage,
              patient: element.patient,
              userId: element.userId,
              clinicName: element.clinicName,
              userAilment: element.userAilment,
              type: "Prescription"
          )
      );
    });

    _currentResponse.data.bill.forEach((element) {
      _sortedDocs.add(
          GetDocumentsFamilyResponseCommonObject(
              id: element.id,
              name: element.name,
              date: element.date,
              description: element.description,
              images: element.billImage,
              patient: element.patient,
              userId: element.userId,
              amount: element.amount,
              type: "Bill"
          )
      );
    });

    await Future.delayed(Duration(seconds: 1));

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getDocumentsFamily();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
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
      body: _currentResponse != null ? Stack(
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
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: _sortedDocs.length,
                      itemBuilder: (context,index){
                        return InsuranceCard(
                          nameOfBill: "${_sortedDocs[index].type}: " + _sortedDocs[index].name,
                          nameOfPatients: _sortedDocs[index].patient.name,
                          dateOfBill: _sortedDocs[index].date,
                          avatar: _sortedDocs[index].patient.avatar ?? '',
                          onTap: (bool v) {
                            if(v){
                              _shareIds.add(_sortedDocs[index].id);
                            }else{
                              _shareIds.remove(_sortedDocs[index].id);
                            }
                            setState(() {});
                          },
                          edit: () {},
                          delete: () {},
                          showIcons: false,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
          if (_loading) LoadingWidget()
        ],
      ) : LoadingWidget(),
      floatingActionButton: _shareIds.isNotEmpty ? FloatingActionButton(
        backgroundColor: kGrey7,
        child: Icon(Icons.share,color: kWhite,size: 26,),
        onPressed: () async{
          String _temp = "";

          _shareIds.forEach((element) async{
            List<GetDocumentsFamilyResponseCommonObject> _tempList = _sortedDocs.where((e) => element == e.id).toList();

            String path = await FileDownloader().download(_tempList[0].images[0].assetName, _tempList[0].images[0].assetUrl);
            print("**************************");
            print(path);
            print("**************************");
            Share.shareFiles([path], text: 'Great picture');

            // _temp = _temp + _tempList[0].name;
            // _temp = _temp + "\n";
            // _temp = _temp + _tempList[0].patient.name;
            // _temp = _temp + "\n";
            // _temp = _temp + _tempList[0].description;
            // _temp = _temp + "\n";
            // if(_tempList[0].images.isNotEmpty){
            //   _temp = _temp + "Files : ${_tempList[0].images[0].assetUrl}";
            //   _temp = _temp + "\n";
            // }
            // _temp = _temp + "\n";
            // _temp = _temp + "\n";
          });

          // Share.share(_temp);
        },
      ) : null,
    );
  }
}
