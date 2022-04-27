import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/drawer/custom_drawer.dart';

class Developer extends StatefulWidget {
  const Developer({Key key}) : super(key: key);

  @override
  State<Developer> createState() => _DeveloperState();
}

class _DeveloperState extends State<Developer> {
  Future<void> _launched;
  @override
  Widget build(BuildContext context) {
    final Uri toLaunch =
        Uri(scheme: 'https', host: 'www.digiyodha.com', path: 'headers/');
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      drawer: CustomDrawer(
        selected: 7,
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffFAFAFA),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Color(0xff8E72DB),
          ),
        ),
        title: TextBuilder(
          text: "Developer",
          color: Color(0xff8E72DB),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Container(
          margin: EdgeInsets.only(right: 8),
          padding: EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: Color(0xffFAFAFA),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Stack(
            // alignment: Alignment.bott,
            fit: StackFit.loose,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width,
                // color: Colors.lightGreen,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.89,
                height: 615,
                decoration: BoxDecoration(
                  color: Color(0xffA383FC),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.89,
                    // height: 280,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Color(0xffD4C9F4),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text:
                            'The HealthBloom project has been happily developed with the help from DigiYodha \n\nDigiYodha is not just a name, it is a concept which aims to provide equal opportunity of digital presence to all, to enable small, medium to aspirational businesses for their online presence and to fight the digital inequality present in the businesses today.',
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.3,
                          fontWeight: FontWeight.w400,
                          color: kBlack,
                        ),
                        children: [
                          TextSpan(
                              text: '\n\nCheck us out to know know more at '),
                          TextSpan(
                            text: 'https://digiyodha.com',
                            style: TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                final Uri _url =
                                    Uri.parse('https://digiyodha.com');
                                print('Tapped on URL');
                                _launchInBrowser(_url);
                              },
                          ),
                          TextSpan(
                            text: '\nCheck us out to know know more at ',
                          ),
                          TextSpan(
                            text: '\n+91 76684 07132',
                            style: TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                print('Tapped on Call');
                                _makePhoneCall('+917668407132');
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 10,
                child: Container(
                  // color: Colors.lightGreen,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/over-shape-logo.png',
                        height: 200,
                        width: 200,
                      ),
                      const SizedBox(height: 10.0),
                      TextBuilder(
                        text: 'Health Bloom',
                        color: Colors.white,
                        fontSize: 25,
                        wordSpacing: 2,
                        fontWeight: FontWeight.w700,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future _launchInBrowser(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url,
          mode: LaunchMode.externalApplication,
          webViewConfiguration: WebViewConfiguration(
            enableJavaScript: true,
          ));
    } else {
      print('Error ${url.toString()}');
      throw 'Could not launch $url';
    }
  }
}
