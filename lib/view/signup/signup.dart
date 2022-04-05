import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/services/api/repository/auth_repository.dart';
import 'package:health_bloom/utils/loading.dart';
import 'package:health_bloom/view/login/login.dart';
import 'package:health_bloom/view/login/phone_login.dart';
import 'package:health_bloom/view/main_view.dart';
import 'package:health_bloom/view/profile/edit_profile.dart';

import 'package:provider/provider.dart';

import '../../main.dart';
import '../../model/request/request.dart';
import '../../model/response/response.dart';

enum AuthMode { login, register, phone }

extension on AuthMode {
  String get label => this == AuthMode.login
      ? 'Sign in'
      : this == AuthMode.phone
          ? 'Sign in'
          : 'Register';
}

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _loading = false;
  bool showPassword = true;
  String error = '';
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  FocusNode myFocusNode = FocusNode();

  Future loginUser(RegisterLoginRequest request, {bool soc = false}) async {
    setState(() {
      _loading = true;
    });
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    RegisterLoginResponse _response = await adminAPI.loginAPI(request);
    print("Register User Response: ${_response.toJson()}");
    if (_response.success) {
      sp.setString('id', _response.data.id);
      sp.setString('email', _response.data.emailId);
      sp.setString('name', _response.data.name);
      sp.setString('xAuthToken', _response.data.xAuthToken);
      sp.setString('profileImage', _response.data.avatar ?? '');
      if (soc) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainView()),
          (Route<dynamic> route) => false,
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error Occurred"),
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
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff8C67F5),
              Color(0xff8C67F5),
            ],
            begin: Alignment.centerLeft,
            stops: [0, 2],
            end: Alignment.centerRight,
          ),
        ),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(18.0),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 14.0),
                      TextBuilder(
                        text: "Here's Your \nFirst step \nwith us",
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                      ),
                      const SizedBox(height: 50.0),
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Container(
                          width: double.infinity,
                          height: 330,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
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
                                  controller: _name,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(30),
                                  ],
                                  style: TextStyle(
                                    color: Color(0xff4F17BD),
                                  ),
                                  decoration: InputDecoration(
                                    label: TextBuilder(text: 'Name'),
                                    contentPadding: EdgeInsets.all(10),
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
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
                                  controller: _email,
                                  autofillHints: {AutofillHints.email},
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(40),
                                  ],
                                  style: TextStyle(
                                    color: Color(0xff4F17BD),
                                  ),
                                  decoration: InputDecoration(
                                    label: TextBuilder(text: 'Email'),
                                    contentPadding: EdgeInsets.all(10),
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                    suffixIcon: Icon(Icons.email),
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
                                  focusNode: myFocusNode,
                                  controller: _password,
                                  obscureText: showPassword,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(16),
                                  ],
                                  style: TextStyle(
                                    color: Color(0xff4F17BD),
                                  ),
                                  decoration: InputDecoration(
                                    label: TextBuilder(text: 'Password'),
                                    contentPadding: EdgeInsets.all(10),
                                    suffixIcon: InkWell(
                                        onTap: () {
                                          myFocusNode.requestFocus();
                                          setState(() {
                                            showPassword = !showPassword;
                                          });
                                        },
                                        child: Icon(Icons.lock)),
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.2),
                                      ),
                                    ),
                                  ),
                                ),
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
                                  print(_name.text.toString());
                                  print(_email.text.toString());
                                  print(_password.text.toString());

                                  if (_name.text.isNotEmpty &&
                                      _email.text.isNotEmpty &&
                                      _password.text.isNotEmpty) {
                                    if (_password.text.length > 7) {
                                      try {
                                        setState(() {
                                          _loading = true;
                                        });

                                        final UserCredential user = await _auth
                                            .createUserWithEmailAndPassword(
                                          email: _email.text,
                                          password: _password.text,
                                        );
                                        await user.user
                                            .sendEmailVerification()
                                            .whenComplete(() {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                "Verification link has been sent to your Email. Please verify your account!"),
                                          ));
                                        });
                                        print("_auth ${_auth.toString()}");
                                        String msgToken =
                                            await FirebaseMessaging.instance
                                                .getToken();
                                        print(msgToken);
                                        await loginUser(RegisterLoginRequest(
                                            name:
                                                _auth.currentUser.displayName ??
                                                    _name.text,
                                            emailId: _auth.currentUser.email ??
                                                _email.text,
                                            uid: _auth.currentUser.uid,
                                            avatar:
                                                _auth.currentUser.photoURL ??
                                                    "",
                                            phoneNumber: null,
                                            countryCode: "91",
                                            fcmToken: msgToken));

                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => EditProfile(
                                                    id: sp.getString("id"),
                                                    name: _auth.currentUser
                                                            .displayName ??
                                                        _name.text,
                                                    email: _email.text ??
                                                        _auth.currentUser.email,
                                                    phone: false,
                                                  )),
                                          (Route<dynamic> route) => false,
                                        );
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'weak-password') {
                                          setState(() {
                                            _loading = false;
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                'The password provided is too weak.'),
                                          ));
                                        } else if (e.code ==
                                            'email-already-in-use') {
                                          setState(() {
                                            _loading = false;
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                'The account already exists for that email.'),
                                          ));
                                        }
                                      } catch (e) {
                                        setState(() {
                                          _loading = false;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(e.toString()),
                                        ));
                                      }
                                    } else {
                                      setState(() {
                                        _loading = false;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            'Password length should be greater than 7.'),
                                      ));
                                    }
                                  } else {
                                    setState(() {
                                      _loading = false;
                                    });
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content:
                                          Text('Please fill all the details'),
                                    ));
                                  }
                                  setState(() {
                                    _loading = false;
                                  });
                                },
                                child: TextBuilder(
                                  text: 'SIGN UP',
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
                              text: 'Or Sign up With',
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
                      const SizedBox(height: 12.0),
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
                                  String msgToken = await FirebaseMessaging
                                      .instance
                                      .getToken();
                                  print(msgToken);
                                  await loginUser(
                                      RegisterLoginRequest(
                                          name: cred.user.displayName ?? "",
                                          emailId: cred.user.email ?? "",
                                          uid: cred.user.uid,
                                          avatar: cred.user.photoURL ?? "",
                                          phoneNumber: null,
                                          countryCode: null,
                                          fcmToken: msgToken),
                                      soc: true);
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
                              UserCredential cred = await signInWithFacebook();
                              Future.delayed(Duration(seconds: 1))
                                  .whenComplete(() async {
                                setState(() {
                                  _loading = false;
                                });
                                if (cred != null) {
                                  String msgToken = await FirebaseMessaging
                                      .instance
                                      .getToken();
                                  print(msgToken);
                                  await loginUser(
                                      RegisterLoginRequest(
                                          name: cred.user.displayName ?? "",
                                          emailId: cred.user.email ?? "",
                                          uid: cred.user.uid,
                                          avatar: cred.user.photoURL ?? "",
                                          phoneNumber: null,
                                          countryCode: null,
                                          fcmToken: msgToken),
                                      soc: true);
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
                      const SizedBox(height: 12.0),
                      Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'Already have an account ? ',
                            style: TextStyle(),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Sign in',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Login(),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  if (_loading) LoadingWidget()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
