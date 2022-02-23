import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/controller/walkthrough_controller.dart';
import 'package:health_bloom/view/login/login.dart';

class Walkthrough extends StatefulWidget {
  const Walkthrough({Key? key}) : super(key: key);

  @override
  State<Walkthrough> createState() => _WalkthroughState();
}

class _WalkthroughState extends State<Walkthrough> {
  CarouselController controller = CarouselController();
  final walks = WalkthroughController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          child: Stack(
            children: [
              CarouselSlider.builder(
                carouselController: controller,
                itemCount: walks.walkthrough.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        Container(
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          walks.walkthrough[itemIndex].image!,
                          height: 220,
                          width: 220,
                        ),
                      ),
                      TextBuilder(
                        text: walks.walkthrough[itemIndex].title,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffA183F6),
                      ),
                      const SizedBox(height: 15.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextBuilder(
                          text: walks.walkthrough[itemIndex].description,
                          color: Color(0xff5A5554),
                          height: 1.5,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.8,
                  // enlargeCenterPage: true,
                  viewportFraction: 1,
                  // autoPlay: true,
                  onPageChanged: (index, rv) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
              ),
              Positioned(
                bottom: 80,
                left: 50,
                right: 50,
                child: SizedBox(
                  height: 15,
                  child: Center(
                    child: ListView.builder(
                      itemCount: walks.walkthrough.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            height: currentIndex == index ? 20 : 12,
                            width: currentIndex == index ? 20 : 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentIndex == index
                                  ? Color(0xffA183F6)
                                  : Color(0xffC5C5C5),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 0,
                child: Align(
                  alignment: Alignment.topRight,
                  child: MaterialButton(
                    elevation: 0,
                    minWidth: 10,
                    clipBehavior: Clip.antiAlias,
                    height: 30,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6),
                        bottomLeft: Radius.circular(6),
                      ),
                    ),
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: TextBuilder(
                      text: "Let's Go",
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
