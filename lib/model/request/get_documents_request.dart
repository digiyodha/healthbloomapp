class GetDocumentsRequest {
  GetDocumentsRequest({
    this.fromDate,
    this.toDate,
  });

  DateTime fromDate;
  DateTime toDate;

  factory GetDocumentsRequest.fromJson(Map<String, dynamic> json) =>
      GetDocumentsRequest(
        fromDate: json["from_date"] == null
            ? null
            : DateTime.parse(json["from_date"]),
        toDate:
            json["to_date"] == null ? null : DateTime.parse(json["to_date"]),
      );

  Map<String, dynamic> toJson() => {
        "from_date": fromDate == null
            ? ""
            : fromDate.toUtc().toIso8601String(),
        "to_date": toDate == null
            ? ""
            : toDate.toUtc().toIso8601String(),
      };
}
