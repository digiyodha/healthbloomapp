import 'package:flutter/material.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/model/request/delete_member_request.dart';
import 'package:health_bloom/model/response/delete_member_response.dart';
import 'package:health_bloom/model/response/get_all_member_response.dart';
import 'package:health_bloom/services/api/repository/auth_repository.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:health_bloom/utils/loading.dart';
import 'package:health_bloom/view/family_members/view_family_member.dart';
import 'package:health_bloom/view/main_view.dart';
import 'package:provider/provider.dart';

import '../../utils/drawer/custom_drawer.dart';
import 'add_family_member.dart';

class FamilyMembers extends StatefulWidget {
  const FamilyMembers({Key key}) : super(key: key);

  @override
  State<FamilyMembers> createState() => _FamilyMembersState();
}

class _FamilyMembersState extends State<FamilyMembers> {
  bool _loading = false;

  Future<GetAllMemberResponse> getAllmember() async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    GetAllMemberResponse _response = await adminAPI.getAllMemberAPI();
    return _response;
  }

  Future<DeleteMemberResponse> deleteMemeber(
      DeleteMemberRequest request) async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    DeleteMemberResponse _response = await adminAPI.deleteMemberAPI(request);
    return _response;
  }

  @override
  void initState() {
    super.initState();
    getAllmember();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainView(),
          ),
        );
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: TextBuilder(
            text: "Family Members",
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
          centerTitle: true,
        ),
        drawer: CustomDrawer(
          selected: 4,
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
                      child: Image.asset(
                        "assets/images/family.png",
                        fit: BoxFit.cover,
                        color: Colors.black45,
                        colorBlendMode: BlendMode.hardLight,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 300,
                      width: double.infinity,
                      color: kMainColor.withOpacity(0.3),
                    ),
                  ),
                  Column(
                    children: [
                      // SizedBox(height: 18,),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text("Medicines",
                      //       style: TextStyle(
                      //         fontSize: 18,
                      //         fontWeight: FontWeight.w600,
                      //       ),),
                      //     Icon(Icons.more_horiz,color: kGreyText,size: 28,)
                      //   ],
                      // ),
                      SizedBox(
                        height: 100,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom: 0, left: 18, right: 18, top: 20),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: kMainColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16))),
                          child: FutureBuilder<GetAllMemberResponse>(
                            future: getAllmember(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return snapshot.data.data.length != 0 &&
                                        snapshot.data.data.isNotEmpty
                                    ? GridView.builder(
                                        padding: EdgeInsets.all(0),
                                        itemCount: snapshot.data.data.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                childAspectRatio: 0.75,
                                                crossAxisSpacing: 16,
                                                mainAxisSpacing: 16),
                                        itemBuilder:
                                            (BuildContext context, int i) {
                                          final member = snapshot.data.data[i];
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ViewFamilyMembers(
                                                            member: member,
                                                          )));
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 14),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: Color(0xffAF8EFF),
                                              ),
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    height: double.infinity,
                                                    width: double.infinity,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        member.avatar.isNotEmpty &&
                                                                member.avatar
                                                                        .length !=
                                                                    null &&
                                                                member.avatar !=
                                                                    null &&
                                                                member.avatar
                                                                        .length !=
                                                                    0
                                                            ? CircleAvatar(
                                                                radius: 40,
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                  member.avatar,
                                                                  scale: 1.0,
                                                                ),
                                                              )
                                                            : CircleAvatar(
                                                                radius: 40,
                                                                backgroundColor:
                                                                    kWhite,
                                                                child: Center(
                                                                  child: Icon(
                                                                    Icons
                                                                        .person,
                                                                    color:
                                                                        kGrey4,
                                                                    size: 40,
                                                                  ),
                                                                ),
                                                              ),
                                                        Spacer(),
                                                        Text(
                                                          member.name
                                                                  .toString() ??
                                                              '',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 22,
                                                              color: kWhite,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                          maxLines: 1,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        SizedBox(height: 6),
                                                        Text(
                                                          member.relationship
                                                                  .toString() ??
                                                              '',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: kWhite
                                                                  .withOpacity(
                                                                      0.6),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                          maxLines: 1,
                                                        ),
                                                        Spacer(),
                                                      ],
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 0,
                                                    right: 0,
                                                    child: InkWell(
                                                        onTap: () async {
                                                          showDialog(
                                                            context: context,
                                                            useSafeArea: true,
                                                            barrierDismissible:
                                                                true,
                                                            builder: (context) {
                                                              return FutureBuilder(
                                                                builder: (context,
                                                                    snapshot) {
                                                                  return AlertDialog(
                                                                    title: Text(
                                                                        'Delete ${member.name}'),
                                                                    content: Text(
                                                                        'Are you sure!'),
                                                                    actions: [
                                                                      TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              TextBuilder(text: 'No')),
                                                                      MaterialButton(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(6)),
                                                                        color: Color(
                                                                            0xffFF9B91),
                                                                        onPressed:
                                                                            () async {
                                                                          setState(
                                                                              () {
                                                                            _loading =
                                                                                true;
                                                                          });

                                                                          DeleteMemberRequest
                                                                              _request =
                                                                              DeleteMemberRequest(familyMemberId: member.id);
                                                                          DeleteMemberResponse
                                                                              _response =
                                                                              await deleteMemeber(_request);

                                                                          print(
                                                                              'Delete Member Request ${_request.toJson()}');
                                                                          print(
                                                                              'Delete Member Response ${_response.toJson()}');
                                                                          if (_response.success ==
                                                                              true) {
                                                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                              content: Text('Family member has been deleted successfully'),
                                                                            ));
                                                                            setState(() {
                                                                              _loading = false;
                                                                            });
                                                                            Navigator.pop(context,
                                                                                true);
                                                                          }
                                                                        },
                                                                        child:
                                                                            TextBuilder(
                                                                          text:
                                                                              'Yes',
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          ).whenComplete(() =>
                                                              setState(() {
                                                                getAllmember();
                                                              }));
                                                        },
                                                        child: Icon(
                                                          Icons.delete,
                                                          size: 20,
                                                          color: Colors.white,
                                                        )),
                                                  ),
                                                  Positioned(
                                                    bottom: 0,
                                                    left: 0,
                                                    child: InkWell(
                                                        onTap: () async {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      AddFamilyMembers(
                                                                          member:
                                                                              member))).whenComplete(
                                                              () {
                                                            setState(() {});
                                                            getAllmember();
                                                          });
                                                        },
                                                        child: Icon(
                                                          Icons.edit,
                                                          size: 20,
                                                          color: Colors.white,
                                                        )),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : Center(
                                        child: TextBuilder(
                                          text: 'No family Members',
                                          color: Colors.white,
                                        ),
                                      );
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              return Center(
                                  child: CircularProgressIndicator(
                                color: Colors.white,
                              ));
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            if (_loading)
              LoadingWidget(
                color: Colors.white,
              )
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AddFamilyMembers();
              })).whenComplete(() => setState(() {}));
            },
            backgroundColor: Color(0xffFF9B91),
            child: Center(
              child: Icon(
                Icons.add,
                color: kWhite,
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
