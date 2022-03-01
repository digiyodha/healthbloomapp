import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/services/api/repository/auth_repository.dart';
import 'package:health_bloom/utils/loading.dart';
import 'package:health_bloom/view/login/login.dart';
import 'package:health_bloom/view/login/phone_login.dart';
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

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future loginUser(RegisterLoginRequest request) async {
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error Occurred"),
      ));
    }
    setState(() {
      _loading = false;
    });
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
              Color(0xff8560F6),
              Color(0xff9672F8),
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextBuilder(
                            text: "Here's Your \nFirst step \nwith us",
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                          ),
                          // Image.asset(
                          //   'assets/icons/first-aid-box.png',
                          //   height: 100,
                          //   width: 100,
                          // )
                        ],
                      ),
                      const SizedBox(height: 50.0),
                      Expanded(
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Container(
                            width: double.infinity,
                            height: 400,
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
                                    style: TextStyle(
                                      color: Color(0xff4F17BD),
                                    ),
                                    decoration: InputDecoration(
                                      label: TextBuilder(text: 'Name'),
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
                                    style: TextStyle(
                                      color: Color(0xff4F17BD),
                                    ),
                                    decoration: InputDecoration(
                                      label: TextBuilder(text: 'Email'),
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
                                    controller: _password,
                                    obscureText: showPassword,
                                    style: TextStyle(
                                      color: Color(0xff4F17BD),
                                    ),
                                    decoration: InputDecoration(
                                      label: TextBuilder(text: 'Password'),
                                      suffixIcon: InkWell(
                                          onTap: () {
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
                                          await _auth
                                              .createUserWithEmailAndPassword(
                                            email: _email.text,
                                            password: _password.text,
                                          );
                                          setState(() {
                                            _loading = true;
                                          });
                                          print("_auth ${_auth.toString()}");
                                          await loginUser(RegisterLoginRequest(
                                              name: _auth.currentUser
                                                      .displayName ??
                                                  _name.text,
                                              emailId:
                                                  _auth.currentUser.email ??
                                                      _email.text,
                                              uid: _auth.currentUser.uid,
                                              avatar:
                                                  _auth.currentUser.photoURL ??
                                                      "",
                                              phoneNumber: null,
                                              countryCode: null));
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditProfile(
                                                      id: sp.getString("id"),
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
                                  },
                                  child: TextBuilder(
                                    text: 'SIGN UP',
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
                      const SizedBox(height: 25.0),
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
                            onTap: () {},
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
                            text: 'Already have An Account ? ',
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
