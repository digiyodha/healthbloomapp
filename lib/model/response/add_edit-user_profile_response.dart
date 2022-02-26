class AddEditUserProfileResponse {
  AddEditUserProfileResponse({
    this.success,
    this.data,
  });

  bool success;
  AddEditUserProfileResponseData data;

  factory AddEditUserProfileResponse.fromJson(Map<String, dynamic> json) =>
      AddEditUserProfileResponse(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : AddEditUserProfileResponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null ? null : data.toJson(),
      };
}

class AddEditUserProfileResponseData {
  AddEditUserProfileResponseData({
    this.gender,
    this.bloodGroup,
    this.emailId,
    this.password,
    this.name,
    this.city,
    this.countryCode,
    this.googleAddress,
    this.phoneNumber,
    this.state,
    this.userAddress,
    this.avatar,
    this.id,
  });

  String gender;
  String bloodGroup;
  String emailId;
  String password;
  String name;
  String city;
  String countryCode;
  String googleAddress;
  String phoneNumber;
  String state;
  String userAddress;
  String avatar;
  String id;

  factory AddEditUserProfileResponseData.fromJson(Map<String, dynamic> json) =>
      AddEditUserProfileResponseData(
        gender: json["gender"] == null ? null : json["gender"],
        bloodGroup: json["blood_group"] == null ? null : json["blood_group"],
        emailId: json["email_id"] == null ? null : json["email_id"],
        password: json["password"] == null ? null : json["password"],
        name: json["name"] == null ? null : json["name"],
        city: json["city"] == null ? null : json["city"],
        countryCode: json["country_code"] == null ? null : json["country_code"],
        googleAddress:
            json["google_address"] == null ? null : json["google_address"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        state: json["state"] == null ? null : json["state"],
        userAddress: json["user_address"] == null ? null : json["user_address"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "gender": gender == null ? null : gender,
        "blood_group": bloodGroup == null ? null : bloodGroup,
        "email_id": emailId == null ? null : emailId,
        "password": password == null ? null : password,
        "name": name == null ? null : name,
        "city": city == null ? null : city,
        "country_code": countryCode == null ? null : countryCode,
        "google_address": googleAddress == null ? null : googleAddress,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "state": state == null ? null : state,
        "user_address": userAddress == null ? null : userAddress,
        "avatar": avatar == null ? null : avatar,
        "id": id == null ? null : id,
      };
}
