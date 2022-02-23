import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/view/homepage/home_page.dart';
import 'package:health_bloom/view/login/forgot_password.dart';
import 'package:health_bloom/view/login/phone_login.dart';
import 'package:health_bloom/view/signup/signup.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xff8560F6),
            Color(0xff9672F8),
          ], begin: Alignment.centerLeft, end: Alignment.centerRight),
        ),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
              child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(18.0),
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextBuilder(
                      text: "Already \nhave an \nAccount ?",
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                    Image.asset(
                      'assets/icons/first-aid-box.png',
                      height: 100,
                      width: 100,
                    )
                  ],
                ),
                const SizedBox(height: 50.0),
                Card(
                  margin: EdgeInsets.zero,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      height: 280,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              style: TextStyle(
                                color: Color(0xff4F17BD),
                              ),
                              decoration: InputDecoration(
                                label: TextBuilder(text: 'Name'),
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  // color: Color(0xff675F5E),
                                ),
                                suffixIcon: Icon(Icons.person),
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
                                color: Color(0xff4F17BD),
                              ),
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  // color: Color(0xff675F5E),
                                ),
                                label: TextBuilder(text: 'Password'),
                                suffixIcon: Icon(Icons.lock),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPassword()));
                                },
                                child: TextBuilder(
                                  text: 'Forgot Password ?',
                                  color: Color(0xff856DBE),
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                          Expanded(child: SizedBox()),
                          MaterialButton(
                            minWidth: 180,
                            height: 40,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            color: Color(0xff9378E2),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            },
                            child: TextBuilder(
                              text: 'SIGN IN',
                              wordSpacing: 2,
                              latterSpacing: 1.3,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          width: double.infinity,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      TextBuilder(
                        text: 'Or Signin With',
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Container(
                          height: 1,
                          width: double.infinity,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Image.asset(
                        'assets/icons/google.png',
                        height: 25,
                        width: 25,
                      ),
                    ),
                    const SizedBox(width: 30.0),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PhoneLogin(),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: Image.asset(
                          'assets/icons/mobile-app.png',
                          height: 25,
                          width: 25,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'New User ? ',
                      style: TextStyle(),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Signup Here',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignUp(),
                                    ),
                                  )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        style: TextStyle(
          color: Color(0xff4F17BD),
        ),
        decoration: InputDecoration(
          label: TextBuilder(text: 'Name'),
          labelStyle: TextStyle(
            fontWeight: FontWeight.w500,
            // color: Color(0xff675F5E),
          ),
          suffixIcon: Icon(Icons.person),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
