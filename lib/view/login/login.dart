import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/main.dart';
import 'package:health_bloom/model/request/login_user_resquest.dart';
import 'package:health_bloom/model/response/login_uesr_response.dart';
import 'package:health_bloom/services/api/repository/auth_repository.dart';
import 'package:health_bloom/utils/loading.dart';
import 'package:health_bloom/view/homepage/home_page.dart';
import 'package:health_bloom/view/login/forgot_password.dart';
import 'package:health_bloom/view/login/phone_login.dart';
import 'package:health_bloom/view/signup/signup.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

GoogleSignIn googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
//    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GoogleSignInAccount _currentUser;
  bool _loading = false;

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  Future<LoginUserResponse> loginUser(LoginUserRequest request) async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    LoginUserResponse _response = await adminAPI.loginUserAPI(request);
    return _response;
  }

  Future<GoogleSignInAccount> _handleSignIn() async {
    try {
      await googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => googleSignIn.disconnect();

  @override
  void initState() {
    super.initState();
    // _email.text = 'omprakash@gmail.com';
    // _password.text = '12345';
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
    });
    googleSignIn.signInSilently();
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextBuilder(
                          text: "Already \nhave an \nAccount ?",
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
                                height: _email.text.isNotEmpty ? null : 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  controller: _email,
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
                                onPressed: () async {
                                  setState(() {
                                    _loading = true;
                                  });

                                  if (_email.text.isNotEmpty &&
                                      _password.text.isNotEmpty) {
                                    LoginUserRequest _request =
                                        LoginUserRequest(
                                            emailId: _email.text,
                                            password: _password.text);
                                    LoginUserResponse _response =
                                        await loginUser(_request);
                                    print('Login Request ${_request.toJson()}');
                                    print(
                                        'Login Response ${_response.toJson()}');
                                    if (_response.success == true) {
                                      sp.setString('xAuthToken',
                                          _response.data.xAuthToken);
                                      sp.setString(
                                          'loginUserId', _response.data.id);

                                      sp.setString('loginUserEmail',
                                          _response.data.emailId);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text('Successful login.'),
                                      ));
                                      setState(() {
                                        _loading = false;
                                      });

                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()),
                                        (Route<dynamic> route) => false,
                                      );
                                    } else {
                                      setState(() {
                                        _loading = false;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text('Enter details'),
                                      ));
                                    }
                                  } else {
                                    setState(() {
                                      _loading = false;
                                    });
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text('Enter all details'),
                                    ));
                                  }
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
                            await _handleSignIn();
                            Future.delayed(Duration(seconds: 1))
                                .whenComplete(() {
                              if (_currentUser != null) {
                                sp.setString("id", _currentUser?.id ?? "");
                                sp.setString(
                                    "email", _currentUser?.email ?? "");
                                print(_currentUser?.email);
                                print(_currentUser?.id);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return HomePage();
                                }));
                              } else {
                                setState(() {
                                  _loading = false;
                                });
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
              )),
            ),
          ),
          if (_loading) LoadingWidget()
        ],
      ),
    );
  }
}
