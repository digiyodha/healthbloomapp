import 'package:flutter/material.dart';
import 'package:health_bloom/components/textbuilder.dart';

import '../utils/colors.dart';

class CustomTab extends StatelessWidget {
  final String title;
  final String icon;

  final Function onTap;
  final bool isSelected;
  const CustomTab({
    Key key,
    this.title,
    this.icon,
    this.onTap,
    this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Image.asset(
              icon,
              height: 20,
              width: 20,
            ),
            const SizedBox(height: 5.0),
            TextBuilder(text: title),
            const SizedBox(height: 10.0),
            Container(
              height: 2,
              width: double.infinity,
              color: isSelected ? kMainColor : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
