import 'package:health_bloom/model/request/request.dart';

class AddReportRequest {
  AddReportRequest({
    this.name,
    this.date,
    this.description,
    this.reportImage,
    this.patient,
  });

  String name;
  DateTime date;
  String description;
  List<ImageListRequest> reportImage;
  String patient;

  factory AddReportRequest.fromJson(Map<String, dynamic> json) =>
      AddReportRequest(
        name: json["name"] == null ? null : json["name"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]).toLocal(),
        description: json["description"] == null ? null : json["description"],
        reportImage: json["report_image"] == null ? null : List<ImageListRequest>.from(json["report_image"].map((x) => ImageListRequest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "date": date == null
            ? null
            : date.toUtc().toIso8601String(),
        "description": description == null ? null : description,
        "report_image": reportImage == null ? null : List<dynamic>.from(reportImage.map((x) => x.toJson())),
        "patient": patient == null ? null : patient,
      };
}