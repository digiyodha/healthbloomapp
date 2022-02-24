import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:health_bloom/controller/walkthrough_controller.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:health_bloom/view/login/login.dart';

import '../../components/custom_contained_button.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Image.asset(
              "assets/icons/logo.png",
              height: 100,
              width: 100,
            ),
            Expanded(
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
                              Column(
                                children: [
                                  Text(
                                    walks.walkthrough[index].title ?? "",
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
                                      walks.walkthrough[index].description ??
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
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Image.asset(
                                      walks.walkthrough[index].image ?? ""),
                                ),
                              ),
                            ],
                          ),
                        )),
              ),
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
                              color:
                                  currentIndex == 0 ? kMainColor : kGreyLite),
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
                              color:
                                  currentIndex == 1 ? kMainColor : kGreyLite),
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
                              color:
                                  currentIndex == 2 ? kMainColor : kGreyLite),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 65),
              child: CustomContainedButton(
                height: 58,
                textSize: 16,
                disabledColor: kGreyLite,
                text: "Get Started",
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SignUp();
                  }));
                },
                width: double.infinity,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            RichText(
              text: TextSpan(
                  text: "Already have account?",
                  style: TextStyle(
                      fontSize: 14,
                      color: kGreyText,
                      fontWeight: FontWeight.w500),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Login();
                            })),
                      text: " Sign in",
                      style: TextStyle(
                          fontSize: 14,
                          color: kMainColor,
                          fontWeight: FontWeight.w600),
                    )
                  ]),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
