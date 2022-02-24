class EditMemberRequest {
  EditMemberRequest({
    this.id,
    this.name,
    this.relationship,
    this.age,
    this.avatar,
  });

  String id;
  String name;
  String relationship;
  int age;
  String avatar;

  factory EditMemberRequest.fromJson(Map<String, dynamic> json) =>
      EditMemberRequest(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        relationship:
            json["relationship"] == null ? null : json["relationship"],
        age: json["age"] == null ? null : json["age"],
        avatar: json["avatar"] == null ? null : json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "relationship": relationship == null ? null : relationship,
        "age": age == null ? null : age,
        "avatar": avatar == null ? null : avatar,
      };
}
