import 'package:flutter/material.dart';
import 'package:health_bloom/utils/colors.dart';

class LoadingWidget extends StatefulWidget {
  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Container(
            height: 50.0,
            width: 50.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(kMainColor),
            ),
          ),
        ),
      ),
    );
  }
}
