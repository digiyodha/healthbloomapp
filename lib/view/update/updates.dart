import 'package:flutter/material.dart';
import 'package:health_bloom/components/textbuilder.dart';

import '../../utils/drawer/custom_drawer.dart';

class Updates extends StatefulWidget {
  const Updates({Key key}) : super(key: key);

  @override
  State<Updates> createState() => _UpdatesState();
}

class _UpdatesState extends State<Updates> {
  @override
  Widget build(BuildContext context) {
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
            color: Colors.black,
          ),
        ),
        title: TextBuilder(
          text: "Updates",
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: TextBuilder(text: 'Updates'),
      ),
    );
  }
}
