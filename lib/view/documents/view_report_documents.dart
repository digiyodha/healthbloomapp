import 'package:flutter/material.dart';
import 'package:health_bloom/model/response/response.dart';
import 'package:health_bloom/utils/colors.dart';

import '../../utils/text_field/custom_text_field.dart';

class ViewReportDocuments extends StatefulWidget {
  final GetAllDocumentsResponseBill report;
  const ViewReportDocuments({Key key, this.report}) : super(key: key);

  @override
  State<ViewReportDocuments> createState() => _ViewReportDocumentsState();
}

class _ViewReportDocumentsState extends State<ViewReportDocuments> {
  TextEditingController _billName = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _description = TextEditingController();

  List<String> files = [];

  @override
  void initState() {
    super.initState();

    if (widget.report != null) {
      _billName.text = widget.report.name.toString();
      _date.text =
          "${widget.report.date.day}/${widget.report.date.month}/${widget.report.date.year}";
      _description.text = widget.report.description;

      files = widget.report.reportImage;
      print("Report ${widget.report.billImage.toList().toString()}");
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
        title: Text("View Report"),
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
                      controller: _billName,
                      enabled: false,
                      label: "Name of Bill",
                      textInputType: TextInputType.name,
                      onChanged: () {},
                      onTap: () {},
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      enabled: false,
                      readOnly: true,
                      maxLines: 1,
                      controller: _date,
                      label: "Date of Bill",
                      textInputType: TextInputType.text,
                      onChanged: () {},
                      onTap: () {},
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      maxLines: 3,
                      enabled: false,
                      controller: _description,
                      label: "Description",
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
