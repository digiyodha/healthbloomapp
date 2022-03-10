import 'package:flutter/material.dart';
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
  final Function() edit;
  final Function() delete;
  const MedicineCard({
    Key key,
    this.time,
    this.dosages,
    this.onTap,
    this.medicineName,
    this.height = 220,
    this.width = 170,
    this.padding = const EdgeInsets.only(right: 16),
    this.edit,
    this.delete,
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
                  Text(
                    '${DateFormat('hh:mm a').format(time).toString()}' ?? '',
                    style: TextStyle(
                        fontSize: 22,
                        color: kWhite,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 6,
                  ),
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
              child: IconButton(
                onPressed: edit,
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: IconButton(
                onPressed: delete,
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
