import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:health_bloom/model/request/add_prescription_request.dart';
import 'package:health_bloom/model/response/add_precsription_response.dart';
import 'package:health_bloom/model/response/get_all_member_response.dart';
import 'package:health_bloom/services/api/repository/auth_repository.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:health_bloom/utils/drop_down/custom_dropdown.dart';
import 'package:health_bloom/utils/loading.dart';
import 'package:provider/provider.dart';
import '../../components/custom_contained_button.dart';
import '../../utils/text_field/custom_text_field.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;

class AddPrescription extends StatefulWidget {
  const AddPrescription({Key key}) : super(key: key);

  @override
  State<AddPrescription> createState() => _AddPrescriptionState();
}

class _AddPrescriptionState extends State<AddPrescription> {
  TextEditingController _doctor = TextEditingController();
  TextEditingController _hospital = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _patient = TextEditingController();
  TextEditingController _userAilment = TextEditingController();
  TextEditingController _drAdvice = TextEditingController();
  String selectedPatient;
  DateTime selectedDate = DateTime.now();
  FilePickerResult _attachmentFile;
  File _file;
  UploadTask task;
  bool _loading = false;
  List<String> files = [];
  Future<AddPrescriptionResponse> addPrescription(
      AddPrescriptionRequest request) async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    AddPrescriptionResponse _response =
        await adminAPI.addPrescriptionAPI(request);
    return _response;
  }

  Future _futureMembers;
  Future<GetAllMemberResponse> getAllmember() async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    GetAllMemberResponse _response = await adminAPI.getAllMemberAPI();
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
          "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
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
      files.add(url);
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
        title: Text("Add Prescription"),
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
                            maxLines: 1,
                            controller: _doctor,
                            label: "Doctor Name",
                            textInputType: TextInputType.name,
                            onChanged: () {},
                            onTap: () {},
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          CustomTextField(
                            maxLines: 1,
                            controller: _hospital,
                            label: "Hospital/Clinic Name",
                            textInputType: TextInputType.name,
                            onChanged: () {},
                            onTap: () {},
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          CustomTextField(
                            readOnly: true,
                            maxLines: 1,
                            controller: _date,
                            label: "Consultation Date",
                            textInputType: TextInputType.text,
                            onChanged: () {},
                            onTap: () {
                              _selectDate(context);
                            },
                          ),
                          SizedBox(height: 16),
                          CustomTextField(
                            maxLines: 1,
                            controller: _userAilment,
                            label: "User Ailment",
                            textInputType: TextInputType.name,
                            onChanged: () {},
                            onTap: () {},
                          ),
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
                          SizedBox(height: 16),
                          CustomTextField(
                            maxLines: 3,
                            controller: _drAdvice,
                            label: "Dr. Advice",
                            textInputType: TextInputType.name,
                            onChanged: () {},
                            onTap: () {},
                          ),
                          SizedBox(
                            height: 24,
                          ),
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
                                                                    MainAxisSize
                                                                        .min,
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
                                                                                FontWeight.w600),
                                                                      ),
                                                                      GestureDetector(
                                                                        child: Icon(
                                                                            Icons.close),
                                                                        onTap:
                                                                            () {
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
                                                                    child: Image
                                                                        .network(
                                                                      files[
                                                                          index],
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
                                                          barrierDismissible:
                                                              false);
                                                    },
                                                    child: Container(
                                                      height: 100,
                                                      width: 100,
                                                      child: Image.asset(
                                                          "assets/icons/prescription.png"),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 10,
                                                    right: 18,
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
                                            )),
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
                                text: "Add Prescriptions",
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
              if (_drAdvice.text.isNotEmpty &&
                  _doctor.text.isNotEmpty &&
                  _userAilment.text.isNotEmpty &&
                  _hospital.text.isNotEmpty &&
                  files.isNotEmpty &&
                  _patient.text.isNotEmpty) {
                setState(() {
                  _loading = true;
                });
                AddPrescriptionRequest _request = AddPrescriptionRequest(
                  consultationDate: _date.text,
                  doctorAdvice: _drAdvice.text,
                  clinicName: _hospital.text,
                  patient: selectedPatient,
                  doctorName: _doctor.text,
                  prescriptionImage: files,
                  userAilment: _userAilment.text,
                );
                AddPrescriptionResponse _response =
                    await addPrescription(_request);
                print('Add Prescription Request ${_request.toJson()}');
                print('Add Prescription Response ${_response.toJson()}');
                if (_response.success == true) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Added successfully!'),
                  ));
                  setState(() {
                    _loading = false;
                  });

                  Navigator.pop(context);
                } else {
                  setState(() {
                    _loading = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Please fill all the details'),
                  ));
                }
              } else {
                setState(() {
                  _loading = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Please fill all the details'),
                ));
              }
            },
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
