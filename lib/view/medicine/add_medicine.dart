import 'package:flutter/material.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/model/request/add_medicine_request.dart';
import 'package:health_bloom/model/response/add_medicine_response.dart';
import 'package:health_bloom/model/response/response.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:health_bloom/utils/loading.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import '../../components/custom_contained_button.dart';
import '../../model/response/get_all_member_response.dart';
import '../../services/api/repository/auth_repository.dart';
import '../../utils/text_field/custom_text_field.dart';

class AddMedicine extends StatefulWidget {
  final GetAllDocumentsResponseBill bill;
  const AddMedicine({Key key, this.bill}) : super(key: key);

  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  TextEditingController _medicineName = TextEditingController();
  TextEditingController _dosage = TextEditingController();
  TextEditingController _dose = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _doseTime = TextEditingController();
  TextEditingController _duration = TextEditingController();
  TextEditingController _familyMember = TextEditingController();
  DateTime startDate = DateTime.now();
  bool _loading = false;
  Future _future;
  String _memberId;
  int _amountPill = 1;
  bool setAlarm = false;
  String remainderTime = 'Everyday';
  List<String> remainderData = ['Everyday', 'Weekly'];
  List<DateTime> _listOfTimes = [];
  Future<void> _startDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
      });
      _date.text = "${startDate.day}/${startDate.month}/${startDate.year}";
    }
  }

  String _hour, _minute;

  String dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  Future<Null> _selectMedicineTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        print('Selected Tinme is ${_hour} : ${_minute}');
        // _timeController.text = dateforma(
        //     DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
        //     [hh, ':', nn, " ", am]).toString();
      });
  }

  Future<AddMedicineResponse> addMedicine(AddMedicineRequest request) async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    AddMedicineResponse _response = await adminAPI.addmedicineAPI(
      AddMedicineRequest(
        medicineName: _medicineName.text,
        amount: _amountPill,
        dosage: int.parse(_dosage.text),
        doses: int.parse(_dose.text),
        duration: _duration.text,
        startDate: startDate,
        reminderTime: remainderTime,
        alarmTimer: setAlarm,
        patient: _memberId,
        // time: List.generate(
        //   _listOfTimes.length,
        //   (index) => selectedTime,
        // ),
      ),
    );
    return _response;
  }

  Future<GetAllMemberResponse> getAllmember() async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    GetAllMemberResponse _response = await adminAPI.getAllMemberAPI();
    return _response;
  }

  @override
  void initState() {
    super.initState();
    _listOfTimes.clear();
    _future = getAllmember();
    if (widget.bill != null) {
      _medicineName.text = widget.bill.name.toString();

      _date.text =
          "${widget.bill.date.day}/${widget.bill.date.month}/${widget.bill.date.year}";
      _memberId = widget.bill.patient.id;
      startDate = widget.bill.date;
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
        title: Text(widget.bill != null ? "Edit Medicine" : "Add Medicine"),
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
                    CustomTextField(
                      maxLines: 1,
                      controller: _medicineName,
                      label: "Medicine Name",
                      textInputType: TextInputType.name,
                      onChanged: () {},
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
                            onTap: () {
                              setState(() {
                                if (_amountPill <= 1)
                                  _amountPill == 0;
                                else
                                  _amountPill--;
                              });
                            },
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
                            onTap: () {
                              setState(() {
                                _amountPill++;
                              });
                            },
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
                      controller: _dosage,
                      label: "Dosage",
                      textInputType: TextInputType.number,
                      onChanged: () {},
                      onTap: () {},
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      maxLines: 1,
                      controller: _dose,
                      label: "Dose",
                      textInputType: TextInputType.number,
                      onChanged: () {},
                      onTap: () {},
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      maxLines: 1,
                      controller: _duration,
                      label: "Duration",
                      textInputType: TextInputType.number,
                      onChanged: () {},
                      onTap: () {},
                    ),
                    SizedBox(height: 16),
                    TextBuilder(
                        text: 'Time',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: kGrey7),
                    if (selectedDate != null)
                      ListView.builder(
                        itemCount: _listOfTimes.length,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return TextBuilder(
                              text:
                                  '${DateFormat('hh:mm a').format(_listOfTimes[index])}');
                        },
                      ),
                    Center(
                      child: MaterialButton(
                        onPressed: () {
                          _selectMedicineTime(context);
                          selectedDate == null;
                          setState(() {
                            _listOfTimes.add(selectedDate);
                          });
                        },
                        child: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              Icon(Icons.add),
                              TextBuilder(text: 'Add more'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    // CustomDropDown(
                    //   title: "Select Family Member",
                    //   controller: _familyMember,
                    //   dropDownData:
                    //       data.data.data.map((e) => e.name).toList(),
                    //   stateCallback: (int i) {
                    //     _memberId = data.data.data[i].id;
                    //   },
                    // ),
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
                                text: 'Start',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: kGrey7),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    _startDate(context);
                                  });
                                },
                                child: TextBuilder(
                                    text:
                                        "${startDate.day}-${startDate.month}-${startDate.year}"))
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextBuilder(
                                text: 'Remainder Time',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: kGrey7),
                            DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: remainderTime,
                                icon: const Icon(Icons.arrow_drop_down),
                                style: const TextStyle(color: kGrey7),
                                onChanged: (String newValue) {
                                  setState(() {
                                    remainderTime = newValue;
                                  });
                                },
                                items: remainderData
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
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
                              onChanged: (val) {
                                setState(() {
                                  setAlarm = val;
                                });
                              },
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
          if (_loading) LoadingWidget()
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
            color: kWhite),
        padding: EdgeInsets.symmetric(horizontal: 24),
        height: 80,
        child: Align(
          alignment: Alignment.center,
          child: CustomContainedButton(
            height: 58,
            textSize: 16,
            disabledColor: kGreyLite,
            text: "Submit",
            onPressed: () async {
              if (_medicineName.text.isNotEmpty && _date.text.isNotEmpty) {
                setState(() {
                  _loading = true;
                });

                AddMedicineRequest _request = AddMedicineRequest(
                  medicineName: _medicineName.text,
                  amount: _amountPill,
                  dosage: int.parse(_dosage.text),
                  doses: int.parse(_dose.text),
                  // duration: ,
                  time: [],
                  startDate: startDate,
                  reminderTime: 'Weekly',
                  //  alarmTimer: ,
                  patient: _memberId,
                );
                print('Add Medicine request ${_request.toJson()}');
                AddMedicineResponse _response = await addMedicine(_request);
                print('Add Medicine response ${_response.toJson()}');
                if (_response.success) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Added successfully!"),
                  ));
                  await Future.delayed(Duration(seconds: 1));
                  Navigator.pop(context);
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Please fill all the details"),
                ));
              }
            },
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}