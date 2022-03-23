class GetDocumentsResponse {
  GetDocumentsResponse({
    this.success,
    this.data,
  });

  bool success;
  GetDocumentsResponseData data;

  factory GetDocumentsResponse.fromJson(Map<String, dynamic> json) =>
      GetDocumentsResponse(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : GetDocumentsResponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null ? null : data.toJson(),
      };
}

class GetDocumentsResponseData {
  GetDocumentsResponseData({
    this.bill,
    this.report,
    this.prescription,
  });

  List<Bill> bill;
  List<Bill> report;
  List<Prescription> prescription;

  factory GetDocumentsResponseData.fromJson(Map<String, dynamic> json) =>
      GetDocumentsResponseData(
        bill: json["bill"] == null
            ? null
            : List<Bill>.from(json["bill"].map((x) => Bill.fromJson(x))),
        report: json["report"] == null
            ? null
            : List<Bill>.from(json["report"].map((x) => Bill.fromJson(x))),
        prescription: json["prescription"] == null
            ? null
            : List<Prescription>.from(
                json["prescription"].map((x) => Prescription.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bill": bill == null
            ? null
            : List<dynamic>.from(bill.map((x) => x.toJson())),
        "report": report == null
            ? null
            : List<dynamic>.from(report.map((x) => x.toJson())),
        "prescription": prescription == null
            ? null
            : List<dynamic>.from(prescription.map((x) => x.toJson())),
      };
}

class Bill {
  Bill({
    this.billImage,
    this.name,
    this.amount,
    this.date,
    this.description,
    this.patient,
    this.userId,
    this.id,
    this.reportImage,
  });

  List<String> billImage;
  String name;
  double amount;
  DateTime date;
  String description;
  String patient;
  String userId;
  String id;
  List<String> reportImage;

  factory Bill.fromJson(Map<String, dynamic> json) => Bill(
        billImage: json["bill_image"] == null
            ? null
            : List<String>.from(json["bill_image"].map((x) => x)),
        name: json["name"] == null ? null : json["name"],
        amount: json["amount"] == null ? null : json["amount"].toDouble(),
        date: json["date"] == null ? null : DateTime.parse(json["date"]).toLocal(),
        description: json["description"] == null ? null : json["description"],
        patient: json["patient"] == null ? null : json["patient"],
        userId: json["user_id"] == null ? null : json["user_id"],
        id: json["id"] == null ? null : json["id"],
        reportImage: json["report_image"] == null
            ? null
            : List<String>.from(json["report_image"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "bill_image": billImage == null
            ? null
            : List<dynamic>.from(billImage.map((x) => x)),
        "name": name == null ? null : name,
        "amount": amount == null ? null : amount,
        "date": date == null ? null : date.toIso8601String(),
        "description": description == null ? null : description,
        "patient": patient == null ? null : patient,
        "user_id": userId == null ? null : userId,
        "id": id == null ? null : id,
        "report_image": reportImage == null
            ? null
            : List<dynamic>.from(reportImage.map((x) => x)),
      };
}

class Prescription {
  Prescription({
    this.prescriptionImage,
    this.doctorName,
    this.clinicName,
    this.consultationDate,
    this.userAilment,
    this.doctorAdvice,
    this.patient,
    this.userId,
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
  String id;

  factory Prescription.fromJson(Map<String, dynamic> json) => Prescription(
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
        "id": id == null ? null : id,
      };
}
