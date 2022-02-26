import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/main.dart';
import 'package:health_bloom/model/response/get_user_response.dart';
import 'package:health_bloom/services/api/repository/auth_repository.dart';
import 'package:health_bloom/view/documents/documents.dart';
import 'package:health_bloom/view/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import '../../view/family_members/family_members.dart';
import '../../view/water_intake/water_intake.dart';
import '../colors.dart';
import 'drawer_container_widget.dart';

class CustomDrawer extends StatefulWidget {
  final int selected;
  CustomDrawer({this.selected});

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Future _futureUser;
  Future<GetUserResponse> getUser() async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    GetUserResponse _response = await adminAPI.getUserAPI();
    return _response;
  }

  @override
  void initState() {
    super.initState();
    _futureUser = getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 4,
      child: Container(
        height: double.infinity,
        color: kMainColor,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<GetUserResponse>(
                  future: _futureUser,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 16, top: 20),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 36,
                              backgroundColor: kWhite,
                              backgroundImage: NetworkImage(snapshot
                                      .data.data.avatar ??
                                  'https://winfort.net/wp-content/themes/consultix-1/images/no-image-found-360x260.png'),
                            ),
                            SizedBox(
                              width: 14,
                            ),
                            Expanded(
                              child: Text(
                                "${snapshot.data.data.name.toString()}",
                                style: TextStyle(fontSize: 20, color: kWhite),
                              ),
                            )
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Center(
                      child: TextBuilder(
                        text: 'Loading',
                        color: Colors.white,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                DrawerContainerWidget(
                  text: "Profile",
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => EditProfile(),
                    //   ),
                    // );
                  },
                  selected: widget.selected == 1,
                  icon: Icons.person,
                ),
                DrawerContainerWidget(
                  text: "Water Tracker",
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return WaterIntake();
                    }));
                  },
                  selected: widget.selected == 2,
                  icon: Icons.track_changes,
                ),
                DrawerContainerWidget(
                  text: "Documents",
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Documents();
                    }));
                  },
                  selected: widget.selected == 3,
                  icon: Icons.picture_as_pdf,
                ),
                DrawerContainerWidget(
                  text: "Family Members",
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return FamilyMembers();
                    }));
                  },
                  selected: widget.selected == 4,
                  icon: Icons.supervised_user_circle_sharp,
                ),
                DrawerContainerWidget(
                  text: "Insurance Claim",
                  onTap: () {},
                  selected: widget.selected == 5,
                  icon: Icons.picture_as_pdf,
                ),
                DrawerContainerWidget(
                  text: "Updates",
                  onTap: () {},
                  selected: widget.selected == 6,
                  icon: Icons.update_outlined,
                ),
                DrawerContainerWidget(
                  text: "Settings",
                  onTap: () {},
                  selected: widget.selected == 7,
                  icon: Icons.settings,
                ),
                DrawerContainerWidget(
                  text: "Logout",
                  onTap: () async {
                    await _signOut();
                    sp.clear();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SplashScreen();
                    }));
                  },
                  selected: widget.selected == 8,
                  icon: Icons.logout,
                ),
                SizedBox(
                  height: 34,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}
