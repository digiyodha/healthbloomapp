import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/model/request/add_insurance_request.dart';
import 'package:health_bloom/model/request/edit_insurance_request.dart';
import 'package:health_bloom/model/response/add_insurance_response.dart';
import 'package:health_bloom/model/response/edit_insurance_response.dart';
import 'package:health_bloom/model/response/search_insurance_response.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:health_bloom/utils/loading.dart';
import 'package:provider/provider.dart';
import '../../components/custom_contained_button.dart';
import '../../model/response/get_all_member_response.dart';
import '../../services/api/repository/auth_repository.dart';
import '../../utils/drop_down/custom_dropdown.dart';
import '../../utils/text_field/custom_text_field.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;

class AddInsurance extends StatefulWidget {
  final SearchInsuranceResponseDatum insurance;
  const AddInsurance({Key key, this.insurance}) : super(key: key);

  @override
  State<AddInsurance> createState() => _AddInsuranceState();
}

class _AddInsuranceState extends State<AddInsurance> {
  TextEditingController _orgName = TextEditingController();
  TextEditingController _familyMember = TextEditingController();

  FilePickerResult _attachmentFile;
  File _file;
  UploadTask task;
  bool _loading = false;
  List<String> files = [];
  Future _future;
  String _memberId;

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

  Future<AddInsuranceResponse> addInsurance(AddInsuranceRequest request) async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    AddInsuranceResponse _response = await adminAPI.addInsuranceAPI(request);
    return _response;
  }

  Future<EditInsuranceResponse> editInsurance(
      EditInsuranceRequest request) async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    EditInsuranceResponse _response = await adminAPI.editInsuranceAPI(request);
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
    _future = getAllmember();
    if (widget.insurance != null) {
      _orgName.text = widget.insurance.organisationName.toString();
      _familyMember.text = widget.insurance.patient.name;
      _memberId = widget.insurance.patient.id;

      files = widget.insurance.insuranceImage;
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
          text: widget.insurance != null ? "Edit Insurance" : "Add Insurance",
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
        centerTitle: true,
      ),
      backgroundColor: kWhite,
      body: FutureBuilder<GetAllMemberResponse>(
        future: _future,
        builder: (context, data) {
          if (data.hasData) {
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
                            controller: _orgName,
                            textCapitalization: TextCapitalization.sentences,
                            label: "Organization Name",
                            onChanged: (val) {},
                            onTap: () {},
                          ),
                          SizedBox(height: 16),
                          CustomDropDown(
                            title: "Select Family Member",
                            controller: _familyMember,
                            dropDownData:
                                data.data.data.map((e) => e.name).toList(),
                            stateCallback: (int i) {
                              _memberId = data.data.data[i].id;
                            },
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
                                                                  Image.network(
                                                                files[index],
                                                                fit: BoxFit
                                                                    .cover,
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
                                                child: Image.network(
                                                  files[index],
                                                  width: 90,
                                                  height: 90,
                                                  fit: BoxFit.cover,
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
                                text: "Add Insurance",
                                onPressed: () {
                                  getFile(context);
                                },
                                width: double.infinity,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (_loading) LoadingWidget()
              ],
            );
          } else {
            return LoadingWidget();
          }
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
              if (widget.insurance != null) {
                if (_orgName.text.isNotEmpty && _familyMember.text.isNotEmpty) {
                  setState(() {
                    _loading = true;
                  });

                  EditInsuranceRequest _request = EditInsuranceRequest(
                    id: widget.insurance.id,
                    organisationName: _orgName.text,
                    insuranceImage: files,
                    patient: _memberId,
                  );
                  print('Edit Insurance request ${_request.toJson()}');
                  EditInsuranceResponse _response =
                      await editInsurance(_request);
                  print('Edit Insurance response ${_response.toJson()}');
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
                if (_orgName.text.isNotEmpty && _familyMember.text.isNotEmpty) {
                  setState(() {
                    _loading = true;
                  });

                  AddInsuranceRequest _request = AddInsuranceRequest(
                    organisationName: _orgName.text,
                    patient: _memberId,
                    insuranceImage: files,
                  );
                  print('Add Insurance request ${_request.toJson()}');
                  AddInsuranceResponse _response = await addInsurance(_request);
                  print('Add Insurance response ${_response.toJson()}');
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
