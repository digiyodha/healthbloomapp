class AddBillResponse {
  AddBillResponse({
    this.success,
    this.data,
  });

  bool success;
  AddBillResponseData data;

  factory AddBillResponse.fromJson(Map<String, dynamic> json) => AddBillResponse(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : AddBillResponseData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data.toJson(),
  };
}

class AddBillResponseData {
  AddBillResponseData({
    this.billImage,
    this.name,
    this.amount,
    this.date,
    this.description,
    this.patient,
    this.userId,
    this.id,
  });

  List<String> billImage;
  String name;
  double amount;
  DateTime date;
  String description;
  String patient;
  String userId;
  String id;

  factory AddBillResponseData.fromJson(Map<String, dynamic> json) => AddBillResponseData(
    billImage: json["bill_image"] == null ? [] : List<String>.from(json["bill_image"].map((x) => x)),
    name: json["name"] == null ? null : json["name"],
    amount: json["amount"] == null ? null : json["amount"].toDouble(),
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    description: json["description"] == null ? null : json["description"],
    patient: json["patient"] == null ? null : json["patient"],
    userId: json["user_id"] == null ? null : json["user_id"],
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "bill_image": billImage == null ? [] : List<dynamic>.from(billImage.map((x) => x)),
    "name": name == null ? null : name,
    "amount": amount == null ? null : amount,
    "date": date == null ? null : date.toIso8601String(),
    "description": description == null ? null : description,
    "patient": patient == null ? null : patient,
    "user_id": userId == null ? null : userId,
    "id": id == null ? null : id,
  };
}

class GetAllDocumentsResponse {
  GetAllDocumentsResponse({
    this.success,
    this.data,
  });

  bool success;
  GetAllDocumentsResponseData data;

  factory GetAllDocumentsResponse.fromJson(Map<String, dynamic> json) => GetAllDocumentsResponse(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : GetAllDocumentsResponseData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data.toJson(),
  };
}

class GetAllDocumentsResponseData {
  GetAllDocumentsResponseData({
    this.bill,
    this.report,
    this.prescription,
  });

  List<GetAllDocumentsResponseBill> bill;
  List<GetAllDocumentsResponseBill> report;
  List<GetAllDocumentsResponsePrescription> prescription;

