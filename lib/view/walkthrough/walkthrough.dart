import 'package:flutter/material.dart';
import 'package:health_bloom/controller/walkthrough_controller.dart';
import 'package:health_bloom/utils/colors.dart';

import '../signup/signup.dart';

class Walkthrough extends StatefulWidget {
  const Walkthrough({Key key}) : super(key: key);

  @override
  State<Walkthrough> createState() => _WalkthroughState();
}

class _WalkthroughState extends State<Walkthrough> {
  PageController _controller = PageController();
  final walks = WalkthroughController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                color: kMainColor,
              ),
              Positioned(
                top: 50,
                bottom: 10,
                left: -200,
                right: -100,
                child: SafeArea(
                  child: RotationTransition(
                    turns: new AlwaysStoppedAnimation(15 / 360),
                    child: ClipOval(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.9,
                        width: (MediaQuery.of(context).size.height * 0.9) * 0.9,
                        color: kWhite.withOpacity(0.3),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                bottom: 50,
                left: -80,
                right: -50,
                child: SafeArea(
                  child: RotationTransition(
                    turns: new AlwaysStoppedAnimation(20 / 360),
                    child: ClipOval(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.9,
                        width: (MediaQuery.of(context).size.height * 0.9),
                        color: kWhite.withOpacity(0.9),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: PageView(
                        controller: _controller,
                        onPageChanged: (i) {
                          currentIndex = i;
                          setState(() {});
                        },
                        children: List.generate(
                            walks.walkthrough.length,
                            (index) => Container(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40),
                                        child: Image.asset(
                                          walks.walkthrough[index].image ?? "",
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.35,
                                        ),
                                      ),
                                      Spacer(),
                                      Column(
                                        children: [
                                          Text(
                                            walks.walkthrough[index].title ??
                                                "",
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: kMainColor,
                                                fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                            height: 14,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 40),
                                            child: Text(
                                              walks.walkthrough[index]
                                                      .description ??
                                                  "",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: kGreyText,
                                                  fontWeight: FontWeight.w400),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: Container(
                        height: 25,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 25,
                              child: Center(
                                child: AnimatedContainer(
                                  height: currentIndex == 0 ? 18 : 13,
                                  width: currentIndex == 0 ? 18 : 13,
                                  duration: Duration(milliseconds: 200),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: currentIndex == 0
                                          ? kMainColor
                                          : kGreyLite),
                                ),
                              ),
                            ),
                            Container(
                              width: 25,
                              child: Center(
                                child: AnimatedContainer(
                                  height: currentIndex == 1 ? 18 : 13,
                                  width: currentIndex == 1 ? 18 : 13,
                                  duration: Duration(milliseconds: 200),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: currentIndex == 1
                                          ? kMainColor
                                          : kGreyLite),
                                ),
                              ),
                            ),
                            Container(
                              width: 25,
                              child: Center(
                                child: AnimatedContainer(
                                  height: currentIndex == 2 ? 18 : 13,
                                  width: currentIndex == 2 ? 18 : 13,
                                  duration: Duration(milliseconds: 200),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: currentIndex == 2
                                          ? kMainColor
                                          : kGreyLite),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: 24,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Container(
                        height: 30,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            color: Color(0xffFEFFFF),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6),
                                bottomLeft: Radius.circular(6))),
                        child: Center(
                          child: Text(
                            " Skip ",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
