import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:health_bloom/components/textbuilder.dart';

import 'package:health_bloom/main.dart';
import 'package:health_bloom/model/request/add_edit_user_profile_request.dart';
import 'package:health_bloom/model/response/add_edit-user_profile_response.dart';
import 'package:health_bloom/model/response/get_user_response.dart';
import 'package:health_bloom/services/api/repository/auth_repository.dart';
import 'package:health_bloom/utils/loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';

class UpdateProfile extends StatefulWidget {
  final GetUserResponseData data;
  const UpdateProfile({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  bool _loading = false;
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _state = TextEditingController();
  TextEditingController _age = TextEditingController();

  String selectedGender;
  List<String> gender = ['Male', 'Female', 'Other'];
  String selectedBloodGroup;
  List<String> bloodGroup = ['O+', 'O-', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-'];

  Future<AddEditUserProfileResponse> addEditProfile(
      AddEditUserProfileRequest request) async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    AddEditUserProfileResponse _response =
        await adminAPI.addEditProfileAPI(request);
    if (_response.success) {
      sp.setString('profileImage', _response.data.avatar);
      sp.setString('name', _response.data.name);
    }
    return _response;
  }

  Future<GetUserResponse> getUsers() async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    GetUserResponse _response = await adminAPI.getUserAPI();
    return _response;
  }

  String _uploadAvatarUrl;
  bool _profileLoading = false;
  Future<XFile> singleImage() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  Future<String> uploadImage(XFile image) async {
    Reference db =
        FirebaseStorage.instance.ref('profile/${getImagePath(image)}');
    setState(() {
      _profileLoading = true;
    });
    await db.putFile(File(image.path));
    return await db.getDownloadURL().whenComplete(
          () => setState(() {
            _profileLoading = false;
            _uploadAvatarUrl = db.getDownloadURL().toString();
            print('_uploadAvatarUrl ${_uploadAvatarUrl.toString()}');
          }),
        );
  }

  String getImagePath(XFile image) {
    return image.path.split('/').last;
  }

  @override
  void initState() {
    super.initState();

    if (widget.data != null) {
      _email.text = widget.data.emailId;
      if (_phone.text != null) _phone.text = widget.data.phoneNumber;
      _name.text = widget.data.name;
      if (_city.text != null) _city.text = widget.data.city;
      if (_state.text != null) _state.text = widget.data.state;
      selectedGender = widget.data.gender;
      selectedBloodGroup = widget.data.bloodGroup;
      if (_uploadAvatarUrl != null) _uploadAvatarUrl = widget.data.avatar;
      if (widget.data.age != null) _age.text = widget.data.age.toString();
    }
    updatePosition();
    _age.text = '18';
  }

  @override
  void dispose() {
    super.dispose();
    _phone.dispose();
    _city.dispose();
    _state.dispose();
  }

  var latitude;
  var longitude;
  Future<void> updatePosition() async {
    Position pos = await _determinePosition();
    List pm = await placemarkFromCoordinates(pos.latitude, pos.longitude);
    setState(() {
      latitude = pos.latitude.toString();
      longitude = pos.longitude.toString();
      _city.text = pm[0].subLocality.toString();
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Stack(
            children: [
              Container(
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
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: TextBuilder(
                            text: 'Edit Profile',
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          height: 35,
                          width: 35,
                        )
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
                          padding: const EdgeInsets.symmetric(horizontal: 55),
                          child: SingleChildScrollView(
                            physics: ScrollPhysics(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 50.0),
                                TextFormField(
                                  controller: _name,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "* Required";
                                    } else
                                      return null;
                                  },
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff9884DF),
                                  ),
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff9884DF),
                                    ),
                                    label: TextBuilder(text: 'Name'),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    suffixIcon: Icon(
                                      Icons.people,
                                      color: Color(0xff9884DF),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _email,
                                  keyboardType: TextInputType.emailAddress,
                                  enabled: _email.text.isEmpty ? true : false,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "* Required";
                                    } else
                                      return null;
                                  },
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff9884DF),
                                  ),
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff9884DF),
                                    ),
                                    label: TextBuilder(text: 'Email'),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    suffixIcon: Icon(
                                      Icons.email,
                                      color: Color(0xff9884DF),
                                    ),
                                    disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _age,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "* Required";
                                    } else
                                      return null;
                                  },
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff9884DF),
                                  ),
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff9884DF),
                                    ),
                                    label: TextBuilder(text: 'Age'),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    suffixIcon: Icon(
                                      Icons.numbers,
                                      color: Color(0xff9884DF),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                DropdownButton<String>(
                                    underline: Container(
                                      height: 1,
                                      width: double.infinity,
                                      color: Colors.grey,
                                    ),
                                    hint: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Text(
                                        'Choose gender',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff9884DF),
                                        ),
                                      ),
                                    ),
                                    icon: Padding(
                                      padding: const EdgeInsets.only(right: 13),
                                      child: Icon(
                                        Icons.people_alt,
                                        color: Color(0xff9884DF),
                                      ),
                                    ),
                                    isExpanded: true,
                                    value: selectedGender,
                                    onChanged: (newValue) {
                                      setState(() {});
                                      selectedGender = newValue;
                                    },
                                    items: gender.map(
                                      (gen) {
                                        return DropdownMenuItem<String>(
                                          value: gen,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Text(
                                              gen,
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff9884DF),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ).toList()),
                                const SizedBox(height: 20.0),
                                DropdownButton<String>(
                                    underline: Container(
                                      height: 1,
                                      width: double.infinity,
                                      color: Colors.grey,
                                    ),
                                    hint: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Text(
                                        'Blood Group',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff9884DF),
                                        ),
                                      ),
                                    ),
                                    isExpanded: true,
                                    icon: Padding(
                                      padding: const EdgeInsets.only(right: 13),
                                      child: Icon(
                                        Icons.opacity,
                                        color: Color(0xff9884DF),
                                      ),
                                    ),
                                    value: selectedBloodGroup,
                                    onChanged: (newValue) {
                                      setState(() {});
                                      selectedBloodGroup = newValue;
                                      print(
                                          'selectedBloodGroup ${selectedBloodGroup.toString()}');
                                    },
                                    items: bloodGroup.map(
                                      (blood) {
                                        return DropdownMenuItem<String>(
                                          value: blood,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Text(
                                              blood,
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff9884DF),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ).toList()),
                                const SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _phone,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "* Required";
                                    } else
                                      return null;
                                  },
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff9884DF),
                                  ),
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff9884DF),
                                    ),
                                    label: TextBuilder(text: 'Phone Number'),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    suffixIcon: Icon(
                                      Icons.phone,
                                      color: Color(0xff9884DF),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _city,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "* Required";
                                    } else
                                      return null;
                                  },
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff9884DF),
                                  ),
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff9884DF),
                                    ),
                                    label: TextBuilder(text: 'City'),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    suffixIcon: Icon(
                                      Icons.gps_fixed,
                                      color: Color(0xff9884DF),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _state,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "* Required";
                                    } else
                                      return null;
                                  },
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff9884DF),
                                  ),
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff9884DF),
                                    ),
                                    label: TextBuilder(text: 'State'),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    suffixIcon: Icon(
                                      Icons.gps_fixed,
                                      color: Color(0xff9884DF),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 50.0),
                                MaterialButton(
                                  minWidth: double.infinity,
                                  height: 45,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  color: Color(0xff855FF7),
                                  onPressed: () async {
                                    setState(() {
                                      _loading = true;
                                    });
                                    try {
                                      AddEditUserProfileRequest _request =
                                          AddEditUserProfileRequest(
                                        age: int.parse(_age.text),
                                        latitude:
                                            sp.getString('currentLatitude'),
                                        longitude:
                                            sp.getString('currentLongitude'),
                                        emailId: _email.text,
                                        bloodGroup: selectedBloodGroup,
                                        name: _name.text,
                                        city: _city.text,
                                        countryCode: '+91',
                                        gender: selectedGender,
                                        avatar: _uploadAvatarUrl ?? "",
                                        phoneNumber: _phone.text,
                                        state: _state.text,
                                        id: widget.data.id,
                                      );
                                      AddEditUserProfileResponse _response =
                                          await addEditProfile(_request);
                                      print(
                                          'Add Edit Profile Request ${_request.toJson()}');
                                      print(
                                          'Add Edit Profile Response ${_response.toJson()}');
                                      // final user =
                                      //     FirebaseAuth.instance.currentUser;

                                      if (_response.success == true) {
                                        setState(() {
                                          _loading = false;
                                        });

                                        // sp.setString(
                                        //     'name', _response.data.name);
                                        // sp.setString('profileImage',
                                        //     _response.data.avatar);

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text('Profile updated.'),
                                        ));

                                        Navigator.pop(context);
                                        // final UserCredential user = await _auth
                                        //     .createUserWithEmailAndPassword(
                                        //   email: _email.text,
                                        //   password: null,
                                        // );
                                        // await user.user
                                        //     .sendEmailVerification()
                                        //     .whenComplete(() {
                                        //   ScaffoldMessenger.of(context)
                                        //       .showSnackBar(SnackBar(
                                        //     content: Text(
                                        //         "Verification link has been sent to your Email. Please verify your account!"),
                                        //   ));
                                        // });
                                      }
                                    } on FirebaseAuthException catch (e) {
                                      setState(() {
                                        _loading = false;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(e.toString()),
                                      ));
                                    }
                                  },
                                  child: TextBuilder(
                                    text: 'SUBMIT',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
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
                      child: InkWell(
                        onTap: () async {
                          XFile _imageFile = await singleImage();
                          _uploadAvatarUrl = await uploadImage(_imageFile);
                          setState(() {});
                        },
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
                              child: _uploadAvatarUrl != null &&
                                      _uploadAvatarUrl.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        _uploadAvatarUrl,
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
                            _profileLoading
                                ? Center(
                                    child: Container(
                                      height: 50.0,
                                      width: 50.0,
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (_loading) LoadingWidget()
            ],
          ),
        ),
      ),
    );
  }
}
