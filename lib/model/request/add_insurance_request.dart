class AddInsuranceRequest {
  AddInsuranceRequest({
    this.organisationName,
    this.insuranceImage,
    this.patient,
  });

  String organisationName;
  List<String> insuranceImage;
  String patient;

  factory AddInsuranceRequest.fromJson(Map<String, dynamic> json) =>
      AddInsuranceRequest(
        organisationName: json["organisation_name"] == null
            ? null
            : json["organisation_name"],
        insuranceImage: json["insurance_image"] == null
            ? null
            : List<String>.from(json["insurance_image"].map((x) => x)),
        patient: json["patient"] == null ? null : json["patient"],
      );

  Map<String, dynamic> toJson() => {
        "organisation_name": organisationName == null ? null : organisationName,
        "insurance_image": insuranceImage == null
            ? null
            : List<dynamic>.from(insuranceImage.map((x) => x)),
        "patient": patient == null ? null : patient,
      };
}
