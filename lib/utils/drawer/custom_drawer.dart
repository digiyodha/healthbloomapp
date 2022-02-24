import 'package:flutter/material.dart';
import 'package:health_bloom/main.dart';
import 'package:health_bloom/view/login/login.dart';
import 'package:health_bloom/view/splash/splash_screen.dart';
import '../../view/family_members/family_members.dart';
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
                      CircleAvatar(
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
                          "Jane Doe",
                          style: TextStyle(fontSize: 20, color: kWhite),
                        ),
                      )
                    ],
                  ),
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
                  onTap: () {},
                  selected: widget.selected == 2,
                  icon: Icons.track_changes,
                ),
                DrawerContainerWidget(
                  text: "Documents",
                  onTap: () {},
                  selected: widget.selected == 3,
                  icon: Icons.picture_as_pdf,
                ),
                DrawerContainerWidget(
                  text: "Family Members",
                  onTap: () {
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
                  onTap: () async{
                    await _handleSignOut();
                    sp.clear();
                    Navigator.push(context, MaterialPageRoute(builder: (context){
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

  Future<void> _handleSignOut() => googleSignIn.disconnect();
}
