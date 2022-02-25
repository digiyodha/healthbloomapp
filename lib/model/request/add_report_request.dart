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
  List<String> reportImage;
  String patient;

  factory AddReportRequest.fromJson(Map<String, dynamic> json) =>
      AddReportRequest(
        name: json["name"] == null ? null : json["name"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        description: json["description"] == null ? null : json["description"],
        reportImage: json["report_image"] == null
            ? null
            : List<String>.from(json["report_image"].map((x) => x)),
        patient: json["patient"] == null ? null : json["patient"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "date": date == null
            ? null
            : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "description": description == null ? null : description,
        "report_image": reportImage == null
            ? null
            : List<dynamic>.from(reportImage.map((x) => x)),
        "patient": patient == null ? null : patient,
      };
}
