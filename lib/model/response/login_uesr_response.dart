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
    this.emailId,
    this.id,
    this.xAuthToken,
  });

  String emailId;
  String id;
  String xAuthToken;

  factory LoginUserResponseData.fromJson(Map<String, dynamic> json) =>
      LoginUserResponseData(
        emailId: json["email_id"] == null ? null : json["email_id"],
        id: json["_id"] == null ? null : json["_id"],
        xAuthToken: json["x_auth_token"] == null ? null : json["x_auth_token"],
      );

  Map<String, dynamic> toJson() => {
        "email_id": emailId == null ? null : emailId,
        "_id": id == null ? null : id,
        "x_auth_token": xAuthToken == null ? null : xAuthToken,
      };
}
