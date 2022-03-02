import 'package:flutter/material.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/model/request/add_medicine_request.dart';
import 'package:health_bloom/model/response/add_medicine_response.dart';
import 'package:health_bloom/model/response/response.dart';
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
  TextEditingController _duration = TextEditingController();
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
      });

      _date.text = "${startDate.day}/${startDate.month}/${startDate.year}";
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
        title: Text(widget.bill != null ? "Edit Medicine" : "Add Medicine"),
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
                          CustomTextField(
                            readOnly: true,
                            maxLines: 1,
                            controller: _date,
                            label: "Start Date",
                            textInputType: TextInputType.text,
                            onChanged: () {},
                            onTap: () {
                              _startDate(context);
                            },
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
                                text: 'Add remainder',
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
              if (_medicineName.text.isNotEmpty &&
                  _date.text.isNotEmpty &&
                  _dosage.text.isNotEmpty &&
                  _dose.text.isNotEmpty &&
                  _duration.text.isNotEmpty &&
                  _familyMember.text.isNotEmpty &&
                  _memberId != null &&
                  startDate != null &&
                  remainderTime != null) {
                setState(() {
                  _loading = true;
                });
                AddMedicineRequest _request = AddMedicineRequest(
                  medicineName: _medicineName.text,
                  amount: _amountPill,
                  dosage: int.parse(_dosage.text),
                  doses: int.parse(_dose.text),
                  duration: _duration.text,
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
            },
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
