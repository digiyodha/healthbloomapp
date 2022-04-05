import 'package:flutter/material.dart';
import 'package:health_bloom/components/textbuilder.dart';

import '../../utils/drawer/custom_drawer.dart';

class NewMedicine extends StatefulWidget {
  const NewMedicine({Key key}) : super(key: key);

  @override
  _NewMedicineState createState() => _NewMedicineState();
}

class _NewMedicineState extends State<NewMedicine> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          drawer: CustomDrawer(
            selected: -1,
          ),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(0xff8B80F8),
            title: Text("Medicines"),
            centerTitle: true,
          ),
          body: Center(
            child: TextBuilder(text: 'Comming Soon...'),
          )),
    );
  }
}
