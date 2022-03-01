import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:health_bloom/model/request/add_member_request.dart';
import 'package:health_bloom/model/request/edit_member_request.dart';
import 'package:health_bloom/model/response/add_family_response.dart';
import 'package:health_bloom/model/response/edit_member_response.dart';
import 'package:health_bloom/services/api/repository/auth_repository.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:health_bloom/utils/loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../components/custom_contained_button.dart';
import '../../utils/text_field/custom_text_field.dart';

class AddFamilyMembers extends StatefulWidget {
  const AddFamilyMembers({Key key}) : super(key: key);

  @override
  State<AddFamilyMembers> createState() => _AddFamilyMembersState();
}

class _AddFamilyMembersState extends State<AddFamilyMembers> {
  bool _loading = false;

  TextEditingController _name = TextEditingController();
  TextEditingController _relation = TextEditingController();
  int _age = 18;
  Future<AddMemberResponse> addMember(AddMemberRequest request) async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    AddMemberResponse _response = await adminAPI.addMemberAPI(request);
    return _response;
  }

  Future<EditMemberResponse> editMember(EditMemberRequest request) async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    EditMemberResponse _response = await adminAPI.editMemberAPI(request);
    return _response;
  }

  String _uploadAvatarUrl;
  bool _profileLoading = false;
  Future<XFile> singleImage() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  Future<String> uploadImage(XFile image) async {
    Reference db =
        FirebaseStorage.instance.ref('memberProfile/${getImagePath(image)}');
    setState(() {
      _profileLoading = true;
    });
    await db.putFile(File(image.path));
    return await db.getDownloadURL().whenComplete(
          () => setState(() {
            _profileLoading = false;
            _uploadAvatarUrl = db.getDownloadURL().toString();
            print('_uploadAvatarUrl ${_uploadAvatarUrl.toString()}');
          }),
        );
  }

  String getImagePath(XFile image) {
    return image.path.split('/').last;
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
        title: Text("Add Family Members"),
        centerTitle: true,
      ),
      backgroundColor: kWhite,
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        height: 75,
        child: Align(
          alignment: Alignment.topCenter,
          child: CustomContainedButton(
            height: 58,
            textSize: 16,
            disabledColor: kGreyLite,
            text: "Submit",
            onPressed: () async {
              setState(() {
                _loading = true;
              });

              if (_name.text.isNotEmpty && _relation.text.isNotEmpty) {
                AddMemberRequest _request = AddMemberRequest(
                    age: _age,
                    avatar: _uploadAvatarUrl ?? '',
                    name: _name.text,
                    relationship: _relation.text);
                AddMemberResponse _response = await addMember(_request);
                print('Add Meember Request ${_request.toJson()}');
                print('Add Meember Response ${_response.toJson()}');
                if (_response.success == true) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Added'),
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
      body: Stack(
        children: [
          Container(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    color: kMainColor,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  top: 180,
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 20, left: 24, right: 24),
                    decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30))),
                    child: ListView(
                      children: [
                        CustomTextField(
                          maxLines: 1,
                          controller: _name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "* Required";
                            } else
                              return null;
                          },
                          label: "Name",
                          textInputType: TextInputType.name,
                          onChanged: () {},
                          onTap: () {},
                        ),
                        SizedBox(height: 16),
                        CustomTextField(
                          maxLines: 1,
                          controller: _relation,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "* Required";
                            } else
                              return null;
                          },
                          label: "Relationship",
                          textInputType: TextInputType.name,
                          onChanged: () {},
                          onTap: () {},
                        ),
                        SizedBox(height: 24),
                        Row(
                          children: [
                            Text(
                              "Current Age",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: kGrey7),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (_age <= 1)
                                    _age == 0;
                                  else
                                    _age--;
                                });
                              },
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: kMainColor,
                                child: Icon(
                                  Icons.remove,
                                  color: kWhite,
                                  size: 16,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                _age.toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: kGrey7),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _age++;
                                });
                              },
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: kMainColor,
                                child: Icon(
                                  Icons.add,
                                  color: kWhite,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 130,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          XFile _imageFile = await singleImage();
                          _uploadAvatarUrl = await uploadImage(_imageFile);
                          setState(() {});
                        },
                        child: Container(
                          height: 106,
                          width: 106,
                          child: Stack(
                            children: [
                              _uploadAvatarUrl != null &&
                                      _uploadAvatarUrl.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(
                                        _uploadAvatarUrl,
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: kWhite,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 10)
                                          ]),
                                      child: Center(
                                        child: Icon(
                                          Icons.person,
                                          color: kGrey4,
                                          size: 60,
                                        ),
                                      ),
                                    ),
                              _profileLoading
                                  ? Center(
                                      child: Container(
                                        height: 50.0,
                                        width: 50.0,
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : Container(),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                  radius: 14,
                                  backgroundColor: kMainColor,
                                  child: Icon(
                                    Icons.edit,
                                    color: kWhite,
                                    size: 16,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          if (_loading) LoadingWidget()
        ],
      ),
    );
  }
}
