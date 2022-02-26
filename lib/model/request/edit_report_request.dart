class EditReportRequest {
  EditReportRequest({
    this.id,
    this.name,
    this.date,
    this.description,
    this.reportImage,
    this.patient,
  });

  String id;
  String name;
  DateTime date;
  String description;
  List<String> reportImage;
  String patient;

  factory EditReportRequest.fromJson(Map<String, dynamic> json) =>
      EditReportRequest(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        description: json["description"] == null ? null : json["description"],
        reportImage: json["report_image"] == null
            ? null
            : List<String>.from(json["report_image"].map((x) => x)),
        patient: json["patient"] == null ? null : json["patient"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "date": date == null ? null : date.toIso8601String(),
        "description": description == null ? null : description,
        "report_image": reportImage == null
            ? null
            : List<dynamic>.from(reportImage.map((x) => x)),
        "patient": patient == null ? null : patient,
      };
}
