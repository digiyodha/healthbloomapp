class EditInsuranceResponse {
  EditInsuranceResponse({
    this.success,
    this.data,
  });

  bool success;
  EditInsuranceResponseData data;

  factory EditInsuranceResponse.fromJson(Map<String, dynamic> json) =>
      EditInsuranceResponse(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : EditInsuranceResponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null ? null : data.toJson(),
      };
}

class EditInsuranceResponseData {
  EditInsuranceResponseData({
    this.insuranceImage,
    this.organisationName,
    this.patient,
    this.userId,
    this.id,
  });

  List<String> insuranceImage;
  String organisationName;
  String patient;
  String userId;
  String id;

  factory EditInsuranceResponseData.fromJson(Map<String, dynamic> json) =>
      EditInsuranceResponseData(
        insuranceImage: json["insurance_image"] == null
            ? null
            : List<String>.from(json["insurance_image"].map((x) => x)),
        organisationName: json["organisation_name"] == null
            ? null
            : json["organisation_name"],
        patient: json["patient"] == null ? null : json["patient"],
        userId: json["user_id"] == null ? null : json["user_id"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "insurance_image": insuranceImage == null
            ? null
            : List<dynamic>.from(insuranceImage.map((x) => x)),
        "organisation_name": organisationName == null ? null : organisationName,
        "patient": patient == null ? null : patient,
        "user_id": userId == null ? null : userId,
        "id": id == null ? null : id,
      };
}
