import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/main.dart';
import 'package:health_bloom/model/request/request.dart';
import 'package:health_bloom/model/response/response.dart';
import 'package:health_bloom/services/api/repository/auth_repository.dart';
import 'package:health_bloom/utils/loading.dart';
import 'package:health_bloom/view/homepage/home_page.dart';
import 'package:health_bloom/view/login/forgot_password.dart';
import 'package:health_bloom/view/login/phone_login.dart';
import 'package:health_bloom/view/signup/signup.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool showPassword = true;
  GoogleSignInAccount _currentUser;
  bool _loading = false;

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  Future loginUser(RegisterLoginRequest request) async {
    setState(() {
      _loading = true;
    });
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    RegisterLoginResponse _response = await adminAPI.loginAPI(request);
    if (_response.success == true) {
      sp.setString('id', _response.data.id);
      sp.setString('email', _response.data.emailId);
      sp.setString('name', _response.data.name);
      sp.setString('xAuthToken', _response.data.xAuthToken);
      sp.setString('profileImage', _response.data.avatar ?? "");
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (Route<dynamic> route) => false,
      );
    } else {
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(_response.error.toString()),
      ));
    }
    setState(() {
      _loading = false;
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    return null;
  }

  Future<UserCredential> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      // Create a credential from the access token
      try {
        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken.token);
        // Once signed in, return the UserCredential
        return await FirebaseAuth.instance.signInWithCredential(credential);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
        ));
      }
    } else {
      print("******************************************************");
      print(result.message);
      print(result.status);
      print(result.accessToken);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(result.message),
      ));
      setState(() {
        _loading = false;
      });
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    // _email.text = 'omprakash@gmail.com';
    // _password.text = '12345';
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GoogleSignInAccount user = _currentUser;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xff8C67F5),
                Color(0xff8C67F5),
              ], begin: Alignment.centerLeft, end: Alignment.centerRight),
            ),
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SafeArea(
                  child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(18.0),
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Positioned(
                      top: -10,
                      right: 0,
                      child: Image.asset(
                        'assets/icons/auth_logo.png',
                        height: 150,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 14.0),
                        TextBuilder(
                          text: "Already \nhave an \nAccount ?",
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
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
                                  const SizedBox(height: 10.0),
                                  Container(
                                    height: 48,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextFormField(
                                      controller: _email,
                                      autofillHints: {AutofillHints.email},
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(40),
                                      ],
                                      // validator: (value) {
                                      //   if (value == null || value.isEmpty) {
                                      //     return "* Required";
                                      //   } else
                                      //     return null;
                                      // },
                                      style: TextStyle(
                                        color: Color(0xff4F17BD),
                                      ),
                                      decoration: InputDecoration(
                                        label: TextBuilder(text: 'Email'),
                                        contentPadding: EdgeInsets.all(10),
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
                                      controller: _password,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(16),
                                      ],
                                      // validator: (value) {
                                      //   if (value == null || value.isEmpty) {
                                      //     return "* Required";
                                      //   } else
                                      //     return null;
                                      // },
                                      obscureText: showPassword,
                                      style: TextStyle(
                                        color: Color(0xff4F17BD),
                                      ),
                                      decoration: InputDecoration(
                                        labelStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          // color: Color(0xff675F5E),
                                        ),
                                        label: TextBuilder(text: 'Password'),
                                        contentPadding: EdgeInsets.all(10),
                                        suffixIcon: InkWell(
                                            onTap: () {
                                              setState(() {
                                                showPassword = !showPassword;
                                              });
                                            },
                                            child: Icon(Icons.lock)),
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
                                    onPressed: () async {
                                      if (_email.text.isNotEmpty &&
                                          _password.text.isNotEmpty) {
                                        try {
                                          setState(() {
                                            _loading = true;
                                          });
                                          final UserCredential user =
                                              await _auth
                                                  .signInWithEmailAndPassword(
                                            email: _email.text,
                                            password: _password.text,
                                          );
                                          String msgToken = await FirebaseMessaging.instance.getToken();
                                          print(msgToken);
                                          if (user.user.emailVerified) {

                                            await loginUser(RegisterLoginRequest(
                                                name: _auth.currentUser
                                                        .displayName ??
                                                    "",
                                                emailId:
                                                    _auth.currentUser.email ??
                                                        "",
                                                uid: _auth.currentUser.uid,
                                                avatar: _auth
                                                        .currentUser.photoURL ??
                                                    "",
                                                phoneNumber: null,
                                                countryCode: null,
                                            fcmToken: msgToken));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Please verify yourself through the verification link sent on your Email."),
                                            ));
                                            setState(() {
                                              _loading = false;
                                            });
                                          }
                                        } on FirebaseAuthException catch (e) {
                                          if (e.code == 'user-not-found') {
                                            setState(() {
                                              _loading = false;
                                            });
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  'No user found for that email.'),
                                            ));
                                          } else if (e.code ==
                                              'wrong-password') {
                                            setState(() {
                                              _loading = false;
                                            });
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Wrong password provided for that user.'),
                                            ));
                                          }
                                        }
                                      } else {
                                        setState(() {
                                          _loading = false;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              'Please fill all the details'),
                                        ));
                                      }
                                    },
                                    child: TextBuilder(
                                      text: 'SIGN IN',
                                      wordSpacing: 2,
                                      fontSize: 16,
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
                        const SizedBox(height: 70.0),
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
                                text: 'Or Sign in With',
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
                            InkWell(
                              onTap: () async {
                                setState(() {
                                  _loading = true;
                                });
                                UserCredential cred = await signInWithGoogle();
                                Future.delayed(Duration(seconds: 1))
                                    .whenComplete(() async {
                                  setState(() {
                                    _loading = false;
                                  });
                                  if (cred != null) {
                                    String msgToken = await FirebaseMessaging.instance.getToken();
                                    print(msgToken);
                                    await loginUser(RegisterLoginRequest(
                                        name: cred.user.displayName ?? "",
                                        emailId: cred.user.email ?? "",
                                        uid: cred.user.uid,
                                        avatar: cred.user.photoURL ?? "",
                                        phoneNumber: null,
                                        countryCode: null,
                                    fcmToken: msgToken));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("Error occurred!"),
                                    ));
                                  }
                                });
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 20,
                                child: Image.asset(
                                  'assets/icons/google.png',
                                  height: 25,
                                  width: 25,
                                ),
                              ),
                            ),
                            const SizedBox(width: 30.0),
                            InkWell(
                              onTap: () async {
                                setState(() {
                                  _loading = true;
                                });
                                UserCredential cred =
                                    await signInWithFacebook();
                                Future.delayed(Duration(seconds: 1))
                                    .whenComplete(() async {
                                  setState(() {
                                    _loading = false;
                                  });
                                  if (cred != null) {
                                    String msgToken = await FirebaseMessaging.instance.getToken();
                                    print(msgToken);
                                    await loginUser(RegisterLoginRequest(
                                        name: cred.user.displayName ?? "",
                                        emailId: cred.user.email ?? "",
                                        uid: cred.user.uid,
                                        avatar: cred.user.photoURL ?? "",
                                        phoneNumber: null,
                                        countryCode: null,fcmToken: msgToken));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("Error occurred!"),
                                    ));
                                  }
                                });
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 20,
                                child: FaIcon(FontAwesomeIcons.facebookF),
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
                                    text: 'Sign up Here',
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
                  ],
                ),
              )),
            ),
          ),
          if (_loading) LoadingWidget()
        ],
      ),
    );
  }
}
