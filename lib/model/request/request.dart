class AddBillRequest {
  AddBillRequest({
    this.name,
    this.amount,
    this.date,
    this.description,
    this.billImage,
    this.patient,
  });

  String name;
  double amount;
  DateTime date;
  String description;
  List<String> billImage;
  String patient;

  factory AddBillRequest.fromJson(Map<String, dynamic> json) => AddBillRequest(
    name: json["name"] == null ? null : json["name"],
    amount: json["amount"] == null ? null : json["amount"].toDouble(),
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    description: json["description"] == null ? null : json["description"],
    billImage: json["bill_image"] == null ? null : List<String>.from(json["bill_image"].map((x) => x)),
    patient: json["patient"] == null ? null : json["patient"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "amount": amount == null ? null : amount,
    "date": date == null ? null : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "description": description == null ? null : description,
    "bill_image": billImage == null ? null : List<dynamic>.from(billImage.map((x) => x)),
    "patient": patient == null ? null : patient,
  };
}

class DeleteDocumentRequest {
  DeleteDocumentRequest({
    this.id,
  });

  String id;

  factory DeleteDocumentRequest.fromJson(Map<String, dynamic> json) => DeleteDocumentRequest(
    id: json["_id"] == null ? null : json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
  };
}

class RegisterLoginRequest {
  RegisterLoginRequest({
    this.name,
    this.emailId,
    this.uid,
    this.avatar,
    this.phoneNumber,
    this.countryCode,
  });

  String name;
  String emailId;
  String uid;
  String avatar;
  dynamic phoneNumber;
  dynamic countryCode;

  factory RegisterLoginRequest.fromJson(Map<String, dynamic> json) => RegisterLoginRequest(
    name: json["name"] == null ? null : json["name"],
    emailId: json["email_id"] == null ? null : json["email_id"],
    uid: json["uid"] == null ? null : json["uid"],
    avatar: json["avatar"] == null ? null : json["avatar"],
    phoneNumber: json["phone_number"],
    countryCode: json["country_code"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "email_id": emailId == null ? null : emailId,
    "uid": uid == null ? null : uid,
    "avatar": avatar == null ? null : avatar,
    "phone_number": phoneNumber,
    "country_code": countryCode,
  };
}