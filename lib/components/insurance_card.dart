import 'package:flutter/material.dart';
import 'package:health_bloom/components/textbuilder.dart';

import '../utils/colors.dart';

class InsuranceCard extends StatelessWidget {
  final String organization;
  final String nameOfPatients;
  final String avatar;
  final Function edit;
  final Function delete;
  final Function onTap;
  const InsuranceCard({
    Key key,
    this.organization,
    this.nameOfPatients,
    this.edit,
    this.delete,
    this.onTap,
    this.avatar,
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
            color: kMainColor,
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
                  child: avatar.isNotEmpty && avatar != null
                      ? CircleAvatar(
                          radius: 40,
                          backgroundColor: Color(0xffFABE18),
                          backgroundImage: NetworkImage(avatar),
                        )
                      : CircleAvatar(
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
                    color: kMainColor,
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextBuilder(
                            text: organization.toString() ?? '',
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
                          Container(
                            height: 10,
                            width: 10,
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
