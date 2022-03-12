import 'package:flutter/material.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:intl/intl.dart';

class MedicineCard extends StatelessWidget {
  final String medicineName;
  final DateTime time;
  final String dosages;
  final Function onTap;
  final double height;
  final double width;
  final EdgeInsetsGeometry padding;

  final Function() delete;
  final bool hideIcon;
  const MedicineCard({
    Key key,
    this.time,
    this.dosages,
    this.onTap,
    this.medicineName,
    this.height = 220,
    this.width = 170,
    this.padding = const EdgeInsets.only(right: 16),
    this.delete,
    this.hideIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              height: height,
              width: width,
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xffAF8EFF),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    medicineName ?? '',
                    style: TextStyle(
                        fontSize: 12, color: kWhite, letterSpacing: 1.5),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Image.asset("assets/images/drug2.png"),
                    ),
                  ),
                  Spacer(),
                  calculateDifference(time) == 0
                      ? TextBuilder(
                          text: 'Today',
                          fontSize: 16,
                          color: kWhite,
                          fontWeight: FontWeight.w600)
                      : calculateDifference(time) == 1
                          ? TextBuilder(
                              text: 'Tomorrow',
                              fontSize: 16,
                              color: kWhite,
                              fontWeight: FontWeight.w600)
                          : TextBuilder(
                              text: "${DateFormat('EEEE').format(time)}" ?? '',
                              fontSize: 16,
                              color: kWhite,
                              fontWeight: FontWeight.w600),
                  Spacer(),
                  Text(
                    '${DateFormat('hh:mm a').format(time).toString()}' ?? '',
                    style: TextStyle(
                        fontSize: 22,
                        color: kWhite,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Dosage - ${dosages.toString()} mg" ?? '',
                    style: TextStyle(
                        fontSize: 14,
                        color: kWhite.withOpacity(0.6),
                        fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // hideIcon
                  //     ? IconButton(
                  //         alignment: Alignment.centerRight,
                  //         padding: EdgeInsets.symmetric(horizontal: 0),
                  //         onPressed: edit,
                  //         icon: Icon(
                  //           Icons.edit,
                  //           color: Colors.white,
                  //           size: 15,
                  //         ),
                  //       )
                  //     : Container(),
                  hideIcon
                      ? IconButton(
                          onPressed: delete,
                          icon: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 18,
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final now = DateTime.now();
int calculateDifference(DateTime date) {
  DateTime now = DateTime.now();
  return DateTime(date.year, date.month, date.day)
      .difference(DateTime(now.year, now.month, now.day))
      .inDays;
}
