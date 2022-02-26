class GetDocumentsRequest {
  GetDocumentsRequest({
    this.fromDate,
    this.toDate,
  });

  DateTime fromDate;
  String toDate;

  factory GetDocumentsRequest.fromJson(Map<String, dynamic> json) =>
      GetDocumentsRequest(
        fromDate: json["from_date"] == null
            ? null
            : DateTime.parse(json["from_date"]),
        toDate: json["to_date"] == null ? null : json["to_date"],
      );

  Map<String, dynamic> toJson() => {
        "from_date": fromDate == null
            ? null
            : "${fromDate.year.toString().padLeft(4, '0')}-${fromDate.month.toString().padLeft(2, '0')}-${fromDate.day.toString().padLeft(2, '0')}",
        "to_date": toDate == null ? null : toDate,
      };
}