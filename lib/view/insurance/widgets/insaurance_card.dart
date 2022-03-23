import 'package:flutter/material.dart';
import 'package:health_bloom/components/textbuilder.dart';
import '../../../utils/colors.dart';

class InsuranceCard extends StatefulWidget {
  final String nameOfBill;
  final String nameOfPatients;
  final String avatar;
  final DateTime dateOfBill;
  final Function edit;
  final Function delete;
  final Function onTap;
  final bool showIcons;
  const InsuranceCard({
    Key key,
    this.nameOfBill,
    this.nameOfPatients,
    this.dateOfBill,
    this.edit,
    this.delete,
    this.onTap,
    this.avatar,
    this.showIcons = true
  }) : super(key: key);

  @override
  State<InsuranceCard> createState() => _InsuranceCardState();
}

class _InsuranceCardState extends State<InsuranceCard> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: (){
          _selected = !_selected;
          widget.onTap(_selected);
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
                      color: Color(0xffDFDEE2),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.elliptical(50, 100),
                        bottomRight: Radius.elliptical(50, 100),
                      ),
                    ),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                      child: widget.avatar.isNotEmpty && widget.avatar != null
                          ? CircleAvatar(
                        radius: 40,
                        backgroundColor: Color(0xffFABE18),
                        backgroundImage: NetworkImage(widget.avatar),
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
                              if(widget.showIcons)
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
                              if(widget.showIcons)
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
            if(_selected)
              Positioned(
                top: 8,
                right: 8,
                child: Icon(Icons.check_box,color: Colors.white,size: 30,),
              )
          ],
        ),
      ),
    );
  }
}
