import 'package:flutter/material.dart';

import '../colors.dart';

class DrawerContainerWidget extends StatelessWidget {
  final String text;
  final Function onTap;
  final bool selected;
  final IconData icon;

  const DrawerContainerWidget({ required this.text, required this.onTap, required this.selected,required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.white38,
      onTap: (){
        onTap();
      },
      overlayColor:
          // ignore: missing_return
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed))
          return kWhite.withOpacity(0.3);
        return kWhite;
      }),
      child: Container(
        color: selected ? kWhite : kMainColor,
        width: double.infinity,
        padding: EdgeInsets.only(left: 20, top: 14, bottom: 14),
        child: Row(
          children: [
            Icon(icon,
                color: selected ? kMainColor : kWhite),
            SizedBox(width: 12,),
            Text(
              text,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  color: selected ? kMainColor : kWhite),
            ),
          ],
        ),
      ),
    );
  }
}
