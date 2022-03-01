import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_bloom/main.dart';
import 'package:health_bloom/view/documents/documents.dart';
import 'package:health_bloom/view/homepage/home_page.dart';
import 'package:health_bloom/view/splash/splash_screen.dart';
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
  @override
  void initState() {
    super.initState();
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
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 20),
                  child: Row(
                    children: [
                      sp.getString('profileImage').isNotEmpty &&
                              sp.getString('profileImage') != null
                          ? CircleAvatar(
                              radius: 36,
                              backgroundColor: kWhite,
                              backgroundImage: NetworkImage(
                                sp.getString('profileImage'),
                              ),
                            )
                          : CircleAvatar(
                              radius: 36,
                              backgroundColor: kWhite,
                              child: Center(
                                child: Icon(
                                  Icons.person,
                                  color: kGrey4,
                                  size: 40,
                                ),
                              ),
                            ),
                      SizedBox(
                        width: 14,
                      ),
                      Expanded(
                        child: Text(
                          "${sp.getString('name').toString()}",
                          style: TextStyle(fontSize: 20, color: kWhite),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30),
                DrawerContainerWidget(
                  text: "Home",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                  selected: widget.selected == 0,
                  icon: Icons.home,
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
