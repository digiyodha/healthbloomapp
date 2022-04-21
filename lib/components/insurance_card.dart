import 'package:cached_network_image/cached_network_image.dart';
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
  final DateTime dob;
  const InsuranceCard({
    Key key,
    this.organization,
    this.nameOfPatients,
    this.edit,
    this.delete,
    this.onTap,
    this.avatar,
    this.dob,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: onTap,
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 2,
          color: Colors.white,
          clipBehavior: Clip.antiAlias,
          child: Container(
            // clipBehavior: Clip.antiAlias,
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
                // avatar.isNotEmpty
                //     ? ClipRRect(
                //         borderRadius: BorderRadius.only(
                //           topRight: Radius.elliptical(50, 100),
                //           bottomRight: Radius.elliptical(50, 100),
                //         ),
                //         child: CachedNetworkImage(
                //           imageUrl: avatar,
                //           height: 50,
                //           width: 50,
                //           fit: BoxFit.cover,
                //         ),
                //       )
                //     : Padding(
                //         padding: const EdgeInsets.all(12.0),
                //         child: CircleAvatar(
                //           radius: 42,
                //           backgroundImage: AssetImage(
                //             'assets/images/man.png',
                //           ),
                //         ),
                //       ),
                Container(
                  height: 115,
                  decoration: BoxDecoration(
                    // color: Color(0xffDFDEE2),
                    // color: Colors.white,
                    color: kMainColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.elliptical(50, 100),
                      bottomRight: Radius.elliptical(50, 100),
                    ),
                  ),
                  child: avatar.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.elliptical(50, 100),
                            bottomRight: Radius.elliptical(50, 100),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: avatar,
                            // height: double.infinity,
                            // width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: CircleAvatar(
                            radius: 35,
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
                        Spacer(),
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
                            TextBuilder(
                              text: dob != null
                                  ? '${dob.day}-${dob.month}-${dob.year}'
                                  : '',
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
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
      ),
    );
  }
}
