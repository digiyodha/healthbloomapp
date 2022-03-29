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
    this.isActive,
    this.pushNotification,
    this.vibrationMode,
    this.silentMode,
    this.emailId,
    this.uid,
    this.avatar,
    this.countryCode,
    this.phoneNumber,
    this.name,
    this.latitude,
    this.longitude,
    this.age,
    this.city,
    this.state,
    this.gender,
    this.bloodGroup,
    this.createdAt,
    this.updatedAt,
    this.fcmToken,
    this.id,
  });

  bool isActive;
  bool pushNotification;
  bool vibrationMode;
  bool silentMode;
  String emailId;
  String uid;
  String avatar;
  String countryCode;
  String phoneNumber;
  String name;
  String latitude;
  String longitude;
  int age;
  String city;
  String state;
  String gender;
  String bloodGroup;
  DateTime createdAt;
  DateTime updatedAt;
  String fcmToken;
  String id;

  factory AddEditUserProfileResponseData.fromJson(Map<String, dynamic> json) =>
      AddEditUserProfileResponseData(
        isActive: json["is_active"] == null ? null : json["is_active"],
        pushNotification: json["push_notification"] == null
            ? null
            : json["push_notification"],
        vibrationMode:
            json["vibration_mode"] == null ? null : json["vibration_mode"],
        silentMode: json["silent_mode"] == null ? null : json["silent_mode"],
        emailId: json["email_id"] == null ? null : json["email_id"],
        uid: json["uid"] == null ? null : json["uid"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        countryCode: json["country_code"] == null ? null : json["country_code"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        name: json["name"] == null ? null : json["name"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        age: json["age"] == null ? null : json["age"],
        city: json["city"] == null ? null : json["city"],
        state: json["state"] == null ? null : json["state"],
        gender: json["gender"] == null ? null : json["gender"],
        bloodGroup: json["blood_group"] == null ? null : json["blood_group"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        fcmToken: json["fcm_token"] == null ? null : json["fcm_token"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "is_active": isActive == null ? null : isActive,
        "push_notification": pushNotification == null ? null : pushNotification,
        "vibration_mode": vibrationMode == null ? null : vibrationMode,
        "silent_mode": silentMode == null ? null : silentMode,
        "email_id": emailId == null ? null : emailId,
        "uid": uid == null ? null : uid,
        "avatar": avatar == null ? null : avatar,
        "country_code": countryCode == null ? null : countryCode,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "name": name == null ? null : name,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "age": age == null ? null : age,
        "city": city == null ? null : city,
        "state": state == null ? null : state,
        "gender": gender == null ? null : gender,
        "blood_group": bloodGroup == null ? null : bloodGroup,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "fcm_token": fcmToken == null ? null : fcmToken,
        "id": id == null ? null : id,
      };
}
