import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:health_bloom/components/textbuilder.dart';

import 'package:health_bloom/model/response/get_user_response.dart';
import 'package:health_bloom/services/api/repository/auth_repository.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:health_bloom/utils/drawer/custom_drawer.dart';
import 'package:health_bloom/utils/loading.dart';
import 'package:health_bloom/view/profile/update_profile.dart';
import 'package:provider/provider.dart';

import '../../utils/custom_add_element_bs.dart';
import '../../utils/custom_bnb.dart';
import '../homepage/home_page.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _loading = false;
  Future _futureUser;

  Future<GetUserResponse> getUsers() async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    GetUserResponse _response = await adminAPI.getUserAPI();

    return _response;
  }

  @override
  void initState() {
    super.initState();
    updatePosition();
    _futureUser = getUsers();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String location = '';
  var latitude;
  var longitude;
  Future<void> updatePosition() async {
    Position pos = await _determinePosition();
    List pm = await placemarkFromCoordinates(pos.latitude, pos.longitude);
    setState(() {
      latitude = pos.latitude.toString();
      longitude = pos.longitude.toString();
      location =
          '${pm[0].locality.toString()} - ${pm[0].postalCode.toString()}';
      print('location $location');
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      //
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: CustomDrawer(
          selected: 1,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              FutureBuilder<GetUserResponse>(
                future: _futureUser,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      child: Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height,
                            width: double.infinity,
                            color: kMainColor,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                icon: Icon(
                                  Icons.reorder,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: TextBuilder(
                                  text: 'Profile',
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateProfile(
                                          data: snapshot.data.data),
                                    ),
                                  ).whenComplete(() => setState(() {
                                        _futureUser = getUsers();
                                      }));
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            bottom: 70,
                            left: 50,
                            right: 50,
                            child: Image.asset(
                              'assets/icons/verified.png',
                              height: 120,
                              width: 120,
                            ),
                          ),
                          Positioned(
                            top: 150,
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 55),
                                child: SingleChildScrollView(
                                  physics: ScrollPhysics(),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 80.0),
                                      Text(
                                        'Name',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff9884DF),
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Text(
                                        snapshot.data.data.name ?? '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 24.0),
                                      Text(
                                        'Gender',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff9884DF),
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Text(
                                        snapshot.data.data.gender ?? '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 24.0),
                                      Text(
                                        'Age',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff9884DF),
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Text(
                                        snapshot.data.data.age != null
                                            ? snapshot.data.data.age.toString()
                                            : '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 24.0),
                                      Text(
                                        'Blood Group',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff9884DF),
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Text(
                                        snapshot.data.data.bloodGroup ?? '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 24.0),
                                      Text(
                                        'Phone',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff9884DF),
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Text(
                                        snapshot.data.data.phoneNumber ?? '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 24.0),
                                      Text(
                                        'Location',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff9884DF),
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Text(
                                        location ?? '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 24.0),
                                      Text(
                                        'City',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff9884DF),
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Text(
                                        snapshot.data.data.city ?? '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 24.0),
                                      Text(
                                        'State',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff9884DF),
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Text(
                                        snapshot.data.data.state ?? '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 24.0),
                                      Text(
                                        'Email',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff9884DF),
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Text(
                                        snapshot.data.data.emailId ?? '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 24.0),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 105,
                            left: 135,
                            right: 135,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  margin: EdgeInsets.zero,
                                  elevation: 5,
                                  clipBehavior: Clip.antiAlias,
                                  child: snapshot.data.data.avatar != null &&
                                          snapshot.data.data.avatar.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                            snapshot.data.data.avatar,
                                            height: 80,
                                            width: 80,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Container(
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xff531C9D)),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white),
                                          child: Icon(
                                            FontAwesomeIcons.userPlus,
                                            color: Color(0xff8064E1),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
              if (_loading) LoadingWidget()
            ],
          ),
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
          current: 3,
        ),
      ),
    );
  }
}
