import 'package:flutter/material.dart';
import 'package:health_bloom/components/bottom_item.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      // backgroundColor: Colors.white,
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
              // color: Colors.transparent,
              decoration: BoxDecoration(
                // color: Colors.white,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: BottomItem(
                      icon: Icons.home,
                      color: currentIndex == 0 ? Colors.black : Colors.black12,
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
                  Expanded(
                    child: BottomItem(
                      icon: Icons.menu_book,
                      color: currentIndex == 1 ? Colors.black : Colors.black12,
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
                      color: currentIndex == 10 ? Colors.black : Colors.black12,
                      onPressed: () {
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
                      color: currentIndex == 2 ? Colors.black : Colors.black12,
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
                      color: currentIndex == 3 ? Colors.black : Colors.black12,
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
                      color: currentIndex == 4 ? Colors.black : Colors.black12,
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
