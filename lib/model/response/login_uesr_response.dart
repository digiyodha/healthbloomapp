class LoginUserResponse {
  LoginUserResponse({
    this.success,
    this.data,
  });

  bool success;
  LoginUserResponseData data;

  factory LoginUserResponse.fromJson(Map<String, dynamic> json) =>
      LoginUserResponse(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : LoginUserResponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null ? null : data.toJson(),
      };
}

class LoginUserResponseData {
  LoginUserResponseData({
    this.id,
    this.name,
    this.emailId,
    this.uid,
    this.gender,
    this.avatar,
    this.countryCode,
    this.phoneNumber,
    this.latitude,
    this.longitude,
    this.age,
    this.city,
    this.state,
    this.bloodGroup,
    this.xAuthToken,
  });

  String id;
  String name;
  String emailId;
  String uid;
  String gender;
  String avatar;
  String countryCode;
  String phoneNumber;
  String latitude;
  String longitude;
  int age;
  String city;
  String state;
  String bloodGroup;
  String xAuthToken;

  factory LoginUserResponseData.fromJson(Map<String, dynamic> json) =>
      LoginUserResponseData(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        emailId: json["email_id"] == null ? null : json["email_id"],
        uid: json["uid"] == null ? null : json["uid"],
        gender: json["gender"] == null ? null : json["gender"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        countryCode: json["country_code"] == null ? null : json["country_code"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        age: json["age"] == null ? null : json["age"],
        city: json["city"] == null ? null : json["city"],
        state: json["state"] == null ? null : json["state"],
        bloodGroup: json["blood_group"] == null ? null : json["blood_group"],
        xAuthToken: json["x_auth_token"] == null ? null : json["x_auth_token"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "email_id": emailId == null ? null : emailId,
        "uid": uid == null ? null : uid,
        "gender": gender == null ? null : gender,
        "avatar": avatar == null ? null : avatar,
        "country_code": countryCode == null ? null : countryCode,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "age": age == null ? null : age,
        "city": city == null ? null : city,
        "state": state == null ? null : state,
        "blood_group": bloodGroup == null ? null : bloodGroup,
        "x_auth_token": xAuthToken == null ? null : xAuthToken,
      };
}
