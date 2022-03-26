import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/model/request/request.dart';
import 'package:health_bloom/model/response/response.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:health_bloom/utils/loading.dart';
import 'package:health_bloom/view/reminder/add_reminder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../services/api/repository/auth_repository.dart';
import '../../utils/custom_add_element_bs.dart';
import '../../utils/custom_bnb.dart';
import '../../utils/drawer/custom_drawer.dart';

class Journal extends StatefulWidget {
  const Journal({Key key}) : super(key: key);

  @override
  _JournalState createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  DateTime _selectedDate = DateTime.now();
  final ScrollController _controller = ScrollController();
  bool _loading = false;
  bool _popLoading = false;
  GetReminderListResponse _currentResponse;
  TextEditingController _searchController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future getAllReminder() async {
    setState(() {
      _currentResponse = null;
    });
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    GetReminderListResponse _response = await adminAPI.getAllReminderAPI();
    _currentResponse = _response;
    setState(() {});
  }

  Future<MedicineCheckUncheckResponse> checkUncheckTask(MedicineCheckUncheckRequest request) async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    MedicineCheckUncheckResponse _response = await adminAPI.medicineCheckUncheckAPI(request);
    return _response;
  }

  @override
  void initState() {
    super.initState();
    getAllReminder();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        drawer: CustomDrawer(
          selected: -1,
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xff8B80F8),
          title: Text("Journal"),
          centerTitle: true,
        ),
        body: _currentResponse == null
            ? LoadingWidget()
            : Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 145,
                      color: Color(0xff8B80F8),
                      child: ListView(
                        controller: _controller,
                        padding: EdgeInsets.only(
                            bottom: 43, top: 10, left: 20, right: 20),
                        scrollDirection: Axis.horizontal,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                _selectedDate =
                                    _selectedDate.subtract(Duration(days: 2));
                              });
                              _controller.animateTo(0.0,
                                  duration: Duration(milliseconds: 150),
                                  curve: Curves.ease);
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 8),
                              height: 100,
                              width: 50,
                              decoration: BoxDecoration(
                                  //color: kMainColor,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Spacer(
                                    flex: 2,
                                  ),
                                  Text(
                                    calculateDay(_selectedDate
                                        .subtract(Duration(days: 2))
                                        .weekday),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: kWhite),
                                  ),
                                  Spacer(),
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: kWhite,
                                    child: Center(
                                      child: Text(
                                        _selectedDate
                                            .subtract(Duration(days: 2))
                                            .day
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: kMainColor),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _selectedDate =
                                    _selectedDate.subtract(Duration(days: 1));
                              });
                              _controller.animateTo(0.0,
                                  duration: Duration(milliseconds: 150),
                                  curve: Curves.ease);
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 8),
                              height: 100,
                              width: 50,
                              decoration: BoxDecoration(
                                  //color: kMainColor,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Spacer(
                                    flex: 2,
                                  ),
                                  Text(
                                    calculateDay(_selectedDate
                                        .subtract(Duration(days: 1))
                                        .weekday),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: kWhite),
                                  ),
                                  Spacer(),
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: kWhite,
                                    child: Center(
                                      child: Text(
                                        _selectedDate
                                            .subtract(Duration(days: 1))
                                            .day
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: kMainColor),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 8),
                            height: 100,
                            width: 50,
                            decoration: BoxDecoration(
                                color: kMainColor,
                                borderRadius: BorderRadius.circular(50)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Spacer(
                                  flex: 2,
                                ),
                                Text(
                                  calculateDay(_selectedDate.weekday),
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: kWhite),
                                ),
                                Spacer(),
                                CircleAvatar(
                                  radius: 18,
                                  backgroundColor: kWhite,
                                  child: Center(
                                    child: Text(
                                      _selectedDate.day.toString(),
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: kMainColor),
                                    ),
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _selectedDate =
                                    _selectedDate.add(Duration(days: 1));
                              });
                              _controller.animateTo(0.0,
                                  duration: Duration(milliseconds: 150),
                                  curve: Curves.ease);
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 8),
                              height: 100,
                              width: 50,
                              decoration: BoxDecoration(
                                  //color: kMainColor,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Spacer(
                                    flex: 2,
                                  ),
                                  Text(
                                    calculateDay(_selectedDate
                                        .add(Duration(days: 1))
                                        .weekday),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: kWhite),
                                  ),
                                  Spacer(),
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: kWhite,
                                    child: Center(
                                      child: Text(
                                        _selectedDate
                                            .add(Duration(days: 1))
                                            .day
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: kMainColor),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _selectedDate =
                                    _selectedDate.add(Duration(days: 2));
                              });
                              _controller.animateTo(0.0,
                                  duration: Duration(milliseconds: 150),
                                  curve: Curves.ease);
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 8),
                              height: 100,
                              width: 50,
                              decoration: BoxDecoration(
                                  //color: kMainColor,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Spacer(
                                    flex: 2,
                                  ),
                                  Text(
                                    calculateDay(_selectedDate
                                        .add(Duration(days: 2))
                                        .weekday),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: kWhite),
                                  ),
                                  Spacer(),
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: kWhite,
                                    child: Center(
                                      child: Text(
                                        _selectedDate
                                            .add(Duration(days: 2))
                                            .day
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: kMainColor),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _selectedDate =
                                    _selectedDate.add(Duration(days: 3));
                              });
                              _controller.animateTo(0.0,
                                  duration: Duration(milliseconds: 150),
                                  curve: Curves.ease);
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 8),
                              height: 100,
                              width: 50,
                              decoration: BoxDecoration(
                                  //color: kMainColor,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Spacer(
                                    flex: 2,
                                  ),
                                  Text(
                                    calculateDay(_selectedDate
                                        .add(Duration(days: 3))
                                        .weekday),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: kWhite),
                                  ),
                                  Spacer(),
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: kWhite,
                                    child: Center(
                                      child: Text(
                                        _selectedDate
                                            .add(Duration(days: 3))
                                            .day
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: kMainColor),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _selectedDate =
                                    _selectedDate.add(Duration(days: 4));
                              });
                              _controller.animateTo(0.0,
                                  duration: Duration(milliseconds: 150),
                                  curve: Curves.ease);
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 8),
                              height: 100,
                              width: 50,
                              decoration: BoxDecoration(
                                  //color: kMainColor,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Spacer(
                                    flex: 2,
                                  ),
                                  Text(
                                    calculateDay(_selectedDate
                                        .add(Duration(days: 4))
                                        .weekday),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: kWhite),
                                  ),
                                  Spacer(),
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: kWhite,
                                    child: Center(
                                      child: Text(
                                        _selectedDate
                                            .add(Duration(days: 4))
                                            .day
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: kMainColor),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _selectedDate =
                                    _selectedDate.add(Duration(days: 5));
                              });
                              _controller.animateTo(0.0,
                                  duration: Duration(milliseconds: 150),
                                  curve: Curves.ease);
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 8),
                              height: 100,
                              width: 50,
                              decoration: BoxDecoration(
                                  //color: kMainColor,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Spacer(
                                    flex: 2,
                                  ),
                                  Text(
                                    calculateDay(_selectedDate
                                        .add(Duration(days: 5))
                                        .weekday),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: kWhite),
                                  ),
                                  Spacer(),
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: kWhite,
                                    child: Center(
                                      child: Text(
                                        _selectedDate
                                            .add(Duration(days: 5))
                                            .day
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: kMainColor),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _selectedDate =
                                    _selectedDate.add(Duration(days: 6));
                              });
                              _controller.animateTo(0.0,
                                  duration: Duration(milliseconds: 150),
                                  curve: Curves.ease);
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 8),
                              height: 100,
                              width: 50,
                              decoration: BoxDecoration(
                                  //color: kMainColor,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Spacer(
                                    flex: 2,
                                  ),
                                  Text(
                                    calculateDay(_selectedDate
                                        .add(Duration(days: 6))
                                        .weekday),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: kWhite),
                                  ),
                                  Spacer(),
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: kWhite,
                                    child: Center(
                                      child: Text(
                                        _selectedDate
                                            .add(Duration(days: 6))
                                            .day
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: kMainColor),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _selectDate(context).whenComplete(() {
                                _controller.animateTo(0.0,
                                    duration: Duration(milliseconds: 150),
                                    curve: Curves.ease);
                              });
                            },
                            child: Center(
                              child: Container(
                                margin: EdgeInsets.only(right: 8),
                                height: 80,
                                width: 70,
                                decoration: BoxDecoration(
                                    //color: kMainColor,
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(color: kWhite)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Spacer(),
                                    Text(
                                      "CHOOSE",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: kWhite),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.calendar_today,
                                      size: 30,
                                      color: kWhite,
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 120,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.only(left: 24, right: 24, top: 26),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          ),
                          color: Color(0xffF4F5F9)),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: kWhite,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 10,
                                      offset: Offset(0.0, 2.0))
                                ]),
                            padding: EdgeInsets.symmetric(horizontal: 14),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: kGrey4,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextField(
                                    onChanged: (v){
                                      setState(() {});
                                    },
                                    controller: _searchController,
                                    decoration: InputDecoration(
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: "Search..",
                                        hintStyle: TextStyle(color: kGrey4)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 10,
                                        offset: Offset(0.0, 2.0))
                                  ]),
                              padding:
                                  EdgeInsets.only(right: 20, left: 20, top: 16),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "To Take",
                                        style: TextStyle(
                                            fontSize: 18, color: kMainColor),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return AddReminder();
                                          })).whenComplete(() => getAllReminder());
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              color: kMainColorExtraLite),
                                          child: Center(
                                            child: Icon(
                                              Icons.add,
                                              color: kMainColor,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Expanded(
                                    child: ListView.separated(
                                      padding:
                                          EdgeInsets.only(top: 16, bottom: 16),
                                      itemCount: _currentResponse.data.length,
                                      itemBuilder: (context, index) {
                                        if (_selectedDate.day ==
                                                _currentResponse
                                                    .data[index].dateTime.day &&
                                            _selectedDate.month ==
                                                _currentResponse.data[index]
                                                    .dateTime.month &&
                                            _selectedDate.year ==
                                                _currentResponse
                                                    .data[index].dateTime.year)
                                          if(_currentResponse
                                              .data[index]
                                              .reminderType.toLowerCase().contains(_searchController.text.toLowerCase()) || _currentResponse
                                              .data[index]
                                              .familyObject.name.toLowerCase().contains(_searchController.text.toLowerCase()))
                                          return Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xffE1E1E1),
                                                borderRadius:
                                                BorderRadius.circular(16)),
                                            height: 120,
                                            child: Slidable(
                                              startActionPane: ActionPane(
                                                extentRatio: 0.3,
                                                motion: const BehindMotion(),
                                                children: [
                                                  if(_currentResponse
                                                      .data[index]
                                                      .reminderType == "Medicine")
                                                    SlidableAction(
                                                      onPressed: (c) async{
                                                        setState(() {
                                                          _loading = true;
                                                        });
                                                        MedicineCheckUncheckRequest _request = MedicineCheckUncheckRequest(
                                                            id: _currentResponse
                                                                .data[index].id
                                                        );
                                                        print(_request.toJson().toString());
                                                        await checkUncheckTask(_request);
                                                        setState(() {
                                                          _loading = false;
                                                        });
                                                        getAllReminder();
                                                      },
                                                      backgroundColor: Colors.transparent,
                                                      foregroundColor: Color(0xff8B80F8),
                                                      icon: _currentResponse
                                                          .data[index].check ? Icons.close : Icons.done,
                                                      label: _currentResponse
                                                          .data[index].check ? "Uncheck" : 'Check',
                                                    ),
                                                ],
                                              ),
                                              endActionPane: ActionPane(
                                                extentRatio: 0.3,
                                                motion: const BehindMotion(),
                                                children: [
                                                  if(_currentResponse
                                                      .data[index]
                                                      .reminderType == "Medicine")
                                                    SlidableAction(
                                                      onPressed: (c) async{
                                                        setState(() {
                                                          _loading = true;
                                                        });
                                                        MedicineCheckUncheckRequest _request = MedicineCheckUncheckRequest(
                                                            id: _currentResponse
                                                                .data[index].id
                                                        );
                                                        print(_request.toJson().toString());
                                                        await checkUncheckTask(_request);
                                                        setState(() {
                                                          _loading = false;
                                                        });
                                                        getAllReminder();
                                                      },
                                                      backgroundColor: Colors.transparent,
                                                      foregroundColor: Color(0xff8B80F8),
                                                      icon: _currentResponse
                                                          .data[index].check ? Icons.close : Icons.done,
                                                      label: _currentResponse
                                                          .data[index].check ? "Uncheck" : 'Check',
                                                    ),
                                                ],
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Color(0xff8B80F8),
                                                    borderRadius:
                                                        BorderRadius.circular(16)),
                                                height: 120,
                                                padding: EdgeInsets.only(
                                                    left: 8,
                                                    right: 8,
                                                    top: 8,
                                                    bottom: 8),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 80,
                                                      child: Image.asset(
                                                          "assets/images/drug1.png"),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            _currentResponse
                                                                .data[index]
                                                                .reminderType,
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight.w700,
                                                                color: kWhite),
                                                            maxLines: 1,
                                                          ),
                                                          Text(
                                                            _currentResponse
                                                                .data[index]
                                                                .description,
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight.w300,
                                                                color: kWhite),
                                                            maxLines: 2,
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                          ),
                                                          Text(
                                                            '${DateFormat('hh:mm a').format(_currentResponse.data[index].dateTime).toString()}',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight.w600,
                                                                color: kWhite),
                                                            maxLines: 1,
                                                          ),
                                                          Text(
                                                            "${_currentResponse.data[index].familyObject.name}",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight.w300,
                                                                color: kWhite),
                                                            maxLines: 1,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    if(_currentResponse
                                                        .data[index]
                                                        .reminderType != "Medicine")
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            showDialog(
                                                              context: context,
                                                              useSafeArea: true,
                                                              barrierDismissible:
                                                                  true,
                                                              builder: (context) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                      'Delete'),
                                                                  content: Text(
                                                                      'Are you sure!'),
                                                                  actions: [
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child: TextBuilder(
                                                                            text:
                                                                                'No')),
                                                                    MaterialButton(
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                  6)),
                                                                      color: Color(
                                                                          0xffFF9B91),
                                                                      onPressed:
                                                                          () async {
                                                                        // setState(() {
                                                                        //   _popLoading = true;
                                                                        // });
                                                                        final adminAPI = Provider.of<
                                                                                NetworkRepository>(
                                                                            context,
                                                                            listen:
                                                                                false);
                                                                        AddEditReminderResponse
                                                                            _response =
                                                                            await adminAPI
                                                                                .deleteReminderAPI(DeleteReminderRequest(id: _currentResponse.data[index].id));
                                                                        if (_response
                                                                            .success) {
                                                                          _currentResponse.data.removeWhere((element) =>
                                                                              element
                                                                                  .id ==
                                                                              _currentResponse
                                                                                  .data[index]
                                                                                  .id);
                                                                          ScaffoldMessenger.of(
                                                                                  context)
                                                                              .showSnackBar(
                                                                                  SnackBar(
                                                                            content:
                                                                                Text('Your reminder has been deleted successfully'),
                                                                          ));

                                                                          Navigator.pop(
                                                                              context);
                                                                        }
                                                                        // setState(() {
                                                                        //   _popLoading = false;
                                                                        // });
                                                                      },
                                                                      child:
                                                                          TextBuilder(
                                                                        text: 'Yes',
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    )
                                                                  ],
                                                                );
                                                                ;
                                                              },
                                                            ).whenComplete(
                                                                () => setState(() {
                                                                      // getNextMedicine();
                                                                    }));
                                                          },
                                                          child: Icon(
                                                            Icons.delete,
                                                            color: kWhite,
                                                          ),
                                                        ),
                                                        SizedBox(height: 50),
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.push(context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) {
                                                              return AddReminder(
                                                                edit: true,
                                                                data:
                                                                    _currentResponse
                                                                            .data[
                                                                        index],
                                                              );
                                                            })).whenComplete(() {
                                                              getAllReminder();
                                                            });
                                                          },
                                                          child: Icon(
                                                            Icons.edit,
                                                            color: kWhite,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        return Container();
                                      }, separatorBuilder: (BuildContext context, int index) {
                                      if (_selectedDate.day ==
                                          _currentResponse
                                              .data[index].dateTime.day &&
                                          _selectedDate.month ==
                                              _currentResponse.data[index]
                                                  .dateTime.month &&
                                          _selectedDate.year ==
                                              _currentResponse
                                                  .data[index].dateTime.year)
                                        if(_currentResponse
                                            .data[index]
                                            .reminderType.toLowerCase().contains(_searchController.text.toLowerCase()) || _currentResponse
                                            .data[index]
                                            .familyObject.name.toLowerCase().contains(_searchController.text.toLowerCase()))
                                          return Container(height: 14,);

                                        return Container();
                                        },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_loading) LoadingWidget()
                ],
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext bc) {
                return CustomAddElementBs(
                  onChanged: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                    getAllReminder();
                  },
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: CustomBnb(
          current: 1,
        ),
      ),
    );
  }

  calculateDay(int i) {
    if (i == 1) {
      return "MON";
    }
    if (i == 2) {
      return "TUE";
    }
    if (i == 3) {
      return "WED";
    }
    if (i == 4) {
      return "THU";
    }
    if (i == 5) {
      return "FRI";
    }
    if (i == 6) {
      return "SAT";
    }
    if (i == 7) {
      return "SUN";
    }
  }
}
