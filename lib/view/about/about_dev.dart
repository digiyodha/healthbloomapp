import 'package:flutter/material.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/utils/colors.dart';

import '../../utils/drawer/custom_drawer.dart';

class AboutDev extends StatelessWidget {
  const AboutDev({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String info =
        "Turtle Techsai is an organized team of passionate software developers bringing to you with us the intensive experience in software development to deliver flawless, efficient, and effective products to boost your business.\n\nWe specialize in building robust and scalable Web Apps, mobile application.";
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
          text: "About Developer",
          color: Color(0xff8E72DB),
        ),
        centerTitle: true,
      ),
      body: Container(
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
              height: 500,
              width: MediaQuery.of(context).size.width,
              // color: Colors.lightGreen,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.89,
              height: 470,
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
                  height: 310,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Color(0xffD4C9F4),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextBuilder(
                    text: info,
                    fontSize: 20,
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                    color: kBlack,
                    // textOverflow: TextOverflow.fade,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 110,
              width: 150,
              top: 20,
              child: Image.asset(
                'assets/icons/logo.png',
                height: 150,
                width: 150,
              ),
            )
          ],
        ),
      ),
    );
  }
}
