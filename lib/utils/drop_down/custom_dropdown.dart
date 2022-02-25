import 'package:flutter/material.dart';

import '../colors.dart';

class CustomDropDown extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final double height, width, childHeight;
  final TextStyle hintStyle;
  final Color iconColor;
  final Widget child;
  final Border childBorder;
  final List<dynamic> dropDownData;
  final Function stateCallback;
  final String title_key;
  final bool down;
  final bool lastButton;
  final Widget lastWidget;
  final Function onPressedLast;

  const CustomDropDown(
      {Key key,
      this.title,
      this.width,
      this.height,
      this.hintStyle,
      this.iconColor,
      this.child,
      this.childHeight,
      this.childBorder,
      this.controller,
      this.dropDownData,
      this.stateCallback,
      this.title_key,
      this.down = false,
      this.lastButton = false,
      this.lastWidget,
      this.onPressedLast})
      : super(key: key);

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  ScrollController _controller = ScrollController();
  GlobalKey _key = GlobalKey();
  OverlayEntry _entry;
  double dX, dY;
  Size _size;
  bool _inserted = false;

  OverlayEntry _createOverlay() {
    return OverlayEntry(builder: (context) {
      return Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () {
            _inserted = false;
            _entry.remove();
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.transparent,
            child: Stack(children: [
              Positioned(
                top: widget.down
                    ? dY + _size.height
                    : widget.dropDownData.length > 5
                        ? dY - 5 * 56.toDouble() - 5 * 3.toDouble()
                        : widget.lastButton
                            ? dY -
                                widget.dropDownData.length * 56 -
                                widget.dropDownData.length * 3 -
                                58
                            : dY -
                                widget.dropDownData.length * 56 -
                                widget.dropDownData.length * 3,
                left: dX,
                child: Container(
                  height: widget.dropDownData.length > 5
                      ? 56 * 5.toDouble()
                      : widget.lastButton
                          ? widget.dropDownData.length * 56.toDouble() + 56
                          : widget.dropDownData.length * 56.toDouble(),
                  width: _size.width,
                  decoration: BoxDecoration(
                      border: widget.childBorder,
                      borderRadius: BorderRadius.circular(4),
                      color: kWhite,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, 2.0),
                            blurRadius: 5)
                      ]),
                  child: RawScrollbar(
                    isAlwaysShown: true,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            controller: _controller,
                            key: GlobalKey(),
                            itemCount: widget.dropDownData.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.all(0),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  widget.controller.text =
                                      widget.dropDownData[index];
                                  _inserted = false;
                                  _entry.remove();
                                  if (widget.stateCallback != null) {
                                    widget.stateCallback(index);
                                  }
                                },
                                child: Container(
                                  constraints: BoxConstraints(minHeight: 56),
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      widget.dropDownData[index],
                                      style: TextStyle(
                                          fontSize: 16, color: kGrey7),
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                height: 1,
                                color: kGrey3,
                                thickness: 1,
                              );
                            },
                          ),
                        ),
                        if (widget.lastButton)
                          InkWell(
                            onTap: () {
                              _inserted = false;
                              _entry.remove();
                              widget.onPressedLast();
                            },
                            child: widget.lastWidget,
                          )
                      ],
                    ),
                    controller: _controller,
                    thumbColor: kMainColor,
                  ),
                ),
              )
            ]),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    print("INSIDE DROPDWON");
    print(widget.dropDownData.length);
    print(widget.dropDownData);
    return WillPopScope(
      onWillPop: () async {
        if (_inserted) {
          _inserted = false;
          _entry.remove();
        }
        return true;
      },
      child: TextField(
        controller: widget.controller,
        key: _key,
        onTap: () {
          if (_inserted == false) {
            RenderBox _box = _key.currentContext.findRenderObject();
            _size = _box.size;
            Offset position = _box.localToGlobal(Offset.zero);
            dX = position.dx;
            dY = position.dy;
            _entry = _createOverlay();
            _inserted = true;
            Overlay.of(context).insert(_entry);
          } else {
            _entry.remove();
            _inserted = false;
          }
        },
        readOnly: true,
        decoration: InputDecoration(
            fillColor: kWhite,
            filled: true,
            errorBorder:
                OutlineInputBorder(borderSide: BorderSide(color: kMainColor)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kMainColor, width: 2),
            ),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kGrey4, width: 1)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kGrey4, width: 1.3)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: kGrey4, width: 1.2)),
            labelText: widget.title,
            labelStyle: widget.hintStyle,
            suffixIcon: Icon(
              Icons.arrow_drop_down,
              color: widget.iconColor,
            )),
      ),
    );
  }
}
