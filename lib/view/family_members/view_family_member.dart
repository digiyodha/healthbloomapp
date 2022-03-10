import 'package:flutter/material.dart';

import 'package:health_bloom/model/response/get_all_member_response.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:health_bloom/utils/loading.dart';

import '../../utils/text_field/custom_text_field.dart';

class ViewFamilyMembers extends StatefulWidget {
  final GetAllMemberResponseDatum member;
  const ViewFamilyMembers({Key key, this.member}) : super(key: key);

  @override
  State<ViewFamilyMembers> createState() => _ViewFamilyMembersState();
}

class _ViewFamilyMembersState extends State<ViewFamilyMembers> {
  bool _loading = false;

  TextEditingController _name = TextEditingController();
  TextEditingController _relation = TextEditingController();
  int _age = 18;

  String _uploadAvatarUrl;
  bool _profileLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.member != null) {
      print('Member Name ${widget.member.name}');
      _name.text = widget.member.name;
      print('Member Relation ${widget.member.relationship}');
      _relation.text = widget.member.relationship;
      print('Member Age ${widget.member.age}');
      _age = widget.member.age;
      print('Member Avatar ${widget.member.avatar}');
      _uploadAvatarUrl = widget.member.avatar;
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
        title: Text("View Family Member"),
        centerTitle: true,
      ),
      backgroundColor: kWhite,
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
                          enabled: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "* Required";
                            } else
                              return null;
                          },
                          label: "Name",
                          textInputType: TextInputType.name,
                          onChanged: (val) {},
                          onTap: () {},
                        ),
                        SizedBox(height: 16),
                        CustomTextField(
                          maxLines: 1,
                          controller: _relation,
                          enabled: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "* Required";
                            } else
                              return null;
                          },
                          label: "Relationship",
                          textInputType: TextInputType.name,
                          onChanged: (val) {},
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
                      Container(
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
                                        borderRadius: BorderRadius.circular(16),
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
                          ],
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
