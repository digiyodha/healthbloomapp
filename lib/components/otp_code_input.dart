import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPCodeInput extends StatefulWidget {
  final bool? first;
  final bool? last;
  final bool? hideIndicator;
  final TextEditingController? controller;
  const OTPCodeInput({
    Key? key,
    this.first,
    this.last,
    this.controller,
    this.hideIndicator = false,
  }) : super(key: key);

  @override
  State<OTPCodeInput> createState() => _OTPCodeInputState();
}

class _OTPCodeInputState extends State<OTPCodeInput> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        widget.hideIndicator!
            ? Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
              )
            : Container(),
        Container(
          alignment: Alignment.center,
          height: 70,
          width: 67,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: TextFormField(
              showCursor: false,
              controller: widget.controller,
              maxLength: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              onChanged: (value) {
                if (value.length == 1 && widget.last == false) {
                  FocusScope.of(context).nextFocus();
                }
                if (value.length == 0 && widget.first == false) {
                  FocusScope.of(context).previousFocus();
                }
              },
              decoration: InputDecoration(
                counter: Offstage(),
                contentPadding: EdgeInsets.all(12),
                border: InputBorder.none,
                labelText: '',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
