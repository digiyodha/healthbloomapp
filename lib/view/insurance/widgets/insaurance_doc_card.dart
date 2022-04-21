import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:health_bloom/components/textbuilder.dart';
import '../../../utils/colors.dart';

class InsuranceDocCard extends StatefulWidget {
  final String nameOfBill;
  final String nameOfPatients;
  final String avatar;
  final DateTime dateOfBill;
  final Function edit;
  final Function delete;
  final Function onTap;
  final bool showIcons;
  bool value;
  InsuranceDocCard(
      {Key key,
      this.nameOfBill,
      this.nameOfPatients,
      this.dateOfBill,
      this.edit,
      this.delete,
      this.onTap,
      this.avatar,
      this.value,
      this.showIcons = true})
      : super(key: key);

  @override
  State<InsuranceDocCard> createState() => _InsuranceCardSDoctate();
}

class _InsuranceCardSDoctate extends State<InsuranceDocCard> {
  // bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: () {
          // _selected = !_selected;
          widget.value = !widget.value;
          widget.onTap(widget.value);
          setState(() {});
        },
        child: Stack(
          children: [
            Container(
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
                      // color: Color(0xffDFDEE2),
                      // color: Colors.white,
                      color: kMainColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.elliptical(50, 100),
                        bottomRight: Radius.elliptical(50, 100),
                      ),
                    ),
                    child: widget.avatar.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.elliptical(50, 100),
                              bottomRight: Radius.elliptical(50, 100),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: widget.avatar,
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
                  // ClipRRect(
                  //   clipBehavior: Clip.antiAlias,
                  //   borderRadius: BorderRadius.only(
                  //     topRight: Radius.elliptical(50, 100),
                  //     bottomRight: Radius.elliptical(50, 100),
                  //   ),
                  //   child: widget.avatar.isNotEmpty
                  //       ? Padding(
                  //           padding: const EdgeInsets.all(12.0),
                  //           child: CircleAvatar(
                  //             radius: 42,
                  //             backgroundImage: NetworkImage(
                  //               widget.avatar,
                  //             ),
                  //           ),
                  //         )
                  //       : Padding(
                  //           padding: const EdgeInsets.all(12.0),
                  //           child: CircleAvatar(
                  //             radius: 42,
                  //             backgroundImage: AssetImage(
                  //               'assets/images/man.png',
                  //             ),
                  //           ),
                  //         ),
                  // ),
                  Expanded(
                    child: Container(
                      height: 115,
                      decoration: BoxDecoration(
                        color: kMainColor,
                      ),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextBuilder(
                                  text: widget.nameOfBill.toString() ?? '',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              if (widget.showIcons)
                                InkWell(
                                  onTap: widget.edit,
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                )
                            ],
                          ),
                          TextBuilder(
                            text: widget.nameOfPatients.toString() ?? '',
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
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
                                    text: widget.dateOfBill != null
                                        ? '${widget.dateOfBill.day}-${widget.dateOfBill.month}-${widget.dateOfBill.year}'
                                        : '',
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                              if (widget.showIcons)
                                InkWell(
                                  onTap: widget.delete,
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
            if (widget.value)
              Positioned(
                top: 8,
                right: 8,
                child: Icon(
                  Icons.check_box,
                  color: Colors.white,
                  size: 30,
                ),
              )
          ],
        ),
      ),
    );
  }
}
