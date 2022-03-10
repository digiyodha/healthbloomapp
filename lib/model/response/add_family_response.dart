class AddMemberResponse {
  AddMemberResponse({
    this.success,
    this.data,
  });

  bool success;
  AddMemberResponseData data;

  factory AddMemberResponse.fromJson(Map<String, dynamic> json) =>
      AddMemberResponse(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : AddMemberResponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null ? null : data.toJson(),
      };
}

class AddMemberResponseData {
  AddMemberResponseData({
    this.name,
    this.relationship,
    this.age,
    this.avatar,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  String name;
  String relationship;
  int age;
  String avatar;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;
  String id;

  factory AddMemberResponseData.fromJson(Map<String, dynamic> json) =>
      AddMemberResponseData(
        name: json["name"] == null ? null : json["name"],
        relationship:
            json["relationship"] == null ? null : json["relationship"],
        age: json["age"] == null ? null : json["age"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        userId: json["user_id"] == null ? null : json["user_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "relationship": relationship == null ? null : relationship,
        "age": age == null ? null : age,
        "avatar": avatar == null ? null : avatar,
        "user_id": userId == null ? null : userId,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "id": id == null ? null : id,
      };
}
