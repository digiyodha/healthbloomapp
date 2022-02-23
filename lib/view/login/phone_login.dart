import 'package:flutter/material.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/view/login/phone_login_otp.dart';

class PhoneLogin extends StatelessWidget {
  const PhoneLogin({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffF4ECFE),
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
                    ClipPath(
                      clipper: OvalBottomBorderClipper(),
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        color: Color(0xffA183F6),
                      ),
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
                            text: 'Verification Code',
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(height: 30, width: 30)
                      ],
                    ),
                    Positioned(
                      bottom: 30,
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
                const SizedBox(height: 25.0),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 6,
                      shadowColor: Color(0xffC2B4DF),
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          // color: Colors.green,
                          shape: BoxShape.rectangle,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Form(
                          child: Column(
                            children: [
                              const SizedBox(height: 15.0),
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
                                    label: TextBuilder(text: 'INDIA (+91)'),
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
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
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20.0),
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
                                    label: TextBuilder(text: 'Number'),
                                    suffixIcon: Icon(Icons.phone),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25.0),
                              Expanded(child: SizedBox()),
                              MaterialButton(
                                minWidth: 190,
                                height: 40,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                color: Color(0xff9378E2),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PhoneLoginOtp()));
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
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: TextBuilder(
                    text:
                        'We will send to you a verification code to \nyour phone number',
                    textAlign: TextAlign.center,
                    color: Color(0xff695F61),
                  ),
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: InkWell(
                    onTap: () {},
                    child: CircleAvatar(
                      backgroundColor: Color(0xff9577E2),
                      radius: 15,
                      child: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OvalBottomBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 70);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(
        size.width - size.width / 4, size.height, size.width, size.height - 70);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
