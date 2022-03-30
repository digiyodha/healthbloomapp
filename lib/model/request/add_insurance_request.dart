class AddInsuranceRequest {
  AddInsuranceRequest({
    this.organisationName,
    this.policyNo,
    this.dateOfBirth,
    this.insuranceImage,
    this.patient,
  });

  String organisationName;
  String policyNo;
  DateTime dateOfBirth;
  List<String> insuranceImage;
  String patient;

  factory AddInsuranceRequest.fromJson(Map<String, dynamic> json) =>
      AddInsuranceRequest(
        organisationName: json["organisation_name"] == null
            ? null
            : json["organisation_name"],
        policyNo: json["policy_no"] == null ? null : json["policy_no"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        insuranceImage: json["insurance_image"] == null
            ? null
            : List<String>.from(json["insurance_image"].map((x) => x)),
        patient: json["patient"] == null ? null : json["patient"],
      );

  Map<String, dynamic> toJson() => {
        "organisation_name": organisationName == null ? null : organisationName,
        "policy_no": policyNo == null ? null : policyNo,
        "date_of_birth": dateOfBirth == null
            ? null
            : "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "insurance_image": insuranceImage == null
            ? null
            : List<dynamic>.from(insuranceImage.map((x) => x)),
        "patient": patient == null ? null : patient,
      };
}
