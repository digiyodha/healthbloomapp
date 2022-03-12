class GetFeedbackOptionsResponse {
  GetFeedbackOptionsResponse({
    this.success,
    this.data,
  });

  bool success;
  List<GetFeedbackOptionsResponseDatum> data;

  factory GetFeedbackOptionsResponse.fromJson(Map<String, dynamic> json) =>
      GetFeedbackOptionsResponse(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : List<GetFeedbackOptionsResponseDatum>.from(json["data"]
                .map((x) => GetFeedbackOptionsResponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetFeedbackOptionsResponseDatum {
  GetFeedbackOptionsResponseDatum({
    this.feedbackName,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  String feedbackName;
  DateTime createdAt;
  DateTime updatedAt;
  String id;

  factory GetFeedbackOptionsResponseDatum.fromJson(Map<String, dynamic> json) =>
      GetFeedbackOptionsResponseDatum(
        feedbackName:
            json["feedback_name"] == null ? null : json["feedback_name"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "feedback_name": feedbackName == null ? null : feedbackName,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "id": id == null ? null : id,
      };
}
