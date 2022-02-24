import 'package:flutter/material.dart';
import 'package:health_bloom/components/textbuilder.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 250,
                      width: double.infinity,
                      color: Color(0xff7059B1),
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
                          padding: const EdgeInsets.only(top: 5),
                          child: TextBuilder(
                            text: 'Forgot Password',
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(height: 30, width: 30)
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
                      top: -10,
                      left: 60,
                      child: Image.asset(
                        'assets/icons/cloud-computing.png',
                        height: 40,
                        width: 40,
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 60,
                      child: Image.asset(
                        'assets/icons/cloud-computing.png',
                        height: 30,
                        width: 30,
                      ),
                    ),
                    Positioned(
                      top: 60,
                      right: 80,
                      child: Image.asset(
                        'assets/icons/cloud-computing.png',
                        height: 20,
                        width: 20,
                      ),
                    ),
                    Positioned(
                      bottom: 50,
                      left: 60,
                      child: Image.asset(
                        'assets/icons/tree.png',
                        height: 20,
                        width: 20,
                      ),
                    ),
                    Positioned(
                      bottom: 60,
                      right: 50,
                      child: Image.asset(
                        'assets/icons/tree.png',
                        height: 45,
                        width: 45,
                      ),
                    )
                  ],
                ),
                // const SizedBox(height: 25.0),
                Expanded(
                  child: Form(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 55),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 80.0),
                          Container(
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              style: TextStyle(
                                color: Color(0xff8D68F5),
                              ),
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                                label:
                                    TextBuilder(text: 'Enter Registered Email'),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 60.0),
                          MaterialButton(
                            minWidth: double.infinity,
                            height: 45,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Color(0xff855FF7),
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             ForgotPasswordOtp()));
                            },
                            child: TextBuilder(
                              text: 'SUBMIT',
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 100.0),
                          Center(
                            child: InkWell(
                              onTap: () {},
                              child: CircleAvatar(
                                backgroundColor: Color(0xff9378E2),
                                radius: 15,
                                child: Icon(
                                  Icons.chevron_right,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
