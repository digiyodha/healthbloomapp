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
    this.id,
  });

  String name;
  String relationship;
  int age;
  String avatar;
  String userId;
  String id;

  factory AddMemberResponseData.fromJson(Map<String, dynamic> json) =>
      AddMemberResponseData(
        name: json["name"] == null ? null : json["name"],
        relationship:
            json["relationship"] == null ? null : json["relationship"],
        age: json["age"] == null ? null : json["age"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        userId: json["user_id"] == null ? null : json["user_id"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "relationship": relationship == null ? null : relationship,
        "age": age == null ? null : age,
        "avatar": avatar == null ? null : avatar,
        "user_id": userId == null ? null : userId,
        "id": id == null ? null : id,
      };
}
