class AddFeedbackResponse {
  AddFeedbackResponse({
    this.success,
    this.data,
  });

  bool success;
  AddFeedbackResponseData data;

  factory AddFeedbackResponse.fromJson(Map<String, dynamic> json) =>
      AddFeedbackResponse(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : AddFeedbackResponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null ? null : data.toJson(),
      };
}

class AddFeedbackResponseData {
  AddFeedbackResponseData({
    this.experience,
    this.description,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  String experience;
  String description;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;
  String id;

  factory AddFeedbackResponseData.fromJson(Map<String, dynamic> json) =>
      AddFeedbackResponseData(
        experience: json["experience"] == null ? null : json["experience"],
        description: json["description"] == null ? null : json["description"],
        userId: json["user_id"] == null ? null : json["user_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]).toLocal(),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]).toLocal(),
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "experience": experience == null ? null : experience,
        "description": description == null ? null : description,
        "user_id": userId == null ? null : userId,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "id": id == null ? null : id,
      };
}
