import 'package:flutter/material.dart';
import 'package:health_bloom/components/otp_code_input.dart';
import 'package:health_bloom/components/textbuilder.dart';

class PhoneLoginOtp extends StatefulWidget {
  const PhoneLoginOtp({Key? key}) : super(key: key);

  @override
  State<PhoneLoginOtp> createState() => _PhoneLoginOtpState();
}

class _PhoneLoginOtpState extends State<PhoneLoginOtp> {
  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            // padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.chevron_left,
                        color: Colors.black,
                        size: 35,
                      ),
                    ),
                    TextBuilder(
                      text: 'Verification Code',
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                    Container(height: 30, width: 30)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Form(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 35),
                      child: Column(
                        children: [
                          const SizedBox(height: 10.0),
                          TextBuilder(
                            text: 'Verify your Number',
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                          const SizedBox(height: 15.0),
                          TextBuilder(
                            text: "we'll text you on 0878787878",
                            color: Colors.black87,
                            fontSize: 12,
                          ),
                          const SizedBox(height: 50.0),
                          TextBuilder(
                            text: "Enter OTP",
                            color: Colors.black45,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              OTPCodeInput(
                                  hideIndicator:
                                      otp1.text.isEmpty ? true : false,
                                  controller: otp1,
                                  first: true,
                                  last: false),
                              OTPCodeInput(
                                  hideIndicator:
                                      otp2.text.isEmpty ? true : false,
                                  controller: otp2,
                                  first: false,
                                  last: false),
                              OTPCodeInput(
                                  hideIndicator:
                                      otp3.text.isEmpty ? true : false,
                                  controller: otp3,
                                  first: false,
                                  last: false),
                              OTPCodeInput(
                                  hideIndicator:
                                      otp4.text.isEmpty ? true : false,
                                  controller: otp4,
                                  first: false,
                                  last: true),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          TextBuilder(
                            text: "Resend OTP ?",
                            color: Color(0xff9479E6),
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                          Divider(),
                          const SizedBox(height: 50.0),
                          MaterialButton(
                            minWidth: 250,
                            height: 45,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Color(0xff9479E6),
                            onPressed: () {},
                            child: TextBuilder(
                              text: 'SUBMIT OTP',
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          )
                        ],
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
