import 'package:flutter/material.dart';
import 'package:health_bloom/model/request/request.dart';
import 'package:health_bloom/model/response/response.dart';
import 'package:health_bloom/utils/loading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../components/custom_contained_button.dart';
import '../../components/textbuilder.dart';
import '../../model/response/get_all_member_response.dart';
import '../../services/api/repository/auth_repository.dart';
import '../../utils/colors.dart';
import '../../utils/drop_down/custom_dropdown.dart';
import '../../utils/text_field/custom_text_field.dart';

class AddReminder extends StatefulWidget {
  final bool edit;
  final GetReminderListResponseDatum data;
  const AddReminder({Key key,this.edit = false,this.data}) : super(key: key);

  @override
  State<AddReminder> createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  TextEditingController _type = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _familyMember = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool _loading = false;
  Future _future;
  String _memberId;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    final TimeOfDay timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );

    if(timeOfDay != null && picked != null) {
      setState(() {
        selectedDate = DateTime(picked.year,picked.month,picked.day,timeOfDay.hour,timeOfDay.minute);
        _date.text =
        "${selectedDate.day}-${selectedDate.month}-${selectedDate.year} - ${DateFormat("hh:mm a").format(selectedDate)}";
      });
    }

  }

  Future<GetAllMemberResponse> getAllMember() async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    GetAllMemberResponse _response = await adminAPI.getAllMemberAPI();
    return _response;
  }

  Future<AddEditReminderResponse> addReminder() async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    AddEditReminderResponse _response = await adminAPI.addReminderAPI(AddReminderRequest(
      reminderType: _type.text,
      dateTime: selectedDate,
      description: _description.text,
      family: _memberId
    ));
    return _response;
  }

  Future<AddEditReminderResponse> editReminder() async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    AddEditReminderResponse _response = await adminAPI.editReminderAPI(EditReminderRequest(
        reminderType: _type.text,
        dateTime: selectedDate,
        description: _description.text,
        family: _memberId,
        id: widget.data.id
    ));
    return _response;
  }

  @override
  void initState() {
    super.initState();
    _future = getAllMember();
    if(widget.edit){
      _type.text = widget.data.reminderType;
      _description.text = widget.data.description;
      _memberId = widget.data.familyObject.id;
      _familyMember.text = widget.data.familyObject.name;
      selectedDate = widget.data.dateTime;
      _date.text =
      "${selectedDate.day}-${selectedDate.month}-${selectedDate.year} - ${selectedDate.hour}:${selectedDate.minute}";
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
        title: TextBuilder(
          text: widget.edit ? "Edit Reminder" : "Add Reminder",
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
        centerTitle: true,
      ),
      backgroundColor: kWhite,
      body: FutureBuilder<GetAllMemberResponse>(
        future: _future,
        builder: (context, data) {
          if (data.hasData) {
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
                      "assets/images/medical_report.jpg",
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
                        children: [
                          SizedBox(height: 5),
                          CustomDropDown(
                            title: "Reminder type",
                            controller: _type,
                            dropDownData: [
                              "CheckUp",
                              "Doctor Appointment",
                              "Test",
                              "Task",
                              "Medical Refilling"
                            ],
                            stateCallback: (int i) {},
                            down: true,
                          ),
                          SizedBox(height: 16),
                          CustomTextField(
                            readOnly: true,
                            maxLines: 1,
                            controller: _date,
                            label: "Date & time",
                            textInputType: TextInputType.text,
                            onChanged: (val) {},
                            onTap: () {
                              _selectDate(context);
                            },
                          ),
                          SizedBox(height: 16),
                          CustomTextField(
                            maxLines: 3,
                            controller: _description,
                            textCapitalization: TextCapitalization.sentences,
                            label: "Description",
                            textInputType: TextInputType.name,
                            onChanged: (val) {},
                            onTap: () {},
                          ),
                          SizedBox(height: 16),
                          CustomDropDown(
                            title: "Select Family Member",
                            controller: _familyMember,
                            dropDownData:
                                data.data.data.map((e) => e.name).toList(),
                            stateCallback: (int i) {
                              _memberId = data.data.data[i].id;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if(_loading)
                  LoadingWidget()
              ],
            );
          } else {
            return LoadingWidget();
          }
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
            text: widget.edit ? "Save" : "Add",
            onPressed: () async {
              if(_date.text.isNotEmpty && _type.text.isNotEmpty && _description.text.isNotEmpty && _memberId != null){
                setState(() {
                  _loading = true;
                });
                if(widget.edit){
                  await editReminder();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added Successfully"),));
                  Navigator.pop(context);
                }else{
                  await addReminder();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added Successfully"),));
                  Navigator.pop(context);
                }
              }else{
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill all the details first!"),));
              }
            },
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
