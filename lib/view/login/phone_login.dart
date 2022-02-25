import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/utils/loading.dart';
import 'package:health_bloom/view/homepage/home_page.dart';
import 'package:health_bloom/view/login/phone_login_otp.dart';

import '../../main.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({Key key}) : super(key: key);

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController countryCode = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController otpCode = TextEditingController();
  bool isLoading = false;
  String verificationId;

  Future<void> phoneSignIn({String phoneNumber}) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: _onVerificationCompleted,
        verificationFailed: _onVerificationFailed,
        codeSent: _onCodeSent,
        codeAutoRetrievalTimeout: _onCodeTimeout);
  }

  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    print("verification completed ${authCredential.smsCode}");
    User user = FirebaseAuth.instance.currentUser;
    setState(() {
      this.otpCode.text = authCredential.smsCode;
    });
    if (authCredential.smsCode != null) {
      try{
        UserCredential credential =
        await user.linkWithCredential(authCredential);
      }on FirebaseAuthException catch(e){
        if(e.code == 'provider-already-linked'){
          await _auth.signInWithCredential(authCredential);
        }
      }
      setState(() {
        isLoading = false;
      });
      // Navigator.pushNamedAndRemoveUntil(
      //     context, Constants.homeNavigate, (route) => false);
    }
  }

  _onVerificationFailed(FirebaseAuthException exception) {
    if (exception.code == 'invalid-phone-number') {
      showMessage("The phone number entered is invalid!");
    }
  }

  _onCodeSent(String verificationId, int forceResendingToken) async{
    this.verificationId = verificationId;
    print(forceResendingToken);
    print("code sent");

    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PhoneLoginOtp(
                  controller: otpCode,
                )));

    if(otpCode.text.length == 6){

      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otpCode.text);

      UserCredential user = await _auth.signInWithCredential(credential);
      if(user != null){
        if(user.user != null){
          print(user.user.uid);
          print(user.user.phoneNumber);
          sp.setString("id", user.user.uid);
          sp.setString("email", user.user.phoneNumber);
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return HomePage();
          }));
        }
      }
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  _onCodeTimeout(String timeout) {
    return null;
  }

  void showMessage(String errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(errorMessage),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () async {
                  Navigator.of(builderContext).pop();
                },
              )
            ],
          );
        }).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffF4ECFE),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                child: Form(
                  key: _formKey,
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
                              child: Column(
                                children: [
                                  const SizedBox(height: 15.0),
                                  Container(
                                    height: 48,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextFormField(
                                      controller: countryCode,
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
                                      controller: phoneNumber,
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
                                      setState(() {
                                        isLoading = true;
                                      });
                                      phoneSignIn(phoneNumber: "${countryCode.text}${phoneNumber.text}");
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
              if(isLoading)
                LoadingWidget()
            ],
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
