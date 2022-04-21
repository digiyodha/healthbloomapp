import 'package:flutter/material.dart';
import 'package:health_bloom/components/bottom_item.dart';
import 'package:health_bloom/utils/colors.dart';

import 'package:health_bloom/utils/custom_add_element_bs.dart';
import 'package:health_bloom/view/homepage/home_page.dart';
import 'package:health_bloom/view/journal/journal.dart';
import 'package:health_bloom/view/new_medicine/new_medicine.dart';
import 'package:health_bloom/view/places/nearby_places.dart';
import 'package:health_bloom/view/profile/profile.dart';

class MainView extends StatefulWidget {
  const MainView({Key key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentIndex = 0;

  PageController controller;
  final GlobalKey<ScaffoldState> key = GlobalKey();
  List<Widget> _pages = [
    HomePage(),
    Journal(),
    NearbyPlaces(),
    Profile(),
    NewMedicine(),
  ];

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0, keepPage: true);
  }

  Color _activeColor = kMainColor;
  Color _inActiveColor = Colors.black12;
  @override
  Widget build(BuildContext context) {
    // Upgrader().clearSavedSettings();
    return Scaffold(
      key: key,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: _pages.length,
              controller: controller,
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: (val) {
                setState(() {
                  currentIndex = val;
                  print('currentIndex $currentIndex');
                });
              },
              itemBuilder: (context, index) {
                return _pages[index];
              },
            ),
          ),
          Material(
            elevation: 100,
            color: Colors.white,
            // shadowColor: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            // margin: EdgeInsets.zero,
            child: Container(
              height: 60,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset:
                        Offset(-2.0, -2.0), // shadow direction: bottom right
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      child: BottomItem(
                        icon: Icons.home,
                        height: currentIndex == 0 ? 45 : 35,
                        color:
                            currentIndex == 0 ? _activeColor : _inActiveColor,
                        onPressed: () {
                          setState(() {
                            currentIndex = 0;
                            controller.animateToPage(0,
                                duration: Duration(milliseconds: 400),
                                curve: Curves.ease);
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: BottomItem(
                      icon: Icons.menu_book,
                      height: currentIndex == 1 ? 45 : 35,
                      color: currentIndex == 1 ? _activeColor : _inActiveColor,
                      onPressed: () {
                        setState(() {
                          currentIndex = 1;
                          controller.animateToPage(1,
                              duration: Duration(milliseconds: 400),
                              curve: Curves.decelerate);
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: BottomItem(
                      icon: Icons.add,
                      height: currentIndex == 10 ? 45 : 35,
                      color: currentIndex == 10 ? _activeColor : _inActiveColor,
                      onPressed: () {
                        setState(() {
                          currentIndex = 10;
                          // controller.animateToPage(10,
                          //     duration: Duration(milliseconds: 400),
                          //     curve: Curves.decelerate);
                        });
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext bc) {
                            return CustomAddElementBs(
                              onChanged: () {
                                setState(() {
                                  Navigator.pop(context);

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          maintainState: true,
                                          builder: (context) {
                                            return MainView();
                                          }));
                                });
                              },
                            );
                          },
                        ).whenComplete(() => setState(() {}));
                      },
                    ),
                  ),
                  Expanded(
                    child: BottomItem(
                      icon: Icons.list,
                      height: currentIndex == 2 ? 45 : 35,
                      color: currentIndex == 2 ? _activeColor : _inActiveColor,
                      onPressed: () {
                        setState(() {
                          currentIndex = 2;
                          controller.animateToPage(2,
                              duration: Duration(milliseconds: 400),
                              curve: Curves.decelerate);
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: BottomItem(
                      icon: Icons.person,
                      height: currentIndex == 3 ? 45 : 35,
                      color: currentIndex == 3 ? _activeColor : _inActiveColor,
                      onPressed: () {
                        setState(() {
                          currentIndex = 3;
                          controller.animateToPage(3,
                              duration: Duration(milliseconds: 400),
                              curve: Curves.decelerate);
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: BottomItem(
                      icon: Icons.medication,
                      height: currentIndex == 4 ? 45 : 35,
                      color: currentIndex == 4 ? _activeColor : _inActiveColor,
                      onPressed: () {
                        setState(() {
                          currentIndex = 4;
                          controller.animateToPage(4,
                              duration: Duration(milliseconds: 400),
                              curve: Curves.decelerate);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
