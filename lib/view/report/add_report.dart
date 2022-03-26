import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/model/request/add_report_request.dart';
import 'package:health_bloom/model/request/edit_report_request.dart';
import 'package:health_bloom/model/response/add_report_response.dart';
import 'package:health_bloom/model/response/edit_report_response.dart';
import 'package:health_bloom/model/response/get_all_member_response.dart';
import 'package:health_bloom/services/api/repository/auth_repository.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:health_bloom/utils/drop_down/custom_dropdown.dart';
import 'package:health_bloom/utils/loading.dart';
import 'package:provider/provider.dart';
import '../../components/custom_contained_button.dart';
import '../../model/request/request.dart';
import '../../model/response/response.dart';
import '../../utils/text_field/custom_text_field.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;

class AddReport extends StatefulWidget {
  final GetAllDocumentsResponseBill report;
  AddReport({Key key, this.report}) : super(key: key);

  @override
  State<AddReport> createState() => _AddReportState();
}

class _AddReportState extends State<AddReport> {
  TextEditingController _nameOfReport = TextEditingController();
  TextEditingController _patient = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _description = TextEditingController();

  String selectedPatient;
  DateTime selectedDate = DateTime.now();
  FilePickerResult _attachmentFile;
  File _file;
  UploadTask task;
  bool _loading = false;
  List<ImageListRequest> files = [];
  Future _futureMembers;
  Future<GetAllMemberResponse> getAllmember() async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    GetAllMemberResponse _response = await adminAPI.getAllMemberAPI();
    return _response;
  }

  Future<AddReportResponse> addReport(AddReportRequest request) async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    AddReportResponse _response = await adminAPI.addReportAPI(request);
    return _response;
  }

  Future<EditReportResponse> editReport(EditReportRequest request) async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    EditReportResponse _response = await adminAPI.editReportAPI(request);
    return _response;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      _date.text =
          "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
    }
  }

  Future getFile(BuildContext context) async {
    setState(() {
      _loading = true;
    });
    _attachmentFile = await FilePicker.platform.pickFiles(type: FileType.any);
    if (_attachmentFile != null) {
      _file = File(_attachmentFile.files.single.path);
      final ref =
          FirebaseStorage.instance.ref('files/${path.basename(_file.path)}');
      task = ref.putFile(_file);
      final snapshot = await task.whenComplete(() {});
      final url = await snapshot.ref.getDownloadURL();
      debugPrint(url);
      files.add(
        ImageListRequest(
            assetName: path.basename(_file.path),
            assetUrl: url,
            assetSize: 1,
            assetType: "Image",
            thumbnailUrl: url),
      );
      setState(() {
        _loading = false;
      });
    } else {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _futureMembers = getAllmember();
    if (widget.report != null) {
      _nameOfReport.text = widget.report.name;
      _date.text =
          "${widget.report.date.day}-${widget.report.date.month}-${widget.report.date.year}";
      _description.text = widget.report.description;
      _patient.text = widget.report.patient.name;
      selectedPatient = widget.report.patient.id;
      selectedDate = widget.report.date;
      files = widget.report.reportImage;
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
          text: widget.report != null ? "Edit Report" : "Add Report",
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
        centerTitle: true,
      ),
      backgroundColor: kWhite,
      body: FutureBuilder<GetAllMemberResponse>(
        future: _futureMembers,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
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
                            controller: _nameOfReport,
                            label: "Name of Report",
                            textCapitalization: TextCapitalization.sentences,
                            textInputType: TextInputType.name,
                            onChanged: (val) {},
                            onTap: () {},
                          ),
                          SizedBox(height: 16),
                          CustomTextField(
                            readOnly: true,
                            maxLines: 1,
                            controller: _date,
                            label: "Date of Report",
                            textInputType: TextInputType.text,
                            onChanged: (val) {},
                            onTap: () {
                              _selectDate(context);
                            },
                          ),
                          SizedBox(height: 16),
                          CustomTextField(
                            maxLines: 3,
                            controller: _description,
                            textCapitalization: TextCapitalization.sentences,
                            label: "Description",
                            textInputType: TextInputType.name,
                            onChanged: (val) {},
                            onTap: () {},
                          ),
                          // SizedBox(height: 16),
                          // CustomTextField(
                          //   maxLines: 1,
                          //   controller: _familyMember,
                          //   label: "Family member",
                          //   textInputType: TextInputType.name,
                          //   onChanged: (val) {},
                          //   onTap: () {},
                          // ),
                          SizedBox(height: 16),
                          CustomDropDown(
                            title: "Select Patient",
                            controller: _patient,
                            dropDownData:
                                snapshot.data.data.map((e) => e.name).toList(),
                            stateCallback: (int i) {
                              selectedPatient = snapshot.data.data[i].id;
                            },
                          ),
                          SizedBox(height: 24),
                          if (files.isNotEmpty)
                            Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Wrap(
                                    runSpacing: 15,
                                    spacing: 15,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.start,
                                    alignment: WrapAlignment.start,
                                    runAlignment: WrapAlignment.start,
                                    children: List.generate(
                                      files.length,
                                      (index) => Container(
                                        height: 90,
                                        width: 90,
                                        child: Stack(
                                          alignment: Alignment.bottomCenter,
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
                                                                height: 16),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .all(1),
                                                              height: 325,
                                                              width: double
                                                                  .infinity,
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl: files[
                                                                        index]
                                                                    .assetUrl,
                                                                fit: BoxFit
                                                                    .cover,
                                                                progressIndicatorBuilder:
                                                                    (context,
                                                                            url,
                                                                            downloadProgress) =>
                                                                        Center(
                                                                  child: CircularProgressIndicator(
                                                                      value: downloadProgress
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
                                                height: 80,
                                                width: 80,
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      files[index].assetUrl,
                                                  width: 80,
                                                  height: 80,
                                                  fit: BoxFit.cover,
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              downloadProgress) =>
                                                          Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 0,
                                              right: 0,
                                              child: InkWell(
                                                onTap: () {
                                                  files.removeAt(index);
                                                  setState(() {});
                                                },
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      Color(0xffFF9B91),
                                                  radius: 12,
                                                  child: Icon(
                                                    Icons.close,
                                                    color: kWhite,
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 24),
                              ],
                            ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            height: 75,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: CustomContainedButton(
                                color: Color(0xffFF9B91),
                                height: 58,
                                textSize: 16,
                                disabledColor: kGreyLite,
                                text: "Add Report",
                                onPressed: () {
                                  getFile(context);
                                },
                                width: double.infinity,
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
                if (_loading) LoadingWidget()
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(child: CircularProgressIndicator());
        },
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
              if (widget.report != null) {
                if (_nameOfReport.text.isNotEmpty &&
                    _date.text.isNotEmpty &&
                    _description.text.isNotEmpty &&
                    _date.text.isNotEmpty) {
                  setState(() {
                    _loading = true;
                  });
                  EditReportRequest _request = EditReportRequest(
                      id: widget.report.id,
                      name: _nameOfReport.text,
                      description: _description.text,
                      patient: selectedPatient,
                      reportImage: files,
                      date: selectedDate);
                  print(_request.toJson().toString());
                  EditReportResponse _response = await editReport(_request);
                  print('Edit Report Request ${_request.toJson()}');
                  print('Edit Report Response ${_response.toJson()}');
                  if (_response.success) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Updated successfully!"),
                    ));
                    await Future.delayed(Duration(seconds: 1));
                    Navigator.pop(context);
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Please fill all the details"),
                  ));
                }
              } else {
                if (_nameOfReport.text.isNotEmpty &&
                    _date.text.isNotEmpty &&
                    _description.text.isNotEmpty &&
                    _date.text.isNotEmpty) {
                  setState(() {
                    _loading = true;
                  });
                  AddReportRequest _request = AddReportRequest(
                      name: _nameOfReport.text,
                      description: _description.text,
                      patient: selectedPatient,
                      reportImage: files,
                      date: selectedDate);
                  print(_request.toJson().toString());
                  AddReportResponse _response = await addReport(_request);
                  print('Add Report Request ${_request.toJson()}');
                  print('Add Report Response ${_response.toJson()}');
                  if (_response.success) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Added successfully!"),
                    ));
                    await Future.delayed(Duration(seconds: 1));
                    Navigator.pop(context);
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Please fill all the details"),
                  ));
                }
              }
            },
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
