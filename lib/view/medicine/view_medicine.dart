import 'package:flutter/material.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/model/response/search_medicne_response.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:intl/intl.dart';

import '../../utils/text_field/custom_text_field.dart';

class ViewMedicine extends StatefulWidget {
  final SearchMedicineResponseDatum medicne;
  const ViewMedicine({Key key, this.medicne}) : super(key: key);

  @override
  State<ViewMedicine> createState() => _ViewMedicineState();
}

class _ViewMedicineState extends State<ViewMedicine> {
  TextEditingController _medicineName = TextEditingController();
  TextEditingController _dosage = TextEditingController();
  TextEditingController _dose = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _duration = TextEditingController();

  DateTime startDate;

  int _amountPill = 1;
  bool setAlarm = false;
  String remainderTime = 'Weekly';
  List<String> remainderData = ['Weekly', 'Daily', 'Monthly'];
  List<DateTime> _listOfTimes = [];

  @override
  void initState() {
    super.initState();
    _listOfTimes.clear();

    print('Start date ' + startDate.toString());

    if (widget.medicne != null) {
      _medicineName.text = widget.medicne.medicineName;
      _date.text =
          "${widget.medicne.startDate.day}/${widget.medicne.startDate.month}/${widget.medicne.startDate.year}";

      startDate = widget.medicne.startDate;
      _dosage.text = widget.medicne.dosage;
      _dose.text = widget.medicne.doses;
      _duration.text = widget.medicne.duration;
      setAlarm = widget.medicne.alarmTimer;
      remainderTime = widget.medicne.reminderTime;
      _amountPill = widget.medicne.amount;
      _listOfTimes = widget.medicne.time;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("View Medicine"),
        centerTitle: true,
      ),
      backgroundColor: kWhite,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 300,
              width: double.infinity,
              child: Image.asset(
                "assets/images/medicines-list.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            top: 180,
            child: Container(
              padding: EdgeInsets.only(top: 40, left: 24, right: 24),
              decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    CustomTextField(
                      maxLines: 1,
                      enabled: false,
                      controller: _medicineName,
                      label: "Medicine Name",
                      textInputType: TextInputType.name,
                      onChanged: (val) {},
                      onTap: () {},
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Amount",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: kGrey7),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: kMainColor,
                              child: Icon(
                                Icons.remove,
                                color: kWhite,
                                size: 16,
                              ),
                            ),
                          ),
                          Text(
                            _amountPill.toString() + ' pills',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: kGrey7),
                          ),
                          InkWell(
                            onTap: () {},
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: kMainColor,
                              child: Icon(
                                Icons.add,
                                color: kWhite,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      maxLines: 1,
                      enabled: false,
                      controller: _dosage,
                      label: "Dosage",
                      onChanged: (val) {},
                      onTap: () {},
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      maxLines: 1,
                      enabled: false,
                      controller: _dose,
                      label: "Dose",
                      onChanged: (val) {},
                      onTap: () {},
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      maxLines: 1,
                      enabled: false,
                      controller: _duration,
                      label: "Duration",
                      onChanged: (val) {},
                      onTap: () {},
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      readOnly: true,
                      enabled: false,
                      maxLines: 1,
                      controller: _date,
                      label: "Start Date",
                      textInputType: TextInputType.text,
                      onChanged: (val) {},
                      onTap: () {},
                    ),
                    SizedBox(height: 16),
                    TextBuilder(
                        text: 'Time',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: kGrey7),
                    _listOfTimes.isNotEmpty
                        ? ListView.builder(
                            itemCount: _listOfTimes.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: ScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                width: 150,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextBuilder(
                                      text:
                                          '${DateFormat('hh:mm a').format(_listOfTimes[index])}',
                                      fontSize: 16,
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : Container(),
                    SizedBox(height: 16),
                    ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      title: TextBuilder(
                          text: 'Add remainder',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: kGrey7),
                      children: [
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextBuilder(
                                text: 'Remainder Time',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: kGrey7),
                            TextBuilder(text: remainderTime),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextBuilder(
                                text: 'Alarm',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: kGrey7),
                            Switch(
                              value: setAlarm,
                              onChanged: (val) {},
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
