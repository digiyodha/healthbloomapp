class GetUserResponse {
  GetUserResponse({
    this.success,
    this.data,
  });

  bool success;
  GetUserResponseData data;

  factory GetUserResponse.fromJson(Map<String, dynamic> json) =>
      GetUserResponse(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : GetUserResponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null ? null : data.toJson(),
      };
}

class GetUserResponseData {
  GetUserResponseData({
    this.gender,
    this.bloodGroup,
    this.emailId,
    this.password,
    this.name,
    this.countryCode,
    this.phoneNumber,
    this.googleAddress,
    this.userAddress,
    this.city,
    this.state,
    this.id,
  });

  String gender;
  String bloodGroup;
  String emailId;
  String password;
  String name;
  String countryCode;
  String phoneNumber;
  String googleAddress;
  String userAddress;
  String city;
  String state;
  String id;

  factory GetUserResponseData.fromJson(Map<String, dynamic> json) =>
      GetUserResponseData(
        gender: json["gender"] == null ? null : json["gender"],
        bloodGroup: json["blood_group"] == null ? null : json["blood_group"],
        emailId: json["email_id"] == null ? null : json["email_id"],
        password: json["password"] == null ? null : json["password"],
        name: json["name"] == null ? null : json["name"],
        countryCode: json["country_code"] == null ? null : json["country_code"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        googleAddress:
            json["google_address"] == null ? null : json["google_address"],
        userAddress: json["user_address"] == null ? null : json["user_address"],
        city: json["city"] == null ? null : json["city"],
        state: json["state"] == null ? null : json["state"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "gender": gender == null ? null : gender,
        "blood_group": bloodGroup == null ? null : bloodGroup,
        "email_id": emailId == null ? null : emailId,
        "password": password == null ? null : password,
        "name": name == null ? null : name,
        "country_code": countryCode == null ? null : countryCode,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "google_address": googleAddress == null ? null : googleAddress,
        "user_address": userAddress == null ? null : userAddress,
        "city": city == null ? null : city,
        "state": state == null ? null : state,
        "id": id == null ? null : id,
      };
}
