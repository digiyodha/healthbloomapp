class RegisterUserResponse {
  RegisterUserResponse({
    this.success,
    this.data,
  });

  bool success;
  RegisterUserResponseData data;

  factory RegisterUserResponse.fromJson(Map<String, dynamic> json) =>
      RegisterUserResponse(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : RegisterUserResponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null ? null : data.toJson(),
      };
}

class RegisterUserResponseData {
  RegisterUserResponseData({
    this.gender,
    this.bloodGroup,
    this.emailId,
    this.password,
    this.name,
    this.countryCode,
    this.phoneNumber,
    this.latitude,
    this.longitude,
    this.age,
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
  String latitude;
  String longitude;
  int age;
  String city;
  String state;
  String id;

  factory RegisterUserResponseData.fromJson(Map<String, dynamic> json) =>
      RegisterUserResponseData(
        gender: json["gender"] == null ? null : json["gender"],
        bloodGroup: json["blood_group"] == null ? null : json["blood_group"],
        emailId: json["email_id"] == null ? null : json["email_id"],
        password: json["password"] == null ? null : json["password"],
        name: json["name"] == null ? null : json["name"],
        countryCode: json["country_code"] == null ? null : json["country_code"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        age: json["age"] == null ? null : json["age"],
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
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "age": age == null ? null : age,
        "city": city == null ? null : city,
        "state": state == null ? null : state,
        "id": id == null ? null : id,
      };
}
