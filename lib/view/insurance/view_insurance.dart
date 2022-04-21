import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/model/response/search_insurance_response.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:health_bloom/view/insurance/insurance_documents.dart';

import '../../utils/text_field/custom_text_field.dart';

class ViewInsurance extends StatefulWidget {
  final SearchInsuranceResponseDatum insurance;

  const ViewInsurance({Key key, this.insurance}) : super(key: key);

  @override
  State<ViewInsurance> createState() => _ViewInsurance();
}

class _ViewInsurance extends State<ViewInsurance> {
  TextEditingController _orgName = TextEditingController();
  TextEditingController _policyNo = TextEditingController();
  TextEditingController _familyMember = TextEditingController();
  TextEditingController _dateOfBirth = TextEditingController();

  List<String> files = [];

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    if (widget.insurance != null) {
      _orgName.text = widget.insurance.organisationName.toString();
      _familyMember.text = widget.insurance.patient.name;

      files = widget.insurance.insuranceImage;
      _policyNo.text = widget.insurance.policyNo;
      _dateOfBirth.text =
          "${widget.insurance.dateOfBirth.day}-${widget.insurance.dateOfBirth.month}-${widget.insurance.dateOfBirth.year}";
      selectedDate = widget.insurance.dateOfBirth;
    }
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
          text: "View Insurance",
          fontSize: 22,
        ),
        centerTitle: true,
      ),
      backgroundColor: kWhite,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: kMainColor,
        icon: Icon(Icons.description),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InsuranceDocuments(
                insurance: null,
                userid: widget.insurance.patient.id,
                dob: widget.insurance.dateOfBirth,
              ),
            ),
          );
        },
        label: TextBuilder(
          text: "Browse Documents",
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    CustomTextField(
                      maxLines: 1,
                      readOnly: true,
                      controller: _familyMember,
                      textCapitalization: TextCapitalization.sentences,
                      label: "Family Member Name",
                      onChanged: (val) {},
                      onTap: () {},
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      maxLines: 1,
                      readOnly: true,
                      controller: _orgName,
                      textCapitalization: TextCapitalization.sentences,
                      label: "Organization Name",
                      onChanged: (val) {},
                      onTap: () {},
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      maxLines: 1,
                      readOnly: true,
                      controller: _policyNo,
                      textInputType: TextInputType.number,
                      label: "Policy Number",
                      onChanged: (val) {},
                      onTap: () {},
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      readOnly: true,
                      maxLines: 1,
                      controller: _dateOfBirth,
                      label: "Date of Birth",
                      textInputType: TextInputType.text,
                      onChanged: (val) {},
                      onTap: () {},
                    ),
                    SizedBox(height: 24),
                    if (files.isNotEmpty)
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            child: Wrap(
                              runSpacing: 20,
                              spacing: 20,
                              alignment: WrapAlignment.start,
                              runAlignment: WrapAlignment.start,
                              children: List.generate(
                                files.length,
                                (index) => Container(
                                  height: 100,
                                  width: 100,
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Image',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      GestureDetector(
                                                        child:
                                                            Icon(Icons.close),
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(height: 16),
                                                  Container(
                                                    margin: EdgeInsets.all(1),
                                                    height: 325,
                                                    width: double.infinity,
                                                    child: CachedNetworkImage(
                                                      imageUrl: files[index],
                                                      fit: BoxFit.cover,
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                                  downloadProgress) =>
                                                              Center(
                                                        child: CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          barrierDismissible: false);
                                    },
                                    child: Container(
                                      height: 90,
                                      width: 90,
                                      child: CachedNetworkImage(
                                        imageUrl: files[index],
                                        width: 90,
                                        height: 90,
                                        fit: BoxFit.cover,
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                Center(
                                          child: CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                        ],
                      ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
