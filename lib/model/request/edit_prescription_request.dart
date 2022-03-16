class EditPriscriptionRequest {
  EditPriscriptionRequest({
    this.id,
    this.doctorName,
    this.clinicName,
    this.consultationDate,
    this.patient,
    this.userAilment,
    this.doctorAdvice,
    this.prescriptionImage,
  });

  String id;
  String doctorName;
  String clinicName;
  DateTime consultationDate;
  String patient;
  String userAilment;
  String doctorAdvice;
  List<String> prescriptionImage;

  factory EditPriscriptionRequest.fromJson(Map<String, dynamic> json) =>
      EditPriscriptionRequest(
        id: json["_id"] == null ? null : json["_id"],
        doctorName: json["doctor_name"] == null ? null : json["doctor_name"],
        clinicName: json["clinic_name"] == null ? null : json["clinic_name"],
        consultationDate: json["consultation_date"] == null
            ? null
            : DateTime.parse(json["consultation_date"]),
        patient: json["patient"] == null ? null : json["patient"],
        userAilment: json["user_ailment"] == null ? null : json["user_ailment"],
        doctorAdvice:
            json["doctor_advice"] == null ? null : json["doctor_advice"],
        prescriptionImage: json["prescription_image"] == null
            ? null
            : List<String>.from(json["prescription_image"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "doctor_name": doctorName == null ? null : doctorName,
        "clinic_name": clinicName == null ? null : clinicName,
        "consultation_date": consultationDate == null
            ? null
            : "${consultationDate.year.toString().padLeft(4, '0')}-${consultationDate.month.toString().padLeft(2, '0')}-${consultationDate.day.toString().padLeft(2, '0')}",
        "patient": patient == null ? null : patient,
        "user_ailment": userAilment == null ? null : userAilment,
        "doctor_advice": doctorAdvice == null ? null : doctorAdvice,
        "prescription_image": prescriptionImage == null
            ? null
            : List<dynamic>.from(prescriptionImage.map((x) => x)),
      };
}
