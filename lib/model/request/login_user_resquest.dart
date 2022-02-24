class LoginUserRequest {
  LoginUserRequest({
    this.emailId,
    this.password,
  });

  String emailId;
  String password;
  factory LoginUserRequest.fromJson(Map<String, dynamic> json) =>
      LoginUserRequest(
        emailId: json["email_id"] == null ? null : json["email_id"],
        password: json["password"] == null ? null : json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email_id": emailId == null ? null : emailId,
        "password": password == null ? null : password,
      };
}
