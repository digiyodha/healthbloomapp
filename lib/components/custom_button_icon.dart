import 'package:flutter/material.dart';
import 'package:health_bloom/utils/colors.dart';

class CustomButtonIcon extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() onTop;
  const CustomButtonIcon({
    Key key,
    this.title,
    this.icon,
    this.onTop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      width: 280,
      child: TextButton(
        style: ButtonStyle(shape:
            MaterialStateProperty.resolveWith<OutlinedBorder>(
                (Set<MaterialState> states) {
          return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16));
        }), padding: MaterialStateProperty.resolveWith<EdgeInsets>(
            (Set<MaterialState> states) {
          return EdgeInsets.symmetric(horizontal: 14);
        }), foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) return kWhite;
          return kWhite;
        }), backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) return kGreyLite;
          return kMainColor;
        }), overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed))
            return kWhite.withOpacity(0.1);
          if (states.contains(MaterialState.hovered))
            return kWhite.withOpacity(0.04);
          if (states.contains(MaterialState.focused))
            return kWhite.withOpacity(0.12);
          if (states.contains(MaterialState.disabled)) return kWhite;
          if (states.contains(MaterialState.dragged))
            return kWhite.withOpacity(0.08);
          return kWhite;
        })),
        onPressed: onTop,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
            ),
            const SizedBox(width: 10.0),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
