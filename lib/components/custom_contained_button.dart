import 'package:flutter/material.dart';
import '../utils/colors.dart';

class CustomContainedButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double height,width;
  final double textSize;
  final FontWeight weight;
  final Color disabledColor,color;

  const CustomContainedButton({
    required this.text,required this.onPressed,this.height = 36,required this.width,
    this.textSize = 14,this.weight = FontWeight.w500,this.color = kMainColor,required this.disabledColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: TextButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.resolveWith<OutlinedBorder>((Set<MaterialState> states) {
              return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)
              );
            }),
            padding: MaterialStateProperty.resolveWith<EdgeInsets>((Set<MaterialState> states) {
              return EdgeInsets.symmetric(horizontal: 14);
            }),
            foregroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
              if(states.contains(MaterialState.disabled)) return kWhite;
              return kWhite;
            }),
            backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
              if(states.contains(MaterialState.disabled)) return disabledColor;
              return color;
            }),
            overlayColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
              if(states.contains(MaterialState.pressed)) return kWhite.withOpacity(0.1);
              if(states.contains(MaterialState.hovered)) return kWhite.withOpacity(0.04);
              if(states.contains(MaterialState.focused)) return kWhite.withOpacity(0.12);
              if(states.contains(MaterialState.disabled)) return kWhite;
              if(states.contains(MaterialState.dragged)) return kWhite.withOpacity(0.08);
              return kWhite;
            })
        ),
        onPressed: (){
          onPressed();
        },
        child: Text(text,style: TextStyle(
            fontWeight: weight,
            fontSize: textSize
        ),),
      ),
    );
  }
}