import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/model/request/resgister_user_request.dart';
import 'package:health_bloom/model/response/register_user_response.dart';
import 'package:health_bloom/services/api/repository/auth_repository.dart';
import 'package:health_bloom/utils/loading.dart';
import 'package:health_bloom/view/login/login.dart';
import 'package:health_bloom/view/login/phone_login.dart';
import 'package:health_bloom/view/profile/edit_prodile.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _loading = false;
  bool showPassword = true;
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  Future<RegisterUserResponse> registerUser(RegisterUserRequest request) async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    RegisterUserResponse _response = await adminAPI.registerUserAPI(request);
    return _response;
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
                                    setState(() {
                                      _loading = true;
                                    });

                                    if (_email.text.isNotEmpty &&
                                        _password.text.isNotEmpty &&
                                        _name.text.isNotEmpty) {
                                      RegisterUserRequest _request =
                                          RegisterUserRequest(
                                              name: _name.text,
                                              emailId: _email.text,
                                              password: _password.text);
                                      RegisterUserResponse _response =
                                          await registerUser(_request);
                                      print(
                                          'Register Request ${_request.toJson()}');
                                      print(
                                          'Register Response ${_response.toJson()}');
                                      if (_response.success == true) {
                                        // ScaffoldMessenger.of(context)
                                        //     .showSnackBar(SnackBar(
                                        //   content: Text('User created.'),
                                        // ));

                                        setState(() {
                                          _loading = false;
                                        });

                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditProfile()),
                                          (Route<dynamic> route) => false,
                                        );
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
