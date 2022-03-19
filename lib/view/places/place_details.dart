import 'package:flutter/material.dart';
import '../../model/response/response.dart';
import '../../utils/colors.dart';
import '../../utils/map_utils.dart';

class NearbyPlaceDetails extends StatelessWidget {
  final MapsNearbyMedicalsResponseResult data;
  const NearbyPlaceDetails({Key key, this.data}) : super(key: key);

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

            },
          )
        ],
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
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.name ?? "-",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: kGrey6),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            if (data.rating != null)
                              Row(
                                children: [
                                  Text(
                                    data.rating.toString() ?? "-",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: kMainColor),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  getStars(data.rating)
                                ],
                              ),
                            if (data.rating != null)
                              SizedBox(
                                height: 10,
                              ),
                            Text(
                              data.vicinity ?? "-",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: kGrey4),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            if (data.openingHours != null)
                              if (data.openingHours.openNow != null)
                                Text(
                                  data.openingHours.openNow ? "Open" : "Closed",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: data.openingHours.openNow
                                          ? Colors.green
                                          : Colors.redAccent),
                                ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              MapUtils.openMap(data.geometry.location.lat,
                                  data.geometry.location.lng);
                            },
                            icon: Icon(
                              Icons.directions,
                              size: 30,
                              color: Color(0xff4285F4),
                            ),
                          ),
                          Text("DIRECTIONS",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff4285F4),
                          ),)
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
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
}
