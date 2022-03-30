class AddInsuranceResponse {
  AddInsuranceResponse({
    this.success,
    this.data,
  });

  bool success;
  AddInsuranceResponseData data;

  factory AddInsuranceResponse.fromJson(Map<String, dynamic> json) =>
      AddInsuranceResponse(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : AddInsuranceResponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null ? null : data.toJson(),
      };
}

class AddInsuranceResponseData {
  AddInsuranceResponseData({
    this.insuranceImage,
    this.organisationName,
    this.policyNo,
    this.dateOfBirth,
    this.patient,
    this.userId,
    this.id,
  });

  List<String> insuranceImage;
  String organisationName;
  String policyNo;
  DateTime dateOfBirth;
  String patient;
  String userId;
  String id;

  factory AddInsuranceResponseData.fromJson(Map<String, dynamic> json) =>
      AddInsuranceResponseData(
        insuranceImage: json["insurance_image"] == null
            ? null
            : List<String>.from(json["insurance_image"].map((x) => x)),
        organisationName: json["organisation_name"] == null
            ? null
            : json["organisation_name"],
        policyNo: json["policy_no"] == null ? null : json["policy_no"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        patient: json["patient"] == null ? null : json["patient"],
        userId: json["user_id"] == null ? null : json["user_id"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "insurance_image": insuranceImage == null
            ? null
            : List<dynamic>.from(insuranceImage.map((x) => x)),
        "organisation_name": organisationName == null ? null : organisationName,
        "policy_no": policyNo == null ? null : policyNo,
        "date_of_birth": dateOfBirth == null
            ? null
            : "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "patient": patient == null ? null : patient,
        "user_id": userId == null ? null : userId,
        "id": id == null ? null : id,
      };
}
