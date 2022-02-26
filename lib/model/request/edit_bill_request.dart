class EditBillRequest {
  EditBillRequest({
    this.id,
    this.name,
    this.amount,
    this.date,
    this.description,
    this.billImage,
    this.patient,
  });

  String id;
  String name;
  dynamic amount;
  DateTime date;
  String description;
  List<String> billImage;
  String patient;

  factory EditBillRequest.fromJson(Map<String, dynamic> json) =>
      EditBillRequest(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        amount: json["amount"] == null ? null : json["amount"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        description: json["description"] == null ? null : json["description"],
        billImage: json["bill_image"] == null
            ? null
            : List<String>.from(json["bill_image"].map((x) => x)),
        patient: json["patient"] == null ? null : json["patient"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "amount": amount == null ? null : amount,
        "date": date == null ? null : date.toIso8601String(),
        "description": description == null ? null : description,
        "bill_image": billImage == null
            ? null
            : List<dynamic>.from(billImage.map((x) => x)),
        "patient": patient == null ? null : patient,
      };
}
