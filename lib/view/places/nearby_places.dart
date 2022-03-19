import 'package:flutter/material.dart';
import 'package:health_bloom/model/request/request.dart';
import 'package:health_bloom/model/response/response.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:health_bloom/utils/map_utils.dart';
import 'package:health_bloom/view/places/place_details.dart';
import 'package:health_bloom/view/places/widgets/custom_nearby_switch.dart';
import 'package:provider/provider.dart';
import '../../services/api/repository/auth_repository.dart';
import '../../utils/custom_add_element_bs.dart';
import '../../utils/custom_bnb.dart';
import '../../utils/drawer/custom_drawer.dart';

class NearbyPlaces extends StatefulWidget {
  const NearbyPlaces({Key key}) : super(key: key);

  @override
  _NearbyPlacesState createState() => _NearbyPlacesState();
}

class _NearbyPlacesState extends State<NearbyPlaces> {
  String _hours = 'Any time';
  String _rating = 'Any';
  String _distance = '500';
  bool _isMedical = false;
  String _lat = "18.457533";
  String _lng = "73.867744";
  MapsNearbyMedicalsResponse _commonResponse;

  Future getNearbyMedicals() async {
    _commonResponse = null;
    setState(() {});
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    MapsNearbyMedicalsResponse _response = await adminAPI.getNearbyMedicalsAPI(
        MapsNearbyMedicalsRequest(
            hours: _hours,
            distance: _distance,
            latitude: _lat,
            longitude: _lng,
            rating: _rating));
    _commonResponse = _response;
    setState(() {});
  }

