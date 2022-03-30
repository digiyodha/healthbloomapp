class EditInsuranceRequest {
  EditInsuranceRequest({
    this.id,
    this.policyNo,
    this.dateOfBirth,
    this.organisationName,
    this.insuranceImage,
    this.patient,
  });

  String id;
  String policyNo;
  DateTime dateOfBirth;
  String organisationName;
  List<String> insuranceImage;
  String patient;

  factory EditInsuranceRequest.fromJson(Map<String, dynamic> json) =>
      EditInsuranceRequest(
        id: json["_id"] == null ? null : json["_id"],
        policyNo: json["policy_no"] == null ? null : json["policy_no"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        organisationName: json["organisation_name"] == null
            ? null
            : json["organisation_name"],
        insuranceImage: json["insurance_image"] == null
            ? null
            : List<String>.from(json["insurance_image"].map((x) => x)),
        patient: json["patient"] == null ? null : json["patient"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "policy_no": policyNo == null ? null : policyNo,
        "date_of_birth": dateOfBirth == null
            ? null
            : "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "organisation_name": organisationName == null ? null : organisationName,
        "insurance_image": insuranceImage == null
            ? null
            : List<dynamic>.from(insuranceImage.map((x) => x)),
        "patient": patient == null ? null : patient,
      };
}
