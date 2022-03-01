import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../view/homepage/home_page.dart';
import '../view/profile/profile.dart';
import 'colors.dart';

class CustomBnb extends StatelessWidget {
  final int current;
  const CustomBnb({Key key,this.current = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar(
      elevation: 20,
      height: 60,
      icons: [
        Icons.home,
        Icons.mic_rounded,
        Icons.list,
        Icons.person,
      ],
      activeIndex: current,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.defaultEdge,
      leftCornerRadius: 32,
      rightCornerRadius: 32,
      onTap: (index) {
        if(index == 0){
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return HomePage();
          }));
        }
        if(index == 3){
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return Profile();
          }));
        }
      },
      activeColor: kBlack,
      inactiveColor: kGreyLite,
      //other params
    );
  }
}
