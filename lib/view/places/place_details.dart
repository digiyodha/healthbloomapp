import 'package:flutter/material.dart';
import 'package:health_bloom/model/request/request.dart';
import 'package:health_bloom/utils/expanded_section.dart';
import 'package:health_bloom/utils/loading.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import '../../model/response/response.dart';
import '../../services/api/repository/auth_repository.dart';
import '../../utils/colors.dart';

class NearbyPlaceDetails extends StatefulWidget {
  final MapsNearbyMedicalsResponseResult data;
  const NearbyPlaceDetails({Key key, this.data}) : super(key: key);

  @override
  State<NearbyPlaceDetails> createState() => _NearbyPlaceDetailsState();
}

class _NearbyPlaceDetailsState extends State<NearbyPlaceDetails> {
  Future _future;
  bool _hrsExpanded = false;
  int _oneStar = 0;
  int _twoStar = 0;
  int _threeStar = 0;
  int _fourStar = 0;
  int _fiveStar = 0;

  Future<MapsPlaceDetailsResponse> getPlaceDetails() async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    MapsPlaceDetailsResponse _response = await adminAPI.getPlaceDetailsAPI(
        MapsPlaceDetailsRequest(placeId: widget.data.placeId));
    _response.data.result.reviews.forEach((element) {
      if (element.rating == 1) {
        _oneStar++;
      }
      if (element.rating == 2) {
        _twoStar++;
      }
      if (element.rating == 3) {
        _threeStar++;
      }
      if (element.rating == 4) {
        _fourStar++;
      }
      if (element.rating == 5) {
        _fiveStar++;
      }
    });
    return _response;
  }

  @override
  void initState() {
    super.initState();
    _future = getPlaceDetails();
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
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Share.share(
                  'check out ${widget.data.name}\nAddress - ${widget.data.vicinity}\n https://www.google.com/maps/search/?api=1&query=${widget.data.geometry.location.lat},${widget.data.geometry.location.lng}');
            },
          )
        ],
      ),
      backgroundColor: kWhite,
      body: FutureBuilder<MapsPlaceDetailsResponse>(
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
                  top: 180,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    color: kWhite,
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.data.data.result.name ?? "-",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: kGrey6),
                                    ),
                                    SizedBox(height: 10),
                                    if (data.data.data.result.rating != null)
                                      Row(
                                        children: [
                                          Text(
                                            data.data.data.result.rating
                                                    .toString() ??
                                                "-",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: kMainColor),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          getStars(data.data.data.result.rating)
                                        ],
                                      ),
                                    if (data.data.data.result.rating != null)
                                      SizedBox(height: 10),
                                    if (data.data.data.result
                                            .formattedPhoneNumber !=
                                        null)
                                      Row(
                                        children: [
                                          Text(
                                            'Phone',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: kGrey6),
                                          ),
                                          const SizedBox(width: 10.0),
                                          Text(
                                            data.data.data.result
                                                .formattedPhoneNumber,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.redAccent),
                                          ),
                                        ],
                                      ),
                                    if (data.data.data.result
                                            .formattedPhoneNumber !=
                                        null)
                                      SizedBox(height: 10),
                                    Text(
                                      data.data.data.result.vicinity ?? "-",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: kGrey5),
                                    ),
                                    SizedBox(height: 10),
                                    if (data.data.data.result.openingHours !=
                                        null)
                                      if (data.data.data.result.openingHours
                                              .openNow !=
                                          null)
                                        Text(
                                          data.data.data.result.openingHours
                                                  .openNow
                                              ? "Open"
                                              : "Closed",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: data.data.data.result
                                                      .openingHours.openNow
                                                  ? Colors.green
                                                  : Colors.redAccent),
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
                                      MapsLauncher.launchCoordinates(
                                          data.data.data.result.geometry
                                              .location.lat,
                                          data.data.data.result.geometry
                                              .location.lng);
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
                                      fontSize: 12,
                                      color: Color(0xff4285F4),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          if (data.data.data.result.openingHours != null)
                            if (data.data.data.result.openingHours.weekdayText
                                .isNotEmpty)
                              Divider(
                                height: 1,
                                thickness: 1.5,
                                color: kMainColor,
                              ),
                          if (data.data.data.result.openingHours != null)
                            if (data.data.data.result.openingHours.weekdayText
                                .isNotEmpty)
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _hrsExpanded = !_hrsExpanded;
                                      });
                                    },
                                    child: Container(
                                      height: 50,
                                      child: Row(
                                        children: [
                                          Icon(Icons.watch_later_outlined,
                                              color: kMainColor),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                              child: Text(
                                            "${data.data.data.result.openingHours.weekdayText[0]}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: kMainColor),
                                          )),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            _hrsExpanded
                                                ? Icons.keyboard_arrow_up
                                                : Icons.keyboard_arrow_down,
                                            color: kMainColor,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  ExpandedSection(
                                    expand: _hrsExpanded,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: List.generate(
                                          data.data.data.result.openingHours
                                              .weekdayText.length, (index) {
                                        return index != 0
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 14),
                                                child: Text(
                                                  "${data.data.data.result.openingHours.weekdayText[index]}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: kMainColor),
                                                ),
                                              )
                                            : Container();
                                      }).toList(),
                                    ),
                                  )
                                ],
                              ),
                          Divider(
                            height: 1,
                            thickness: 1.5,
                            color: kMainColor,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          if (data.data.data.result.reviews.isNotEmpty)
                            Text(
                              "Review Summary",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: kGrey6),
                            ),
                          if (data.data.data.result.reviews.isNotEmpty)
                            SizedBox(
                              height: 20,
                            ),
                          if (data.data.data.result.reviews.isNotEmpty)
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "5",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: kMainColor),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                child: LinearProgressIndicator(
                                                  backgroundColor:
                                                      Color(0xffE5E5E5),
                                                  color: Color(0xffFBBC02),
                                                  value: _fiveStar /
                                                      data.data.data.result
                                                          .reviews.length,
                                                ),
                                                height: 10,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "4",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: kMainColor),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                child: LinearProgressIndicator(
                                                  backgroundColor:
                                                      Color(0xffE5E5E5),
                                                  color: Color(0xffFBBC02),
                                                  value: _fourStar /
                                                      data.data.data.result
                                                          .reviews.length,
                                                ),
                                                height: 10,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "3",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: kMainColor),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                child: LinearProgressIndicator(
                                                  backgroundColor:
                                                      Color(0xffE5E5E5),
                                                  color: Color(0xffFBBC02),
                                                  value: _threeStar /
                                                      data.data.data.result
                                                          .reviews.length,
                                                ),
                                                height: 10,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "2",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: kMainColor),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                child: LinearProgressIndicator(
                                                  backgroundColor:
                                                      Color(0xffE5E5E5),
                                                  color: Color(0xffFBBC02),
                                                  value: _twoStar /
                                                      data.data.data.result
                                                          .reviews.length,
                                                ),
                                                height: 10,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "1",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: kMainColor),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                child: LinearProgressIndicator(
                                                  backgroundColor:
                                                      Color(0xffE5E5E5),
                                                  color: Color(0xffFBBC02),
                                                  value: _oneStar /
                                                      data.data.data.result
                                                          .reviews.length,
                                                ),
                                                height: 10,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        if (data.data.data.result.rating !=
                                            null)
                                          Text(
                                            data.data.data.result.rating
                                                    .toString() ??
                                                "-",
                                            style: TextStyle(
                                                fontSize: 46,
                                                fontWeight: FontWeight.w500,
                                                color: kMainColor),
                                          ),
                                        if (data.data.data.result.rating !=
                                            null)
                                          SizedBox(
                                            width: 20,
                                          ),
                                        if (data.data.data.result.rating !=
                                            null)
                                          getStarsCenter(
                                              data.data.data.result.rating)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          } else {
            return LoadingWidget();
          }
        },
      ),
    );
  }

  Widget getStars(double rating) {
    if (rating > 4.0) {
      return Row(
        children: [
          Icon(
            Icons.star,
            color: Color(0xffFBBC02),
            size: 18,
          ),
          Icon(
            Icons.star,
            color: Color(0xffFBBC02),
            size: 18,
          ),
          Icon(
            Icons.star,
            color: Color(0xffFBBC02),
            size: 18,
          ),
          Icon(
            Icons.star,
            color: Color(0xffFBBC02),
            size: 18,
          ),
          Icon(
            Icons.star,
            color: Color(0xffFBBC02),
            size: 18,
          ),
        ],
      );
    } else if (rating > 3.0) {
      return Row(
        children: [
          Icon(
            Icons.star,
            color: Color(0xffFBBC02),
            size: 18,
          ),
          Icon(
            Icons.star,
            color: Color(0xffFBBC02),
            size: 18,
          ),
          Icon(
            Icons.star,
            color: Color(0xffFBBC02),
            size: 18,
          ),
          Icon(
            Icons.star,
            color: Color(0xffFBBC02),
            size: 18,
          ),
        ],
      );
    } else if (rating > 2.0) {
      return Row(
        children: [
          Icon(
            Icons.star,
            color: Color(0xffFBBC02),
            size: 18,
          ),
          Icon(
            Icons.star,
            color: Color(0xffFBBC02),
            size: 18,
          ),
          Icon(
            Icons.star,
            color: Color(0xffFBBC02),
            size: 18,
          ),
        ],
      );
    } else if (rating > 1.0) {
      return Row(
        children: [
          Icon(
            Icons.star,
            color: Color(0xffFBBC02),
            size: 18,
          ),
          Icon(
            Icons.star,
            color: Color(0xffFBBC02),
            size: 18,
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Icon(
            Icons.star,
            color: Color(0xffFBBC02),
            size: 18,
          ),
        ],
      );
    }
  }

  Widget getStarsCenter(double rating) {
    if (rating > 4.0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.star,
            color: Color(0xffFBBC02),
            size: 22,
          ),
          Icon(
            Icons.star,
            color: Color(0xffFBBC02),
            size: 22,
          ),
          Icon(
            Icons.star,
            color: Color(0xffFBBC02),
            size: 22,
          ),
          Icon(
            Icons.star,
            color: Color(0xffFBBC02),
            size: 22,
          ),
          Icon(
            Icons.star,
            color: Color(0xffFBBC02),
            size: 22,
          ),
        ],
      );
    } else if (rating > 3.0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.star,
            color: Color(0xffFBBC02),
            size: 22,
          ),
          Icon(
            Icons.star,
            color: Color(0xffFBBC02),
            size: 22,
          ),
          Icon(
            Icons.star,
            color: Color(0xffFBBC02),
            size: 22,
          ),
          Icon(
            Icons.star,
            color: Color(0xffFBBC02),
            size: 22,
          ),
        ],
      );
    } else if (rating > 2.0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.star,
            color: Color(0xffFBBC02),
            size: 22,
          ),
          Icon(
            Icons.star,
            color: Color(0xffFBBC02),
            size: 22,
          ),
          Icon(
            Icons.star,
            color: Color(0xffFBBC02),
            size: 22,
          ),
        ],
      );
    } else if (rating > 1.0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.star,
            color: Color(0xffFBBC02),
            size: 22,
          ),
          Icon(
            Icons.star,
            color: Color(0xffFBBC02),
            size: 22,
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.star,
            color: Color(0xffFBBC02),
            size: 22,
          ),
        ],
      );
    }
  }
}
