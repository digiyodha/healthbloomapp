class AddEditUserProfileRequest {
  AddEditUserProfileRequest({
    this.id,
    this.gender,
    this.countryCode,
    this.phoneNumber,
    this.googleAddress,
    this.userAddress,
    this.city,
    this.state,
    this.bloodGroup,
    this.avatar,
    this.emailId,
    this.name,
  });

  String id;
  String gender;
  String countryCode;
  String phoneNumber;
  String googleAddress;
  String userAddress;
  String city;
  String state;
  String bloodGroup;
  String avatar;
  String emailId;
  String name;

  factory AddEditUserProfileRequest.fromJson(Map<String, dynamic> json) =>
      AddEditUserProfileRequest(
        id: json["_id"] == null ? null : json["_id"],
        gender: json["gender"] == null ? null : json["gender"],
        countryCode: json["country_code"] == null ? null : json["country_code"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        googleAddress:
            json["google_address"] == null ? null : json["google_address"],
        userAddress: json["user_address"] == null ? null : json["user_address"],
        city: json["city"] == null ? null : json["city"],
        state: json["state"] == null ? null : json["state"],
        bloodGroup: json["blood_group"] == null ? null : json["blood_group"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        emailId: json["email_id"] == null ? null : json["email_id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "gender": gender == null ? null : gender,
        "country_code": countryCode == null ? null : countryCode,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "google_address": googleAddress == null ? null : googleAddress,
        "user_address": userAddress == null ? null : userAddress,
        "city": city == null ? null : city,
        "state": state == null ? null : state,
        "blood_group": bloodGroup == null ? null : bloodGroup,
        "avatar": avatar == null ? null : avatar,
        "email_id": emailId == null ? null : emailId,
        "name": name == null ? null : name,
      };
}
