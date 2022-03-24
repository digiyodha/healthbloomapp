import '../request/request.dart';

class EditReportResponse {
  EditReportResponse({
    this.success,
    this.data,
  });

  bool success;
  EditReportResponseData data;

  factory EditReportResponse.fromJson(Map<String, dynamic> json) =>
      EditReportResponse(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : EditReportResponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null ? null : data.toJson(),
      };
}

class EditReportResponseData {
  EditReportResponseData({
    this.reportImage,
    this.name,
    this.date,
    this.description,
    this.patient,
    this.userId,
    this.id,
  });

  List<ImageListRequest> reportImage;
  String name;
  DateTime date;
  String description;
  String patient;
  String userId;
  String id;

  factory EditReportResponseData.fromJson(Map<String, dynamic> json) =>
      EditReportResponseData(
        reportImage: json["report_image"] == null ? null : List<ImageListRequest>.from(json["report_image"].map((x) => ImageListRequest.fromJson(x))),
        name: json["name"] == null ? null : json["name"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]).toLocal(),
        description: json["description"] == null ? null : json["description"],
        patient: json["patient"] == null ? null : json["patient"],
        userId: json["user_id"] == null ? null : json["user_id"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "report_image": reportImage == null ? null : List<dynamic>.from(reportImage.map((x) => x.toJson())),
        "name": name == null ? null : name,
        "date": date == null ? null : date.toIso8601String(),
        "description": description == null ? null : description,
        "patient": patient == null ? null : patient,
        "user_id": userId == null ? null : userId,
        "id": id == null ? null : id,
      };
}