  Future getNearbyLabs() async {
    _commonResponse = null;
    setState(() {});
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    MapsNearbyMedicalsResponse _response = await adminAPI.getNearbyLabsAPI(
        MapsNearbyMedicalsRequest(
            hours: _hours,
            distance: _distance,
            latitude: _lat,
            longitude: _lng,
            rating: _rating));
    _commonResponse = _response;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    MapUtils.determinePosition().then((value) {
      _lat = value.latitude.toString();
      _lng = value.longitude.toString();
      getNearbyLabs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        backgroundColor: kWhite,
        drawer: CustomDrawer(
          selected: -1,
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kMainColor,
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(bottom: 16),
              color: kMainColor,
              child: Column(
                children: [
                  Text(
                    "What are you looking for?",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                        color: kWhite),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  CustomNearbySwitch(
                    onChanged: (bool medical) {
                      setState(() {
                        _isMedical = medical;
                      });
                      if (medical) {
                        getNearbyMedicals();
                      } else {
                        getNearbyLabs();
                      }
                    },
                  )
                ],
              ),
            ),
            _isMedical
                ? Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: kMainColor),
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      canvasColor: Color(0xff9D93EC),
                                    ),
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: _hours,
                                      icon: const Icon(
                                        Icons.arrow_drop_down_outlined,
                                        color: kWhite,
                                      ),
                                      elevation: 16,
                                      style: const TextStyle(color: kWhite),
                                      underline: Container(),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          _hours = newValue;
                                        });
                                        getNearbyMedicals();
                                      },
                                      items: <String>[
                                        'Any time',
                                        'Open now',
                                        'Open 24 hours',
                                        'Sunday',
                                        'Monday',
                                        'Tuesday',
                                        'Wednesday',
                                        'Thursday',
                                        'Friday',
                                        'Saturday',
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: kMainColor),
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      canvasColor: Color(0xff9D93EC),
                                    ),
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: _rating,
                                      icon: const Icon(
                                        Icons.arrow_drop_down_outlined,
                                        color: kWhite,
                                      ),
                                      elevation: 16,
                                      style: const TextStyle(color: kWhite),
                                      underline: Container(),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          _rating = newValue;
                                        });
                                        getNearbyMedicals();
                                      },
                                      items: <String>[
                                        'Any',
                                        '4.5',
                                        '4',
                                        '3.5',
                                        '3',
                                        '2.5',
                                        '2',
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: kMainColor),
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      canvasColor: Color(0xff9D93EC),
                                    ),
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: _distance,
                                      icon: const Icon(
                                        Icons.arrow_drop_down_outlined,
                                        color: kWhite,
                                      ),
                                      elevation: 16,
                                      style: const TextStyle(color: kWhite),
                                      underline: Container(),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          _distance = newValue;
                                        });
                                        getNearbyMedicals();
                                      },
                                      items: <String>['500', '600', '700', '800']
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          _commonResponse != null
                              ? ListView.builder(
                                padding: EdgeInsets.only(top: 8,bottom: 24),
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: _commonResponse.data.results.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) {
                                          return NearbyPlaceDetails(
                                              data: _commonResponse
                                                  .data.results[index]);
                                        }));
                                      },
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 16),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: kMainColorExtraLite,
                                                    width: 1))),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _commonResponse
                                                            .data
                                                            .results[index]
                                                            .name ??
                                                        "-",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: kMainColor),
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    _commonResponse
                                                            .data
                                                            .results[index]
                                                            .vicinity ??
                                                        "-",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: kGrey4),
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  if (_commonResponse
                                                          .data
                                                          .results[index]
                                                          .openingHours !=
                                                      null)
                                                    if (_commonResponse
                                                            .data
                                                            .results[index]
                                                            .openingHours
                                                            .openNow !=
                                                        null)
                                                      Text(
                                                        _commonResponse
                                                                .data
                                                                .results[index]
                                                                .openingHours
                                                                .openNow
                                                            ? "Open"
                                                            : "Closed",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: _commonResponse
                                                                    .data
                                                                    .results[
                                                                        index]
                                                                    .openingHours
                                                                    .openNow
                                                                ? Colors.green
                                                                : Colors
                                                                    .redAccent),
                                                      ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    MapUtils.openMap(
                                                        _commonResponse
                                                            .data
                                                            .results[index]
                                                            .geometry
                                                            .location
                                                            .lat,
                                                        _commonResponse
                                                            .data
                                                            .results[index]
                                                            .geometry
                                                            .location
                                                            .lng);
                                                  },
                                                  icon: Icon(
                                                    Icons.directions,
                                                    size: 30,
                                                    color: Color(0xff4285F4),
                                                  ),
                                                ),
                                                Text(
                                                  "DIRECTIONS",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Color(0xff4285F4),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Container(
                                  height: 300,
                                  width: double.infinity,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: kMainColor),
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      canvasColor: Color(0xff9D93EC),
                                    ),
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: _hours,
                                      icon: const Icon(
                                        Icons.arrow_drop_down_outlined,
                                        color: kWhite,
                                      ),
                                      elevation: 16,
                                      style: const TextStyle(color: kWhite),
                                      underline: Container(),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          _hours = newValue;
                                        });
                                        getNearbyLabs();
                                      },
                                      items: <String>[
                                        'Any time',
                                        'Open now',
                                        'Open 24 hours',
                                        'Sunday',
                                        'Monday',
                                        'Tuesday',
                                        'Wednesday',
                                        'Thursday',
                                        'Friday',
                                        'Saturday',
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: kMainColor),
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      canvasColor: Color(0xff9D93EC),
                                    ),
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: _rating,
                                      icon: const Icon(
                                        Icons.arrow_drop_down_outlined,
                                        color: kWhite,
                                      ),
                                      elevation: 16,
                                      style: const TextStyle(color: kWhite),
                                      underline: Container(),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          _rating = newValue;
                                        });
                                        getNearbyLabs();
                                      },
                                      items: <String>[
                                        'Any',
                                        '4.5',
                                        '4',
                                        '3.5',
                                        '3',
                                        '2.5',
                                        '2',
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: kMainColor),
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      canvasColor: Color(0xff9D93EC),
                                    ),
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: _distance,
                                      icon: const Icon(
                                        Icons.arrow_drop_down_outlined,
                                        color: kWhite,
                                      ),
                                      elevation: 16,
                                      style: const TextStyle(color: kWhite),
                                      underline: Container(),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          _distance = newValue;
                                        });
                                        getNearbyLabs();
                                      },
                                      items: <String>['500', '600', '700', '800']
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          _commonResponse != null
                              ? ListView.builder(
                            padding: EdgeInsets.only(top: 8,bottom: 24),
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: _commonResponse.data.results.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) {
                                          return NearbyPlaceDetails(
                                              data: _commonResponse
                                                  .data.results[index]);
                                        }));
                                      },
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 16),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: kMainColorExtraLite,
                                                    width: 1))),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _commonResponse
                                                            .data
                                                            .results[index]
                                                            .name ??
                                                        "-",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: kMainColor),
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    _commonResponse
                                                            .data
                                                            .results[index]
                                                            .vicinity ??
                                                        "-",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: kGrey4),
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  if (_commonResponse
                                                          .data
                                                          .results[index]
                                                          .openingHours !=
                                                      null)
                                                    if (_commonResponse
                                                            .data
                                                            .results[index]
                                                            .openingHours
                                                            .openNow !=
                                                        null)
                                                      Text(
                                                        _commonResponse
                                                                .data
                                                                .results[index]
                                                                .openingHours
                                                                .openNow
                                                            ? "Open"
                                                            : "Closed",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: _commonResponse
                                                                    .data
                                                                    .results[
                                                                        index]
                                                                    .openingHours
                                                                    .openNow
                                                                ? Colors.green
                                                                : Colors
                                                                    .redAccent),
                                                      ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    MapUtils.openMap(
                                                        _commonResponse
                                                            .data
                                                            .results[index]
                                                            .geometry
                                                            .location
                                                            .lat,
                                                        _commonResponse
                                                            .data
                                                            .results[index]
                                                            .geometry
                                                            .location
                                                            .lng);
                                                  },
                                                  icon: Icon(
                                                    Icons.directions,
                                                    size: 30,
                                                    color: Color(0xff4285F4),
                                                  ),
                                                ),
                                                Text(
                                                  "DIRECTIONS",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Color(0xff4285F4),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Container(
                                  height: 300,
                                  width: double.infinity,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                        ],
                      ),
                    ),
                  ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext bc) {
                return CustomAddElementBs(
                  onChanged: () {
                    Navigator.pop(context);
                  },
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: CustomBnb(
          current: 2,
        ),
      ),
    );
  }
}
