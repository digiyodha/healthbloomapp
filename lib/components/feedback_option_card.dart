import 'package:flutter/material.dart';
import 'package:health_bloom/components/textbuilder.dart';

class FedbackOptionCard extends StatefulWidget {
  String title;
  Color textColor;
  Color bgColor;
  bool isSelected;
  Function(bool) onChanged;

  FedbackOptionCard({
    Key key,
    this.title,
    this.textColor,
    this.bgColor,
    this.isSelected,
    this.onChanged,
  }) : super(key: key);

  @override
  State<FedbackOptionCard> createState() => _FedbackOptionCardState();
}

class _FedbackOptionCardState extends State<FedbackOptionCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.isSelected = !widget.isSelected;
        });

        widget.onChanged(widget.isSelected);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: widget.bgColor,
        ),
        child: FittedBox(
          child: Row(
            children: [
              if (widget.isSelected)
                Icon(
                  Icons.done,
                  color: Colors.white,
                ),
              TextBuilder(
                text: widget.title,
                color: widget.textColor,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
