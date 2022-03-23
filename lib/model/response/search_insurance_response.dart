class SearchInsuranceResponse {
  SearchInsuranceResponse({
    this.success,
    this.data,
  });

  bool success;
  List<SearchInsuranceResponseDatum> data;

  factory SearchInsuranceResponse.fromJson(Map<String, dynamic> json) =>
      SearchInsuranceResponse(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : List<SearchInsuranceResponseDatum>.from(json["data"]
                .map((x) => SearchInsuranceResponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SearchInsuranceResponseDatum {
  SearchInsuranceResponseDatum({
    this.id,
    this.organisationName,
    this.insuranceImage,
    this.patient,
    this.userId,
  });

  String id;
  String organisationName;
  List<String> insuranceImage;
  Patient patient;
  String userId;

  factory SearchInsuranceResponseDatum.fromJson(Map<String, dynamic> json) =>
      SearchInsuranceResponseDatum(
        id: json["_id"] == null ? null : json["_id"],
        organisationName: json["organisation_name"] == null
            ? null
            : json["organisation_name"],
        insuranceImage: json["insurance_image"] == null
            ? null
            : List<String>.from(json["insurance_image"].map((x) => x)),
        patient:
            json["patient"] == null ? null : Patient.fromJson(json["patient"]),
        userId: json["user_id"] == null ? null : json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "organisation_name": organisationName == null ? null : organisationName,
        "insurance_image": insuranceImage == null
            ? null
            : List<dynamic>.from(insuranceImage.map((x) => x)),
        "patient": patient == null ? null : patient.toJson(),
        "user_id": userId == null ? null : userId,
      };
}

class Patient {
  Patient({
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

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        name: json["name"] == null ? null : json["name"],
        relationship:
            json["relationship"] == null ? null : json["relationship"],
        age: json["age"] == null ? null : json["age"],
        avatar: json["avatar"] == null ? "" : json["avatar"],
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
