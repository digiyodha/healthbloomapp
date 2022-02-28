import 'package:flutter/material.dart';
import '../utils/colors.dart';

class CustomContainedButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double height, width;
  final double textSize;
  final FontWeight weight;
  final Color disabledColor, color;
  final Widget leading;
  final double borderRadius;
  const CustomContainedButton(
      {this.text,
      this.onPressed,
      this.height = 36,
      this.width,
      this.textSize = 14,
      this.weight = FontWeight.w500,
      this.color = kMainColor,
      this.disabledColor,
      this.leading,
      this.borderRadius = 16});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: TextButton(
        style: ButtonStyle(shape:
            MaterialStateProperty.resolveWith<OutlinedBorder>(
                (Set<MaterialState> states) {
          return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius));
        }), padding: MaterialStateProperty.resolveWith<EdgeInsets>(
            (Set<MaterialState> states) {
          return EdgeInsets.symmetric(horizontal: 14);
        }), foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) return kWhite;
          return kWhite;
        }), backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) return disabledColor;
          return color;
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
        onPressed: () {
          onPressed();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leading != null) leading,
            Text(
              text,
              style: TextStyle(fontWeight: weight, fontSize: textSize),
            ),
          ],
        ),
      ),
    );
  }
}
