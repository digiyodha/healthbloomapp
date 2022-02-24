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
    this.id,
  });

  String gender;
  String bloodGroup;
  String emailId;
  String password;
  String name;
  String id;

  factory RegisterUserResponseData.fromJson(Map<String, dynamic> json) =>
      RegisterUserResponseData(
        gender: json["gender"] == null ? null : json["gender"],
        bloodGroup: json["blood_group"] == null ? null : json["blood_group"],
        emailId: json["email_id"] == null ? null : json["email_id"],
        password: json["password"] == null ? null : json["password"],
        name: json["name"] == null ? null : json["name"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "gender": gender == null ? null : gender,
        "blood_group": bloodGroup == null ? null : bloodGroup,
        "email_id": emailId == null ? null : emailId,
        "password": password == null ? null : password,
        "name": name == null ? null : name,
        "id": id == null ? null : id,
      };
}
