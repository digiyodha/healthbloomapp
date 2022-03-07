import 'package:flutter/material.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:intl/intl.dart';

class MedicineCard extends StatelessWidget {
  final DateTime time;
  final String dosages;
  final Function onTap;
  const MedicineCard({
    Key key,
    this.time,
    this.dosages,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 220,
          width: 170,
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Color(0xffAF8EFF),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "MEDICINE",
                style:
                    TextStyle(fontSize: 12, color: kWhite, letterSpacing: 1.5),
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
                    fontSize: 22, color: kWhite, fontWeight: FontWeight.w600),
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
      ),
    );
  }
}
