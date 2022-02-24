class AddMemberRequest {
  AddMemberRequest({
    this.name,
    this.relationship,
    this.age,
    this.avatar,
  });

  String name;
  String relationship;
  int age;
  String avatar;

  factory AddMemberRequest.fromJson(Map<String, dynamic> json) =>
      AddMemberRequest(
        name: json["name"] == null ? null : json["name"],
        relationship:
            json["relationship"] == null ? null : json["relationship"],
        age: json["age"] == null ? null : json["age"],
        avatar: json["avatar"] == null ? null : json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "relationship": relationship == null ? null : relationship,
        "age": age == null ? null : age,
        "avatar": avatar == null ? null : avatar,
      };
}
