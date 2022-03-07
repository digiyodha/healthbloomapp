class EditInsuranceRequest {
  EditInsuranceRequest({
    this.id,
    this.organisationName,
    this.insuranceImage,
    this.patient,
  });

  String id;
  String organisationName;
  List<String> insuranceImage;
  String patient;

  factory EditInsuranceRequest.fromJson(Map<String, dynamic> json) =>
      EditInsuranceRequest(
        id: json["_id"] == null ? null : json["_id"],
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
        "organisation_name": organisationName == null ? null : organisationName,
        "insurance_image": insuranceImage == null
            ? null
            : List<dynamic>.from(insuranceImage.map((x) => x)),
        "patient": patient == null ? null : patient,
      };
}
