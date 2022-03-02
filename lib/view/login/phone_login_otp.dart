import 'package:flutter/material.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PhoneLoginOtp extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController phoneNumber;
  const PhoneLoginOtp({Key key, this.controller,this.phoneNumber}) : super(key: key);

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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                        color: Colors.black,
                        size: 35,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: TextBuilder(
                        text: 'Verification Code',
                        color: Color(0xff494949),
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(height: 30, width: 30)
                  ],
                ),
                Form(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 35),
                    child: Column(
                      children: [
                        const SizedBox(height: 10.0),
                        TextBuilder(
                          text: 'Verify your Number',
                          color: Color(0xff494949),
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(height: 15.0),
                        TextBuilder(
                          text: "we'll text you on ${widget.phoneNumber.text}",
                          color: Color(0xff695F61),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(height: 50.0),
                        TextBuilder(
                          text: "Enter OTP",
                          color: Color(0xff695F61),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(height: 20.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 20),
                          child: PinCodeTextField(
                            keyboardType: TextInputType.number,
                            length: 6,
                            obscureText: false,
                            animationType: AnimationType.fade,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.underline,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 50,
                              fieldWidth: 40,
                              activeFillColor: Colors.white,
                            ),
                            animationDuration: Duration(milliseconds: 300),
                            controller: widget.controller,
                            onCompleted: (v) {
                              print("Completed");
                            },
                            onChanged: (value) {
                              // print(value);
                              // setState(() {
                              //   currentText = value;
                              // });
                            },
                            beforeTextPaste: (text) {
                              print("Allowing to paste $text");
                              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                              //but you can show anything you want here, like your pop up saying wrong paste format or etc
                              return true;
                            },
                            appContext: context,
                          ),
                        ),
                        // TextField(
                        //   controller: widget.controller,
                        //   maxLength: 6,
                        //   keyboardType: TextInputType.number,
                        //   decoration: InputDecoration(
                        //
                        //   ),
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     OTPCodeInput(
                        //         controller: otp1, first: true, last: false),
                        //     OTPCodeInput(
                        //         controller: otp2, first: false, last: false),
                        //     OTPCodeInput(
                        //         controller: otp3, first: false, last: false),
                        //     OTPCodeInput(
                        //         controller: otp4, first: false, last: true),
                        //   ],
                        // ),
                        const SizedBox(height: 20.0),
                        // Divider(
                        //   height: 1,
                        //   thickness: 1,
                        // ),
                        const SizedBox(height: 15.0),
                        TextBuilder(
                          text: "Resend OTP ?",
                          color: Color(0xff7561B3),
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                        const SizedBox(height: 50.0),
                        MaterialButton(
                          minWidth: 250,
                          height: 45,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: Color(0xff855FF7),
                          onPressed: () {
                            if (widget.controller.text.length == 6) {
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Invalid OTP"),
                              ));
                            }
                          },
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
                // const SizedBox(height: 40.0),
                // Center(
                //   child: TextBuilder(
                //     text:
                //         'We will send to you a verification code to \nyour phone number',
                //     textAlign: TextAlign.center,
                //     color: Color(0xff695F61),
                //   ),
                // ),
                // const SizedBox(height: 20.0),
                // Center(
                //   child: InkWell(
                //     onTap: () {},
                //     child: CircleAvatar(
                //       backgroundColor: Color(0xff9577E2),
                //       radius: 15,
                //       child: Icon(
                //         Icons.chevron_right,
                //         color: Colors.white,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
