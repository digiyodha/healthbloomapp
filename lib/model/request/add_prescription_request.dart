import 'package:health_bloom/model/request/request.dart';

class AddPrescriptionRequest {
  AddPrescriptionRequest({
    this.doctorName,
    this.clinicName,
    this.consultationDate,
    this.patient,
    this.userAilment,
    this.doctorAdvice,
    this.prescriptionImage,
  });

  String doctorName;
  String clinicName;
  DateTime consultationDate;
  String patient;
  String userAilment;
  String doctorAdvice;
  List<ImageListRequest> prescriptionImage;

  factory AddPrescriptionRequest.fromJson(Map<String, dynamic> json) =>
      AddPrescriptionRequest(
        doctorName: json["doctor_name"] == null ? null : json["doctor_name"],
        clinicName: json["clinic_name"] == null ? null : json["clinic_name"],
        consultationDate: json["consultation_date"] == null
            ? null
            : DateTime.parse(json["consultation_date"]).toLocal(),
        patient: json["patient"] == null ? null : json["patient"],
        userAilment: json["user_ailment"] == null ? null : json["user_ailment"],
        doctorAdvice:
            json["doctor_advice"] == null ? null : json["doctor_advice"],
        prescriptionImage: json["prescription_image"] == null ? null : List<ImageListRequest>.from(json["prescription_image"].map((x) => ImageListRequest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "doctor_name": doctorName == null ? null : doctorName,
        "clinic_name": clinicName == null ? null : clinicName,
        "consultation_date": consultationDate == null
            ? null
            : consultationDate.toUtc().toIso8601String(),
        "patient": patient == null ? null : patient,
        "user_ailment": userAilment == null ? null : userAilment,
        "doctor_advice": doctorAdvice == null ? null : doctorAdvice,
        "prescription_image": prescriptionImage == null ? null : List<dynamic>.from(prescriptionImage.map((x) => x.toJson())),
      };
}