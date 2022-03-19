import 'package:flutter/material.dart';
import 'package:health_bloom/utils/colors.dart';

class CustomNearbySwitch extends StatefulWidget {
  final Function onChanged;
  const CustomNearbySwitch({Key key, this.onChanged}) : super(key: key);

  @override
  _CustomNearbySwitchState createState() => _CustomNearbySwitchState();
}

class _CustomNearbySwitchState extends State<CustomNearbySwitch> {
  bool _medicalStores = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: kWhite),
      child: Stack(
        children: [
          Positioned.fill(
            child: Row(
              children: [
                AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    width: _medicalStores ? 110 : 0),
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  height: 45,
                  width: _medicalStores ? 140 : 110,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(_medicalStores ? 8 : 8),
                        topLeft: Radius.circular(_medicalStores ? 8 : 8),
                        bottomRight: Radius.circular(_medicalStores ? 8 : 8),
                        bottomLeft: Radius.circular(_medicalStores ? 8 : 8),
                      ),
                      color: kMainColor.withOpacity(0.7)),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Row(
              children: [
                Container(
                  width: 110,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _medicalStores = false;
                      });
                      widget.onChanged(_medicalStores);
                    },
                    child: Center(
                        child: Text(
                          "Labs",
                          style: TextStyle(
                              color: _medicalStores ? kMainColor : kWhite,
                            fontSize: 15,
                            fontWeight: FontWeight.w600
                          ),
                        )),
                  ),
                ),
                Container(
                  width: 140,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _medicalStores = true;
                      });
                      widget.onChanged(_medicalStores);
                    },
                    child: Center(
                        child: Text(
                          "Medical Stores",
                          style: TextStyle(
                              color: _medicalStores ? kWhite : kMainColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
