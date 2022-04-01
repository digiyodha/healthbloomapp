import 'package:flutter/material.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/model/request/add_medicine_request.dart';
import 'package:health_bloom/model/request/edit_medicine._request.dart';
import 'package:health_bloom/model/request/get_next_medicine_response.dart';
import 'package:health_bloom/model/response/add_medicine_response.dart';
import 'package:health_bloom/model/response/edit_medicine_response.dart';
import 'package:health_bloom/model/response/get_medicine_response.dart';
import 'package:health_bloom/model/response/search_medicne_response.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:health_bloom/utils/drop_down/custom_dropdown.dart';
import 'package:health_bloom/utils/loading.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import '../../components/custom_contained_button.dart';
import '../../model/response/get_all_member_response.dart';
import '../../services/api/repository/auth_repository.dart';
import '../../utils/text_field/custom_text_field.dart';

class AddMedicine extends StatefulWidget {
  final String id;
  final GetMedicineResponseData getMedicine;
  final GetNextMedicineResponseDatum getNextMedicine;
  final SearchMedicineResponseDatum searchMedicine;
  const AddMedicine({
    Key key,
    this.getMedicine,
    this.id,
    this.getNextMedicine,
    this.searchMedicine,
  }) : super(key: key);
  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  TextEditingController _medicineName = TextEditingController();
  TextEditingController _medicineDescription = TextEditingController();
  TextEditingController _dosage = TextEditingController();
  TextEditingController _dose = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _days = TextEditingController();
  TextEditingController _familyMember = TextEditingController();
  DateTime startDate;
  bool _loading = false;
  Future _future;
  String _memberId;
  int _amountPill = 1;
  bool setAlarm = false;
  String remainderTime = 'Weekly';
  List<String> remainderData = ['Weekly', 'Daily', 'Monthly'];
  List<DateTime> _listOfTimes = [];
  Future<void> _startDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
        _listOfTimes.clear();
      });

      _date.text = "${startDate.day}-${startDate.month}-${startDate.year}";
    }
  }

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  Future<Null> _selectMedicineTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _listOfTimes.add(DateTime(startDate.year, startDate.month,
            startDate.day, selectedTime.hour, selectedTime.minute));
        print('Selected Time is $selectedTime');
      });
  }

  Future<AddMedicineResponse> addMedicine(AddMedicineRequest request) async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    AddMedicineResponse _response = await adminAPI.addmedicineAPI(request);
    print("Add Medicine Response ${_response.toJson()}");
    return _response;
  }

  Future<EditMedicineResponse> editMedicine(EditMedicineRequest request) async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    EditMedicineResponse _response = await adminAPI.editMedicineAPI(request);
    print("Add Medicine Response ${_response.toJson()}");
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

    print('Start date ' + startDate.toString());
    _future = getAllmember();
    if (widget.getMedicine != null) {
      _medicineName.text = widget.getMedicine.medicineName.toString();
      _date.text =
          "${widget.getMedicine.startDate.day}-${widget.getMedicine.startDate.month}-${widget.getMedicine.startDate.year}";
      _amountPill = widget.getMedicine.amount;
      startDate = widget.getMedicine.startDate;
      setAlarm = widget.getMedicine.alarmTimer;
      _dosage.text = widget.getMedicine.dosage;
      _dose.text = widget.getMedicine.doses;
      _days.text = widget.getMedicine.duration;
      _familyMember.text = widget.getMedicine.patient.name;
      _memberId = widget.getMedicine.patient.id;
      _medicineDescription.text = widget.getMedicine.description;
      widget.getMedicine.timeObject.forEach((element) {
        _listOfTimes.add(DateTime(
            widget.getMedicine.startDate.year,
            widget.getMedicine.startDate.month,
            widget.getMedicine.startDate.day,
            element.startTime.hour,
            element.startTime.minute));
      });

      remainderTime = widget.getMedicine.reminderTime;
    }
    if (widget.getNextMedicine != null) {
      _medicineName.text = widget.getNextMedicine.medicineName.toString();
      _date.text =
          "${widget.getNextMedicine.startDate.day}-${widget.getNextMedicine.startDate.month}-${widget.getNextMedicine.startDate.year}";
      _amountPill = widget.getNextMedicine.amount;
      startDate = widget.getNextMedicine.startDate;
      setAlarm = widget.getNextMedicine.alarmTimer;
      _dosage.text = widget.getNextMedicine.dosage;
      _dose.text = widget.getNextMedicine.doses;
      _days.text = widget.getNextMedicine.duration;
      _familyMember.text = widget.getNextMedicine.patient.name;
      _memberId = widget.getNextMedicine.patient.id;
      _medicineDescription.text = widget.getNextMedicine.description;
      widget.getNextMedicine.timeObject.forEach((element) {
        _listOfTimes.add(DateTime(
            widget.getNextMedicine.startDate.year,
            widget.getNextMedicine.startDate.month,
            widget.getNextMedicine.startDate.day,
            element.startTime.hour,
            element.startTime.minute));
      });

      remainderTime = widget.getNextMedicine.reminderTime;
    }
    if (widget.searchMedicine != null) {
      _medicineName.text = widget.searchMedicine.medicineName.toString();
      _date.text =
          "${widget.searchMedicine.startDate.day}-${widget.searchMedicine.startDate.month}-${widget.searchMedicine.startDate.year}";
      _amountPill = widget.searchMedicine.amount;
      startDate = widget.searchMedicine.startDate;
      setAlarm = widget.searchMedicine.alarmTimer;
      _dosage.text = widget.searchMedicine.dosage;
      _dose.text = widget.searchMedicine.doses;
      _days.text = widget.searchMedicine.duration;
      _familyMember.text = widget.searchMedicine.patient.name;
      _memberId = widget.searchMedicine.patient.id;
      _medicineDescription.text = widget.searchMedicine.description;
      print(widget.searchMedicine.startDate.toIso8601String());
      widget.searchMedicine.timeObject.forEach((element) {
        _listOfTimes.add(DateTime(
            widget.searchMedicine.startDate.year,
            widget.searchMedicine.startDate.month,
            widget.searchMedicine.startDate.day,
            element.startTime.hour,
            element.startTime.minute));
      });

      remainderTime = widget.searchMedicine.reminderTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('List ' + _listOfTimes.toList().toString());
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
        title: TextBuilder(
          text: widget.getMedicine != null || widget.getNextMedicine != null
              ? "Edit Medicine"
              : "Add Medicine",
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
        centerTitle: true,
      ),
      backgroundColor: kWhite,
      body: FutureBuilder<GetAllMemberResponse>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
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
                      color: Colors.black45,
                      colorBlendMode: BlendMode.hardLight,
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
                            controller: _medicineName,
                            textCapitalization: TextCapitalization.sentences,
                            label: "Medicine Name",
                            textInputType: TextInputType.name,
                            onChanged: (val) {},
                            onTap: () {},
                          ),
                          SizedBox(height: 16),
                          CustomTextField(
                            maxLines: 3,
                            controller: _medicineDescription,
                            textCapitalization: TextCapitalization.sentences,
                            label: "Medicine Description",
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                maxLines: 1,
                                controller: _dosage,
                                label: "Dosage",
                                onChanged: (val) {},
                                onTap: () {},
                              ),
                              SizedBox(height: 4),
                              Text(
                                "What is the size or frequency of your medicine?",
                                style: TextStyle(fontSize: 10, color: kGrey6),
                              )
                            ],
                          ),
                          SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                maxLines: 1,
                                controller: _dose,
                                label: "Dose",
                                onChanged: (val) {},
                                onTap: () {},
                              ),
                              SizedBox(height: 4),
                              Text(
                                "How many times a day you will be taking medicine?",
                                style: TextStyle(fontSize: 10, color: kGrey6),
                              )
                            ],
                          ),
                          SizedBox(height: 16),
                          CustomTextField(
                            maxLines: 1,
                            controller: _days,
                            label: "Duration (Days)",
                            onChanged: (val) {},
                            onTap: () {},
                          ),
                          SizedBox(height: 16),
                          CustomTextField(
                            readOnly: true,
                            maxLines: 1,
                            controller: _date,
                            label: "Start Date",
                            textInputType: TextInputType.text,
                            onChanged: (val) {},
                            onTap: () {
                              _startDate(context);
                            },
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextBuilder(
                                  text: 'Time',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: kGrey7),
                              Flexible(
                                child: Text(
                                  "What time would you like to take this medicine?",
                                  style: TextStyle(fontSize: 10, color: kGrey6),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 16),
                          _listOfTimes.isNotEmpty
                              ? ListView.builder(
                                  itemCount: _listOfTimes.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: ScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      width: 150,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextBuilder(
                                            text:
                                                '${DateFormat('hh:mm a').format(_listOfTimes[index])}',
                                            fontSize: 16,
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {});
                                              _listOfTimes.removeAt(index);
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: 18,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                )
                              : Container(),
                          Center(
                            child: CustomContainedButton(
                              height: 30,
                              textSize: 16,
                              borderRadius: 10,
                              disabledColor: kGreyLite,
                              width: 130,
                              text: _listOfTimes.isEmpty ? "Add" : "Add More",
                              onPressed: () {
                                if (startDate == null) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Select start date"),
                                  ));
                                } else {
                                  setState(() {});
                                  _selectMedicineTime(context);
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 16),
                          CustomDropDown(
                            title: "Select Family Member",
                            controller: _familyMember,
                            dropDownData:
                                snapshot.data.data.map((e) => e.name).toList(),
                            stateCallback: (int i) {
                              _memberId = snapshot.data.data[i].id;
                            },
                          ),
                          SizedBox(height: 16),
                          ExpansionTile(
                            tilePadding: EdgeInsets.zero,
                            title: TextBuilder(
                                text: 'Add Reminder',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: kGrey7),
                            children: [
                              // const SizedBox(height: 10.0),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     TextBuilder(
                              //         text: 'Start',
                              //         fontSize: 16,
                              //         fontWeight: FontWeight.w600,
                              //         color: kGrey7),
                              //     InkWell(
                              //         onTap: () {
                              //           setState(() {
                              //             _startDate(context);
                              //           });
                              //         },
                              //         child: TextBuilder(
                              //             text:
                              //                 "${startDate.day}-${startDate.month}-${startDate.year}"))
                              //   ],
                              // ),
                              const SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextBuilder(
                                      text: 'Reminder Time',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(child: CircularProgressIndicator());
        },
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
              if (widget.getMedicine != null ||
                  widget.getNextMedicine != null ||
                  widget.searchMedicine != null) {
                if (_medicineName.text.isNotEmpty &&
                    _date.text.isNotEmpty &&
                    _dosage.text.isNotEmpty &&
                    _medicineDescription.text.isNotEmpty &&
                    _dose.text.isNotEmpty &&
                    _days.text.isNotEmpty &&
                    _familyMember.text.isNotEmpty &&
                    _memberId != null &&
                    startDate != null &&
                    remainderTime != null &&
                    _listOfTimes.isNotEmpty) {
                  setState(() {
                    _loading = true;
                  });
                  print("StartDate = ${startDate.toIso8601String()}");
                  _listOfTimes.forEach((element) {
                    print(element.toIso8601String());
                  });
                  EditMedicineRequest _request = EditMedicineRequest(
                    id: widget.id,
                    medicineName: _medicineName.text,
                    description: _medicineDescription.text,
                    amount: _amountPill,
                    dosage: _dosage.text,
                    doses: _dose.text,
                    duration: _days.text,
                    startDate: startDate,
                    reminderTime: remainderTime,
                    alarmTimer: setAlarm,
                    patient: _memberId,
                    time: List.generate(
                      _listOfTimes.length,
                      (index) => _listOfTimes[index],
                    ),
                  );

                  print("Edit Medicine Request ${_request.toJson()}");
                  EditMedicineResponse _response = await editMedicine(_request);
                  print("Edit Medicine Response ${_response.toJson()}");

                  if (_response.success == true) {
                    setState(() {
                      _loading = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Updated successfully!"),
                    ));
                    await Future.delayed(Duration(seconds: 1));
                    Navigator.pop(context);
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Please fill all the details"),
                  ));
                }
              } else {
                if (_medicineName.text.isNotEmpty &&
                    _date.text.isNotEmpty &&
                    _medicineDescription.text.isNotEmpty &&
                    _dosage.text.isNotEmpty &&
                    _dose.text.isNotEmpty &&
                    _days.text.isNotEmpty &&
                    _familyMember.text.isNotEmpty &&
                    _memberId != null &&
                    startDate != null &&
                    remainderTime != null &&
                    _listOfTimes.isNotEmpty) {
                  setState(() {
                    _loading = true;
                  });
                  print("StartDate = ${startDate.toIso8601String()}");
                  _listOfTimes.forEach((element) {
                    print(element.toIso8601String());
                  });
                  AddMedicineRequest _request = AddMedicineRequest(
                    medicineName: _medicineName.text,
                    description: _medicineDescription.text,
                    amount: _amountPill,
                    dosage: _dosage.text,
                    doses: _dose.text,
                    duration: _days.text,
                    startDate: startDate,
                    reminderTime: remainderTime,
                    alarmTimer: setAlarm,
                    patient: _memberId,
                    time: List.generate(
                      _listOfTimes.length,
                      (index) => _listOfTimes[index],
                    ),
                  );
                  print("Add Medicine Request ${_request.toJson()}");
                  AddMedicineResponse _response = await addMedicine(_request);
                  print("Add Medicine Response ${_response.toJson()}");

                  if (_response.success == true) {
                    setState(() {
                      _loading = false;
                    });
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
              }
            },
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
