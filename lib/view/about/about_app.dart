import 'package:flutter/material.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/utils/colors.dart';

import '../../utils/drawer/custom_drawer.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({Key key}) : super(key: key);

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  final PageController pageController =
      PageController(initialPage: 0, keepPage: true);
  int selectedIndex = 0;
  List<String> _aboutInfo = [
    "Get to a healthier and more active life with the new Health Bloom \n\nIt's hard to know how much or what kind of activity you need to stay healthy. That's why Health Bloom is here, an activity goal that can help improve your health.",
    "Pratham satnalika, a 13-year-old entrepreneur founded Health Bloom to help people through activities goals that can help improve their health. \n\nIt's hard to know how much or what kind of activity you need to stay healthy.That's why Health Bloom is here."
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      drawer: CustomDrawer(
        selected: 7,
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffFAFAFA),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Color(0xff8E72DB),
          ),
        ),
        title: TextBuilder(
          text: "About Us",
          color: Color(0xff8E72DB),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        child: PageView.builder(
          itemCount: _aboutInfo.length,
          controller: pageController,
          physics: ScrollPhysics(),
          onPageChanged: (val) {
            selectedIndex = val;
            setState(() {});
          },
          itemBuilder: (context, i) {
            return Container(
              margin: EdgeInsets.only(right: 8),
              padding: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: Color(0xffFAFAFA),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Stack(
                // alignment: Alignment.bott,
                fit: StackFit.loose,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.lightGreen,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.89,
                    height: 615,
                    decoration: BoxDecoration(
                      color: Color(0xffA383FC),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.89,
                        // height: 280,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Color(0xffD4C9F4),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextBuilder(
                          text: _aboutInfo[i],
                          fontSize: 20,
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.center,
                          color: kBlack,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 10,
                    child: Container(
                      // color: Colors.lightGreen,
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/icons/over-shape-logo.png',
                            height: 200,
                            width: 200,
                          ),
                          const SizedBox(height: 10.0),
                          TextBuilder(
                            text: 'Health Bloom',
                            color: Colors.white,
                            fontSize: 25,
                            wordSpacing: 2,
                            fontWeight: FontWeight.w700,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
