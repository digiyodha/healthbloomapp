class RegisterUserRequest {
  RegisterUserRequest({
    this.name,
    this.emailId,
    this.password,
  });

  String name;
  String emailId;
  String password;

  factory RegisterUserRequest.fromJson(Map<String, dynamic> json) =>
      RegisterUserRequest(
        name: json["name"] == null ? null : json["name"],
        emailId: json["email_id"] == null ? null : json["email_id"],
        password: json["password"] == null ? null : json["password"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "email_id": emailId == null ? null : emailId,
        "password": password == null ? null : password,
      };
}
