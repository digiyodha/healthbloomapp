import 'package:flutter/material.dart';
import 'package:health_bloom/utils/colors.dart';

class CustomTextField extends StatefulWidget {
  final TextInputType textInputType;
  final Function onChanged;
  final bool enableHide, showLeading, readOnly, showTrailing;
  final String label, hintText;
  final TextEditingController controller;
  final trailing;
  final bool obscureText, enabled;
  final int maxLines, minLines;
  final Function onTap;
  final int maxLength;
  final double labelSize;
  final Function(String) validator;
  CustomTextField(
      {this.controller,
      this.label,
      this.enableHide = false,
      this.onChanged,
      this.showLeading = false,
      this.textInputType,
      this.readOnly = false,
      this.showTrailing = false,
      this.trailing,
      this.obscureText = false,
      this.maxLines,
      this.hintText = "",
      this.onTap,
      this.enabled = true,
      this.maxLength,
      this.minLines,
      this.labelSize = 16,
      this.validator});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    _obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      keyboardType: widget.textInputType,
      style:
          TextStyle(color: kBlack, fontWeight: FontWeight.w400, fontSize: 16),
      obscureText: _obscureText,
      controller: widget.controller,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      validator: widget.validator,
      onTap: () {
        widget.onTap();
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        counterStyle: TextStyle(fontSize: 12, color: kMainColor),
        hintText: widget.hintText,
        alignLabelWithHint: true,
        fillColor: widget.readOnly ? Color(0xffF7F8FB) : kWhite,
        filled: true,
        errorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        focusedBorder: widget.readOnly
            ? OutlineInputBorder(
                borderSide: BorderSide(color: kGrey4, width: 1.2))
            : OutlineInputBorder(
                borderSide: BorderSide(color: kMainColor, width: 2),
              ),
        disabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: kGrey4, width: 1)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kGrey4, width: 1.3)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: kGrey4, width: 1.2)),
        labelText: widget.label,
        hintStyle: TextStyle(fontSize: 16, color: kGrey6),
        labelStyle: TextStyle(fontSize: widget.labelSize, color: kGrey6),
      ),
    );
  }
}
