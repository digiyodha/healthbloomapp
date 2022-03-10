class GetAllMemberResponse {
  GetAllMemberResponse({
    this.success,
    this.data,
  });

  bool success;
  List<GetAllMemberResponseDatum> data;

  factory GetAllMemberResponse.fromJson(Map<String, dynamic> json) =>
      GetAllMemberResponse(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : List<GetAllMemberResponseDatum>.from(
                json["data"].map((x) => GetAllMemberResponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetAllMemberResponseDatum {
  GetAllMemberResponseDatum({
    this.name,
    this.relationship,
    this.age,
    this.avatar,
    this.userId,
    this.updatedAt,
    this.id,
  });

  String name;
  String relationship;
  int age;
  String avatar;
  String userId;
  DateTime updatedAt;
  String id;

  factory GetAllMemberResponseDatum.fromJson(Map<String, dynamic> json) =>
      GetAllMemberResponseDatum(
        name: json["name"] == null ? null : json["name"],
        relationship:
            json["relationship"] == null ? null : json["relationship"],
        age: json["age"] == null ? null : json["age"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        userId: json["user_id"] == null ? null : json["user_id"],
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
        "updatedAt": updatedAt == null
            ? null
            : "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
        "id": id == null ? null : id,
      };
}
