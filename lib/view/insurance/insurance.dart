import 'package:flutter/material.dart';
import 'package:health_bloom/components/insurance_card.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/model/request/delete_insurence_request.dart';
import 'package:health_bloom/model/request/search_insurance_request.dart';
import 'package:health_bloom/model/response/delete_insurance_response.dart';
import 'package:health_bloom/model/response/search_insurance_response.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:health_bloom/utils/loading.dart';
import 'package:health_bloom/utils/text_field/custom_text_field.dart';
import 'package:health_bloom/view/insurance/add_insurance.dart';
import 'package:health_bloom/view/insurance/view_insurance.dart';

import 'package:provider/provider.dart';

import '../../services/api/repository/auth_repository.dart';
import '../../utils/drawer/custom_drawer.dart';
import '../homepage/home_page.dart';

class Insurance extends StatefulWidget {
  const Insurance({Key key}) : super(key: key);

  @override
  State<Insurance> createState() => _InsuranceState();
}

class _InsuranceState extends State<Insurance> {
  TextEditingController _searchText = TextEditingController();
  DateTime selectedStartDate;
  DateTime selectedEndDate;
  int currentIndex = 0;
  bool _loading = false;
  SearchInsuranceResponse _currentResponse;
  SearchInsuranceResponse _searchResponse;

  Future getInsurance() async {
    setState(() {
      _currentResponse = null;
    });
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    SearchInsuranceResponse _response = await adminAPI.searchInsuranceAPI(
        SearchInsuranceRequest(name: _searchText.text.toLowerCase()) ?? '');
    setState(() {
      _currentResponse = _response;
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getInsurance();
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
          selected: 5,
        ),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: IconThemeData(color: kWhite),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: TextBuilder(
            text: "Insurance",
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
                    "assets/images/insurance.jpg",
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
                      const SizedBox(height: 5.0),
                      CustomTextField(
                        maxLines: 1,
                        controller: _searchText,
                        label: "Search",
                        onChanged: (val) {
                          getInsurance();
                          _currentResponse = _searchResponse;
                        },
                        onTap: () {},
                      ),
                      const SizedBox(height: 20.0),
                      Expanded(
                        child: _currentResponse != null
                            ? ListView.builder(
                                padding: EdgeInsets.only(top: 0, bottom: 20),
                                itemCount: _currentResponse.data.length,
                                physics: ScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return InsuranceCard(
                                    organization: _currentResponse
                                        .data[index].organisationName,
                                    avatar: _currentResponse
                                        .data[index].patient.avatar,
                                    nameOfPatients:
                                        _currentResponse.data[index].patient.name,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ViewInsurance(
                                            insurance:
                                                _currentResponse.data[index],
                                          ),
                                        ),
                                      );
                                    },
                                    edit: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddInsurance(
                                            insurance:
                                                _currentResponse.data[index],
                                          ),
                                        ),
                                      ).whenComplete(() => setState(() {
                                            getInsurance();
                                          }));
                                    },
                                    delete: () async {
                                      setState(() {
                                        _loading = true;
                                      });
                                      final adminAPI =
                                          Provider.of<NetworkRepository>(context,
                                              listen: false);
                                      DeleteInsuranceResponse _response =
                                          await adminAPI.deleteInsuranceAPI(
                                              DeleteInsuranceRequest(
                                                  id: _currentResponse
                                                      .data[index].id));
                                      if (_response.success) {
                                        getInsurance();
                                      }
                                    },
                                  );
                                },
                              )
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
}
