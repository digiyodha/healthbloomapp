import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/view/homepage/home_page.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                color: Color(0xffA283F9),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: TextBuilder(
                      text: 'Edit Profile',
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    height: 35,
                    width: 35,
                  )
                ],
              ),
              Positioned(
                bottom: 70,
                left: 50,
                right: 50,
                child: Image.asset(
                  'assets/icons/verified.png',
                  height: 120,
                  width: 120,
                ),
              ),
              Positioned(
                top: 150,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 55),
                    child: Form(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 50.0),
                            TextFormField(
                              style: TextStyle(
                                color: Color(0xff9884DF),
                              ),
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff9884DF),
                                ),
                                label: TextBuilder(text: 'Phone Number'),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 15),
                                suffixIcon: Icon(
                                  Icons.phone,
                                  color: Color(0xff9884DF),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            TextFormField(
                              style: TextStyle(
                                color: Color(0xff9884DF),
                              ),
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff9884DF),
                                ),
                                label: TextBuilder(text: 'Address'),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 15),
                                suffixIcon: Icon(
                                  Icons.gps_fixed,
                                  color: Color(0xff9884DF),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            TextFormField(
                              style: TextStyle(
                                color: Color(0xff9884DF),
                              ),
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff9884DF),
                                ),
                                label: TextBuilder(text: 'City'),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 15),
                                suffixIcon: Icon(
                                  Icons.gps_fixed,
                                  color: Color(0xff9884DF),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            TextFormField(
                              style: TextStyle(
                                color: Color(0xff9884DF),
                              ),
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff9884DF),
                                ),
                                label: TextBuilder(text: 'State'),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 15),
                                suffixIcon: Icon(
                                  Icons.gps_fixed,
                                  color: Color(0xff9884DF),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            TextFormField(
                              style: TextStyle(
                                color: Color(0xff9884DF),
                              ),
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff9884DF),
                                ),
                                label: TextBuilder(text: 'Blood Group'),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 15),
                                suffixIcon: Icon(
                                  Icons.opacity,
                                  color: Color(0xff9884DF),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 50.0),
                            MaterialButton(
                              minWidth: double.infinity,
                              height: 45,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: Color(0xff855FF7),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()));
                              },
                              child: TextBuilder(
                                text: 'SUBMIT',
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 105,
                left: 135,
                right: 135,
                child: InkWell(
                  onTap: () {},
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: EdgeInsets.zero,
                    elevation: 5,
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xff531C9D)),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: Icon(
                        FontAwesomeIcons.userPlus,
                        color: Color(0xff8064E1),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