  factory GetAllDocumentsResponseData.fromJson(Map<String, dynamic> json) => GetAllDocumentsResponseData(
    bill: json["bill"] == null ? null : List<GetAllDocumentsResponseBill>.from(json["bill"].map((x) => GetAllDocumentsResponseBill.fromJson(x))),
    report: json["report"] == null ? null : List<GetAllDocumentsResponseBill>.from(json["report"].map((x) => GetAllDocumentsResponseBill.fromJson(x))),
    prescription: json["prescription"] == null ? null : List<GetAllDocumentsResponsePrescription>.from(json["prescription"].map((x) => GetAllDocumentsResponsePrescription.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "bill": bill == null ? [] : List<dynamic>.from(bill.map((x) => x.toJson())),
    "report": report == null ? [] : List<dynamic>.from(report.map((x) => x.toJson())),
    "prescription": prescription == null ? [] : List<dynamic>.from(prescription.map((x) => x.toJson())),
  };
}

class GetAllDocumentsResponseBill {
  GetAllDocumentsResponseBill({
    this.id,
    this.name,
    this.amount,
    this.date,
    this.description,
    this.billImage,
    this.patient,
    this.userId,
    this.reportImage,
  });

  String id;
  String name;
  double amount;
  DateTime date;
  String description;
  List<String> billImage;
  GetAllDocumentsResponsePatient patient;
  String userId;
  List<String> reportImage;

  factory GetAllDocumentsResponseBill.fromJson(Map<String, dynamic> json) => GetAllDocumentsResponseBill(
    id: json["_id"] == null ? null : json["_id"],
    name: json["name"] == null ? null : json["name"],
    amount: json["amount"] == null ? null : json["amount"].toDouble(),
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    description: json["description"] == null ? null : json["description"],
    billImage: json["bill_image"] == null ? [] : List<String>.from(json["bill_image"].map((x) => x)),
    patient: json["patient"] == null ? null : GetAllDocumentsResponsePatient.fromJson(json["patient"]),
    userId: json["user_id"] == null ? null : json["user_id"],
    reportImage: json["report_image"] == null ? [] : List<String>.from(json["report_image"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "name": name == null ? null : name,
    "amount": amount == null ? null : amount,
    "date": date == null ? null : date.toIso8601String(),
    "description": description == null ? null : description,
    "bill_image": billImage == null ? null : List<dynamic>.from(billImage.map((x) => x)),
    "patient": patient == null ? null : patient.toJson(),
    "user_id": userId == null ? null : userId,
    "report_image": reportImage == null ? null : List<dynamic>.from(reportImage.map((x) => x)),
  };
}

class GetAllDocumentsResponsePatient {
  GetAllDocumentsResponsePatient({
    this.name,
    this.relationship,
    this.age,
    this.avatar,
    this.userId,
    this.id,
  });

  String name;
  String relationship;
  int age;
  String avatar;
  String userId;
  String id;

  factory GetAllDocumentsResponsePatient.fromJson(Map<String, dynamic> json) => GetAllDocumentsResponsePatient(
    name: json["name"] == null ? null : json["name"],
    relationship: json["relationship"] == null ? null : json["relationship"],
    age: json["age"] == null ? null : json["age"],
    avatar: json["avatar"] == null ? null : json["avatar"],
    userId: json["user_id"] == null ? null : json["user_id"],
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "relationship": relationship == null ? null : relationship,
    "age": age == null ? null : age,
    "avatar": avatar == null ? null : avatar,
    "user_id": userId == null ? null : userId,
    "id": id == null ? null : id,
  };
}

class GetAllDocumentsResponsePrescription {
  GetAllDocumentsResponsePrescription({
    this.id,
    this.doctorName,
    this.clinicName,
    this.userAilment,
    this.consultationDate,
    this.doctorAdvice,
    this.prescriptionImage,
    this.patient,
    this.userId,
  });

  String id;
  String doctorName;
  String clinicName;
  String userAilment;
  DateTime consultationDate;
  String doctorAdvice;
  List<String> prescriptionImage;
  GetAllDocumentsResponsePatient patient;
  String userId;

  factory GetAllDocumentsResponsePrescription.fromJson(Map<String, dynamic> json) => GetAllDocumentsResponsePrescription(
    id: json["_id"] == null ? null : json["_id"],
    doctorName: json["doctor_name"] == null ? null : json["doctor_name"],
    clinicName: json["clinic_name"] == null ? null : json["clinic_name"],
    userAilment: json["user_ailment"] == null ? null : json["user_ailment"],
    consultationDate: json["consultation_date"] == null ? null : DateTime.parse(json["consultation_date"]),
    doctorAdvice: json["doctor_advice"] == null ? null : json["doctor_advice"],
    prescriptionImage: json["prescription_image"] == null ? [] : List<String>.from(json["prescription_image"].map((x) => x)),
    patient: json["patient"] == null ? null : GetAllDocumentsResponsePatient.fromJson(json["patient"]),
    userId: json["user_id"] == null ? null : json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "doctor_name": doctorName == null ? null : doctorName,
    "clinic_name": clinicName == null ? null : clinicName,
    "user_ailment": userAilment == null ? null : userAilment,
    "consultation_date": consultationDate == null ? null : consultationDate.toIso8601String(),
    "doctor_advice": doctorAdvice == null ? null : doctorAdvice,
    "prescription_image": prescriptionImage == null ? null : List<dynamic>.from(prescriptionImage.map((x) => x)),
    "patient": patient == null ? null : patient.toJson(),
    "user_id": userId == null ? null : userId,
  };
}

class DeletePrescriptionResponse {
  DeletePrescriptionResponse({
    this.success,
    this.data,
  });

  bool success;
  DeletePrescriptionResponseData data;

  factory DeletePrescriptionResponse.fromJson(Map<String, dynamic> json) => DeletePrescriptionResponse(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : DeletePrescriptionResponseData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data.toJson(),
  };
}

class DeletePrescriptionResponseData {
  DeletePrescriptionResponseData({
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

  factory DeletePrescriptionResponseData.fromJson(Map<String, dynamic> json) => DeletePrescriptionResponseData(
    prescriptionImage: json["prescription_image"] == null ? null : List<String>.from(json["prescription_image"].map((x) => x)),
    doctorName: json["doctor_name"] == null ? null : json["doctor_name"],
    clinicName: json["clinic_name"] == null ? null : json["clinic_name"],
    consultationDate: json["consultation_date"] == null ? null : DateTime.parse(json["consultation_date"]),
    userAilment: json["user_ailment"] == null ? null : json["user_ailment"],
    doctorAdvice: json["doctor_advice"] == null ? null : json["doctor_advice"],
    patient: json["patient"] == null ? null : json["patient"],
    userId: json["user_id"] == null ? null : json["user_id"],
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "prescription_image": prescriptionImage == null ? null : List<dynamic>.from(prescriptionImage.map((x) => x)),
    "doctor_name": doctorName == null ? null : doctorName,
    "clinic_name": clinicName == null ? null : clinicName,
    "consultation_date": consultationDate == null ? null : consultationDate.toIso8601String(),
    "user_ailment": userAilment == null ? null : userAilment,
    "doctor_advice": doctorAdvice == null ? null : doctorAdvice,
    "patient": patient == null ? null : patient,
    "user_id": userId == null ? null : userId,
    "id": id == null ? null : id,
  };
}


class DeleteReportResponse {
  DeleteReportResponse({
    this.success,
    this.data,
  });

  bool success;
  DeleteReportResponseData data;

  factory DeleteReportResponse.fromJson(Map<String, dynamic> json) => DeleteReportResponse(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : DeleteReportResponseData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data.toJson(),
  };
}

class DeleteReportResponseData {
  DeleteReportResponseData({
    this.reportImage,
    this.name,
    this.date,
    this.description,
    this.patient,
    this.userId,
    this.id,
  });

  List<String> reportImage;
  String name;
  DateTime date;
  String description;
  String patient;
  String userId;
  String id;

  factory DeleteReportResponseData.fromJson(Map<String, dynamic> json) => DeleteReportResponseData(
    reportImage: json["report_image"] == null ? null : List<String>.from(json["report_image"].map((x) => x)),
    name: json["name"] == null ? null : json["name"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    description: json["description"] == null ? null : json["description"],
    patient: json["patient"] == null ? null : json["patient"],
    userId: json["user_id"] == null ? null : json["user_id"],
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "report_image": reportImage == null ? null : List<dynamic>.from(reportImage.map((x) => x)),
    "name": name == null ? null : name,
    "date": date == null ? null : date.toIso8601String(),
    "description": description == null ? null : description,
    "patient": patient == null ? null : patient,
    "user_id": userId == null ? null : userId,
    "id": id == null ? null : id,
  };
}

class DeleteBillResponse {
  DeleteBillResponse({
    this.success,
    this.data,
  });

  bool success;
  DeleteBillResponseData data;

  factory DeleteBillResponse.fromJson(Map<String, dynamic> json) => DeleteBillResponse(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : DeleteBillResponseData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data.toJson(),
  };
}

class DeleteBillResponseData {
  DeleteBillResponseData({
    this.billImage,
    this.name,
    this.amount,
    this.date,
    this.description,
    this.patient,
    this.userId,
    this.id,
  });

  List<String> billImage;
  String name;
  int amount;
  DateTime date;
  String description;
  String patient;
  String userId;
  String id;

  factory DeleteBillResponseData.fromJson(Map<String, dynamic> json) => DeleteBillResponseData(
    billImage: json["bill_image"] == null ? null : List<String>.from(json["bill_image"].map((x) => x)),
    name: json["name"] == null ? null : json["name"],
    amount: json["amount"] == null ? null : json["amount"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    description: json["description"] == null ? null : json["description"],
    patient: json["patient"] == null ? null : json["patient"],
    userId: json["user_id"] == null ? null : json["user_id"],
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "bill_image": billImage == null ? null : List<dynamic>.from(billImage.map((x) => x)),
    "name": name == null ? null : name,
    "amount": amount == null ? null : amount,
    "date": date == null ? null : date.toIso8601String(),
    "description": description == null ? null : description,
    "patient": patient == null ? null : patient,
    "user_id": userId == null ? null : userId,
    "id": id == null ? null : id,
  };
}

class RegisterLoginResponse {
  RegisterLoginResponse({
    this.success,
    this.data,
  });

  bool success;
  RegisterLoginResponseData data;

  factory RegisterLoginResponse.fromJson(Map<String, dynamic> json) => RegisterLoginResponse(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : RegisterLoginResponseData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data.toJson(),
  };
}

class RegisterLoginResponseData {
  RegisterLoginResponseData({
    this.id,
    this.name,
    this.emailId,
    this.uid,
    this.gender,
    this.avatar,
    this.countryCode,
    this.phoneNumber,
    this.googleAddress,
    this.userAddress,
    this.city,
    this.state,
    this.bloodGroup,
    this.xAuthToken,
  });

  String id;
  String name;
  String emailId;
  String uid;
  String gender;
  String avatar;
  String countryCode;
  String phoneNumber;
  String googleAddress;
  String userAddress;
  String city;
  String state;
  String bloodGroup;
  String xAuthToken;

  factory RegisterLoginResponseData.fromJson(Map<String, dynamic> json) => RegisterLoginResponseData(
    id: json["_id"] == null ? null : json["_id"],
    name: json["name"] == null ? null : json["name"],
    emailId: json["email_id"] == null ? null : json["email_id"],
    uid: json["uid"] == null ? null : json["uid"],
    gender: json["gender"] == null ? null : json["gender"],
    avatar: json["avatar"] == null ? null : json["avatar"],
    countryCode: json["country_code"] == null ? null : json["country_code"],
    phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
    googleAddress: json["google_address"] == null ? null : json["google_address"],
    userAddress: json["user_address"] == null ? null : json["user_address"],
    city: json["city"] == null ? null : json["city"],
    state: json["state"] == null ? null : json["state"],
    bloodGroup: json["blood_group"] == null ? null : json["blood_group"],
    xAuthToken: json["x_auth_token"] == null ? null : json["x_auth_token"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "name": name == null ? null : name,
    "email_id": emailId == null ? null : emailId,
    "uid": uid == null ? null : uid,
    "gender": gender == null ? null : gender,
    "avatar": avatar == null ? null : avatar,
    "country_code": countryCode == null ? null : countryCode,
    "phone_number": phoneNumber == null ? null : phoneNumber,
    "google_address": googleAddress == null ? null : googleAddress,
    "user_address": userAddress == null ? null : userAddress,
    "city": city == null ? null : city,
    "state": state == null ? null : state,
    "blood_group": bloodGroup == null ? null : bloodGroup,
    "x_auth_token": xAuthToken == null ? null : xAuthToken,
  };
}
