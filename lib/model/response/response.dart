class AddBillResponse {
  AddBillResponse({
    this.success,
    this.data,
  });

  bool success;
  AddBillResponseData data;

  factory AddBillResponse.fromJson(Map<String, dynamic> json) => AddBillResponse(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : AddBillResponseData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data.toJson(),
  };
}

class AddBillResponseData {
  AddBillResponseData({
    this.billImage,
    this.name,
    this.amount,
    this.date,
    this.description,
    this.patient,
    this.userId,
    this.id,
  });

  List<String> billImage;
  String name;
  double amount;
  DateTime date;
  String description;
  String patient;
  String userId;
  String id;

  factory AddBillResponseData.fromJson(Map<String, dynamic> json) => AddBillResponseData(
    billImage: json["bill_image"] == null ? [] : List<String>.from(json["bill_image"].map((x) => x)),
    name: json["name"] == null ? null : json["name"],
    amount: json["amount"] == null ? null : json["amount"].toDouble(),
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    description: json["description"] == null ? null : json["description"],
    patient: json["patient"] == null ? null : json["patient"],
    userId: json["user_id"] == null ? null : json["user_id"],
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "bill_image": billImage == null ? [] : List<dynamic>.from(billImage.map((x) => x)),
    "name": name == null ? null : name,
    "amount": amount == null ? null : amount,
    "date": date == null ? null : date.toIso8601String(),
    "description": description == null ? null : description,
    "patient": patient == null ? null : patient,
    "user_id": userId == null ? null : userId,
    "id": id == null ? null : id,
  };
}


