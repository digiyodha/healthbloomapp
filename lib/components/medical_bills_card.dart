import 'package:flutter/material.dart';
import 'package:health_bloom/components/textbuilder.dart';

class MedicalBillsCard extends StatelessWidget {
  final String nameOfBill;
  final String nameOfPatients;
  final DateTime dateOfBill;
  final Function edit;
  final Function delete;
  final Function onTap;
  const MedicalBillsCard({
    Key key,
    this.nameOfBill,
    this.nameOfPatients,
    this.dateOfBill,
    this.edit,
    this.delete,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: onTap,
        child: Container(
          clipBehavior: Clip.antiAlias,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color(0xffA283F9),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 115,
                decoration: BoxDecoration(
                  color: Color(0xffDFDEE2),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.elliptical(50, 100),
                    bottomRight: Radius.elliptical(50, 100),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Color(0xffFABE18),
                    child: Center(
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 115,
                  decoration: BoxDecoration(
                    color: Color(0xffA283F9),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextBuilder(
                            text: nameOfBill.toString() ?? '',
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          InkWell(
                            onTap: edit,
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      TextBuilder(
                        text: nameOfPatients.toString() ?? '',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.today,
                                  size: 15,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 5.0),
                              TextBuilder(
                                text:
                                    '${dateOfBill.day}-${dateOfBill.month}-${dateOfBill.year}' ??
                                        '',
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: delete,
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
