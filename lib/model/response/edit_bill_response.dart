import '../request/request.dart';

class EditBillResponse {
  EditBillResponse({
    this.success,
    this.data,
  });

  bool success;
  EditBillResponseData data;

  factory EditBillResponse.fromJson(Map<String, dynamic> json) =>
      EditBillResponse(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : EditBillResponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null ? null : data.toJson(),
      };
}

class EditBillResponseData {
  EditBillResponseData({
    this.billImage,
    this.name,
    this.amount,
    this.date,
    this.description,
    this.patient,
    this.userId,
    this.id,
  });

  List<ImageListRequest> billImage;
  String name;
  int amount;
  DateTime date;
  String description;
  String patient;
  String userId;
  String id;

  factory EditBillResponseData.fromJson(Map<String, dynamic> json) =>
      EditBillResponseData(
        billImage: json["bill_image"] == null ? null : List<ImageListRequest>.from(json["bill_image"].map((x) => ImageListRequest.fromJson(x))),
        name: json["name"] == null ? null : json["name"],
        amount: json["amount"] == null ? null : json["amount"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]).toLocal(),
        description: json["description"] == null ? null : json["description"],
        patient: json["patient"] == null ? null : json["patient"],
        userId: json["user_id"] == null ? null : json["user_id"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "bill_image": billImage == null ? null : List<dynamic>.from(billImage.map((x) => x.toJson())),
        "name": name == null ? null : name,
        "amount": amount == null ? null : amount,
        "date": date == null ? null : date.toIso8601String(),
        "description": description == null ? null : description,
        "patient": patient == null ? null : patient,
        "user_id": userId == null ? null : userId,
        "id": id == null ? null : id,
      };
}
