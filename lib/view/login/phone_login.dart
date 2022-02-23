import 'package:flutter/material.dart';
import 'package:health_bloom/components/textbuilder.dart';

class PhoneLogin extends StatelessWidget {
  const PhoneLogin({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4ECFE),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            // padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.asset('assets/images/shape-1.png'),
                    Row(
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
                        TextBuilder(
                          text: 'Verification Code',
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                        ),
                        Container(height: 30, width: 30)
                      ],
                    ),
                    Positioned(
                      bottom: 40,
                      left: 50,
                      right: 50,
                      child: Image.asset(
                        'assets/icons/emails.png',
                        height: 100,
                        width: 100,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Colors.white,
                    child: Form(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 35),
                        child: Column(
                          children: [
                            TextFormField(
                              style: TextStyle(
                                fontFamily: 'GoogleSans',
                                color: Color(0xff8D68F5),
                              ),
                              decoration: InputDecoration(
                                label: TextBuilder(text: 'INDIA (+91)'),
                                suffixIcon: InkWell(
                                  onTap: () {},
                                  child: RotatedBox(
                                      quarterTurns: 1,
                                      child: Icon(
                                        Icons.chevron_right,
                                        size: 30,
                                      )),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            TextFormField(
                              style: TextStyle(
                                fontFamily: 'GoogleSans',
                                color: Color(0xff8D68F5),
                              ),
                              decoration: InputDecoration(
                                label: TextBuilder(text: 'Number'),
                                suffixIcon: Icon(Icons.phone),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            MaterialButton(
                              minWidth: 190,
                              height: 40,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              color: Color(0xff9479E6),
                              onPressed: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => PhoneLoginOtp()));
                              },
                              child: TextBuilder(
                                text: 'SIGN IN',
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
                const SizedBox(height: 20.0),
                Center(
                  child: TextBuilder(
                    text:
                        'We will send to you a verification code to \nyour phone number',
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10.0),
                Center(
                  child: InkWell(
                    onTap: () {},
                    child: CircleAvatar(
                      backgroundColor: Color(0xff9479E6),
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
    );
  }
}
