class AddReportResponse {
  AddReportResponse({
    this.success,
    this.data,
  });

  bool success;
  AddReportResponseData data;

  factory AddReportResponse.fromJson(Map<String, dynamic> json) =>
      AddReportResponse(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : AddReportResponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null ? null : data.toJson(),
      };
}

class AddReportResponseData {
  AddReportResponseData({
    this.reportImage,
    this.name,
    this.date,
    this.description,
    this.patient,
    this.userId,
    this.id,
  });

  List<String> reportImage;
  String name;
  DateTime date;
  String description;
  String patient;
  String userId;
  String id;

  factory AddReportResponseData.fromJson(Map<String, dynamic> json) =>
      AddReportResponseData(
        reportImage: json["report_image"] == null
            ? null
            : List<String>.from(json["report_image"].map((x) => x)),
        name: json["name"] == null ? null : json["name"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        description: json["description"] == null ? null : json["description"],
        patient: json["patient"] == null ? null : json["patient"],
        userId: json["user_id"] == null ? null : json["user_id"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "report_image": reportImage == null
            ? null
            : List<dynamic>.from(reportImage.map((x) => x)),
        "name": name == null ? null : name,
        "date": date == null ? null : date.toIso8601String(),
        "description": description == null ? null : description,
        "patient": patient == null ? null : patient,
        "user_id": userId == null ? null : userId,
        "id": id == null ? null : id,
      };
}
