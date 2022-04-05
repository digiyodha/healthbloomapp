import 'package:flutter/material.dart';

class BottomItem extends StatelessWidget {
  final IconData icon;

  final Color color;
  final Function() onPressed;
  final double height, width;
  const BottomItem({
    Key key,
    this.icon,
    this.color,
    this.onPressed,
    this.height = 30,
    this.width = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        // color: Colors.green,
        height: height, width: width,
        child: Icon(
          icon,
          size: height,
          color: color,
        ),
      ),
    );
  }
}
