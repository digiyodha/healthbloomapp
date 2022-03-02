import 'package:flutter/material.dart';
import 'package:health_bloom/model/response/response.dart';
import 'package:health_bloom/utils/colors.dart';

import '../../utils/text_field/custom_text_field.dart';

class ViewPrescriptionDocuments extends StatefulWidget {
  final GetAllDocumentsResponsePrescription prescriprion;
  const ViewPrescriptionDocuments({Key key, this.prescriprion})
      : super(key: key);

  @override
  State<ViewPrescriptionDocuments> createState() =>
      _ViewPrescriptionDocumentsState();
}

class _ViewPrescriptionDocumentsState extends State<ViewPrescriptionDocuments> {
  TextEditingController _drName = TextEditingController();
  TextEditingController _hospital = TextEditingController();
  TextEditingController _cunsultationDate = TextEditingController();
  TextEditingController _userAilment = TextEditingController();
  TextEditingController _drAdvice = TextEditingController();
  TextEditingController _familyMember = TextEditingController();

  List<String> files = [];

  @override
  void initState() {
    super.initState();

    if (widget.prescriprion != null) {
      _drName.text = widget.prescriprion.doctorName.toString();
      _hospital.text = widget.prescriprion.clinicName.toString();
      _cunsultationDate.text =
          "${widget.prescriprion.consultationDate.day}/${widget.prescriprion.consultationDate.month}/${widget.prescriprion.consultationDate.year}";
      _userAilment.text = widget.prescriprion.userAilment.toString();
      _familyMember.text = widget.prescriprion.patient.name;
      _drAdvice.text = widget.prescriprion.doctorAdvice.toString();

      files = widget.prescriprion.prescriptionImage;
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
        title: Text("View Prescription"),
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
                "assets/images/medical_report.jpg",
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
                    SizedBox(height: 5),
                    CustomTextField(
                      maxLines: 1,
                      controller: _drName,
                      enabled: false,
                      label: "Doctor Name",
                      textInputType: TextInputType.name,
                      onChanged: () {},
                      onTap: () {},
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      maxLines: 1,
                      enabled: false,
                      controller: _hospital,
                      label: "Hospital Name",
                      textInputType: TextInputType.number,
                      onChanged: () {},
                      onTap: () {},
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      enabled: false,
                      readOnly: true,
                      maxLines: 1,
                      controller: _cunsultationDate,
                      label: "Cunsultation Date",
                      textInputType: TextInputType.text,
                      onChanged: () {},
                      onTap: () {},
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      maxLines: 1,
                      enabled: false,
                      controller: _userAilment,
                      label: "User Ailment",
                      textInputType: TextInputType.name,
                      onChanged: () {},
                      onTap: () {},
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      maxLines: 3,
                      enabled: false,
                      controller: _userAilment,
                      label: "Dr Advice",
                      textInputType: TextInputType.name,
                      onChanged: () {},
                      onTap: () {},
                    ),
                    SizedBox(height: 24),
                    if (files.isNotEmpty)
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            child: Wrap(
                              children: List.generate(
                                  files.length,
                                  (index) => Container(
                                        height: 100,
                                        width: 100,
                                        child: Stack(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        content: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  'Image',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                GestureDetector(
                                                                  child: Icon(
                                                                      Icons
                                                                          .close),
                                                                  onTap: () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                )
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 16,
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .all(1),
                                                              height: 325,
                                                              width: double
                                                                  .infinity,
                                                              child:
                                                                  Image.network(
                                                                files[index],
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                            // SizedBox(height: 16,),
                                                            // CustomContainedButton(
                                                            //   text: "Download",
                                                            //   textSize: 20,
                                                            //   weight: FontWeight.w600,
                                                            //   height: 48,
                                                            //   width: 328,
                                                            //   disabledColor: kTeal4,
                                                            //   onPressed: () async{
                                                            //     if(kIsWeb){
                                                            //       downloadImage(widget.url,widget.assetName);
                                                            //     }else{
                                                            //       _download(widget.assetName, widget.url);
                                                            //     }
                                                            //   },
                                                            // )
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    barrierDismissible: false);
                                              },
                                              child: Container(
                                                height: 100,
                                                width: 100,
                                                child: Image.asset(
                                                    "assets/icons/prescription.png"),
                                              ),
                                            ),
                                            // Positioned(
                                            //   top: 10,
                                            //   right: 18,
                                            //   child: InkWell(
                                            //     onTap: () {
                                            //       files.removeAt(index);
                                            //       setState(() {});
                                            //     },
                                            //     child: CircleAvatar(
                                            //       backgroundColor:
                                            //           Color(0xffFF9B91),
                                            //       radius: 12,
                                            //       child: Icon(
                                            //         Icons.close,
                                            //         color: kWhite,
                                            //         size: 16,
                                            //       ),
                                            //     ),
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      )),
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 16,
                    ),
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
