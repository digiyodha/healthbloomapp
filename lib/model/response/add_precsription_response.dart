class AddPrescriptionResponse {
  AddPrescriptionResponse({
    this.success,
    this.data,
  });

  bool success;
  Data data;

  factory AddPrescriptionResponse.fromJson(Map<String, dynamic> json) =>
      AddPrescriptionResponse(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    this.prescriptionImage,
    this.doctorName,
    this.clinicName,
    this.consultationDate,
    this.userAilment,
    this.doctorAdvice,
    this.patient,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  List<String> prescriptionImage;
  String doctorName;
  String clinicName;
  DateTime consultationDate;
  String userAilment;
  String doctorAdvice;
  String patient;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;
  String id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        prescriptionImage: json["prescription_image"] == null
            ? null
            : List<String>.from(json["prescription_image"].map((x) => x)),
        doctorName: json["doctor_name"] == null ? null : json["doctor_name"],
        clinicName: json["clinic_name"] == null ? null : json["clinic_name"],
        consultationDate: json["consultation_date"] == null
            ? null
            : DateTime.parse(json["consultation_date"]).toLocal(),
        userAilment: json["user_ailment"] == null ? null : json["user_ailment"],
        doctorAdvice:
            json["doctor_advice"] == null ? null : json["doctor_advice"],
        patient: json["patient"] == null ? null : json["patient"],
        userId: json["user_id"] == null ? null : json["user_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]).toLocal(),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]).toLocal(),
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "prescription_image": prescriptionImage == null
            ? null
            : List<dynamic>.from(prescriptionImage.map((x) => x)),
        "doctor_name": doctorName == null ? null : doctorName,
        "clinic_name": clinicName == null ? null : clinicName,
        "consultation_date": consultationDate == null
            ? null
            : consultationDate.toIso8601String(),
        "user_ailment": userAilment == null ? null : userAilment,
        "doctor_advice": doctorAdvice == null ? null : doctorAdvice,
        "patient": patient == null ? null : patient,
        "user_id": userId == null ? null : userId,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "id": id == null ? null : id,
      };
}
