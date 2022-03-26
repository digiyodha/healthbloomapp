import '../request/request.dart';

class AddBillResponse {
  AddBillResponse({
    this.success,
    this.data,
  });

  bool success;
  AddBillResponseData data;

  factory AddBillResponse.fromJson(Map<String, dynamic> json) =>
      AddBillResponse(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : AddBillResponseData.fromJson(json["data"]),
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

  List<ImageListRequest> billImage;
  String name;
  double amount;
  DateTime date;
  String description;
  String patient;
  String userId;
  String id;

  factory AddBillResponseData.fromJson(Map<String, dynamic> json) =>
      AddBillResponseData(
        billImage: json["bill_image"] == null ? null : List<ImageListRequest>.from(json["bill_image"].map((x) => ImageListRequest.fromJson(x))),
        name: json["name"] == null ? null : json["name"],
        amount: json["amount"] == null ? null : json["amount"].toDouble(),
        date: json["date"] == null ? null : DateTime.parse(json["date"]).toLocal(),
        description: json["description"] == null ? null : json["description"],
        patient: json["patient"] == null ? null : json["patient"],
        userId: json["user_id"] == null ? null : json["user_id"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "bill_image": billImage == null ? null : List<dynamic>.from(billImage.map((x) => x.toJson())),
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

  factory GetAllDocumentsResponse.fromJson(Map<String, dynamic> json) =>
      GetAllDocumentsResponse(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : GetAllDocumentsResponseData.fromJson(json["data"]),
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

  factory GetAllDocumentsResponseData.fromJson(Map<String, dynamic> json) =>
      GetAllDocumentsResponseData(
        bill: json["bill"] == null
            ? null
            : List<GetAllDocumentsResponseBill>.from(json["bill"]
                .map((x) => GetAllDocumentsResponseBill.fromJson(x))),
        report: json["report"] == null
            ? null
            : List<GetAllDocumentsResponseBill>.from(json["report"]
                .map((x) => GetAllDocumentsResponseBill.fromJson(x))),
        prescription: json["prescription"] == null
            ? null
            : List<GetAllDocumentsResponsePrescription>.from(
                json["prescription"].map(
                    (x) => GetAllDocumentsResponsePrescription.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bill":
            bill == null ? [] : List<dynamic>.from(bill.map((x) => x.toJson())),
        "report": report == null
            ? []
            : List<dynamic>.from(report.map((x) => x.toJson())),
        "prescription": prescription == null
            ? []
            : List<dynamic>.from(prescription.map((x) => x.toJson())),
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
  List<ImageListRequest> billImage;
  GetAllDocumentsResponsePatient patient;
  String userId;
  List<ImageListRequest> reportImage;

  factory GetAllDocumentsResponseBill.fromJson(Map<String, dynamic> json) =>
      GetAllDocumentsResponseBill(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        amount: json["amount"] == null ? null : json["amount"].toDouble(),
        date: json["date"] == null ? null : DateTime.parse(json["date"]).toLocal(),
        description: json["description"] == null ? null : json["description"],
        billImage: json["bill_image"] == null ? [] : List<ImageListRequest>.from(json["bill_image"].map((x) => ImageListRequest.fromJson(x))),
        patient: json["patient"] == null
            ? null
            : GetAllDocumentsResponsePatient.fromJson(json["patient"]),
        userId: json["user_id"] == null ? null : json["user_id"],
        reportImage: json["report_image"] == null ? null : List<ImageListRequest>.from(json["report_image"].map((x) => ImageListRequest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "amount": amount == null ? null : amount,
        "date": date == null ? null : date.toIso8601String(),
        "description": description == null ? null : description,
        "bill_image": billImage == null ? null : List<dynamic>.from(billImage.map((x) => x.toJson())),
        "patient": patient == null ? null : patient.toJson(),
        "user_id": userId == null ? null : userId,
        "report_image": reportImage == null ? null : List<dynamic>.from(reportImage.map((x) => x.toJson())),
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

  factory GetAllDocumentsResponsePatient.fromJson(Map<String, dynamic> json) =>
      GetAllDocumentsResponsePatient(
        name: json["name"] == null ? null : json["name"],
        relationship:
            json["relationship"] == null ? null : json["relationship"],
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
  List<ImageListRequest> prescriptionImage;
  GetAllDocumentsResponsePatient patient;
  String userId;

  factory GetAllDocumentsResponsePrescription.fromJson(
          Map<String, dynamic> json) =>
      GetAllDocumentsResponsePrescription(
        id: json["_id"] == null ? null : json["_id"],
        doctorName: json["doctor_name"] == null ? null : json["doctor_name"],
        clinicName: json["clinic_name"] == null ? null : json["clinic_name"],
        userAilment: json["user_ailment"] == null ? null : json["user_ailment"],
        consultationDate: json["consultation_date"] == null
            ? null
            : DateTime.parse(json["consultation_date"]).toLocal(),
        doctorAdvice:
            json["doctor_advice"] == null ? null : json["doctor_advice"],
        prescriptionImage: json["prescription_image"] == null ? null : List<ImageListRequest>.from(json["prescription_image"].map((x) => ImageListRequest.fromJson(x))),
        patient: json["patient"] == null
            ? null
            : GetAllDocumentsResponsePatient.fromJson(json["patient"]),
        userId: json["user_id"] == null ? null : json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "doctor_name": doctorName == null ? null : doctorName,
        "clinic_name": clinicName == null ? null : clinicName,
        "user_ailment": userAilment == null ? null : userAilment,
        "consultation_date": consultationDate == null
            ? null
            : consultationDate.toIso8601String(),
        "doctor_advice": doctorAdvice == null ? null : doctorAdvice,
    "prescription_image": prescriptionImage == null ? null : List<dynamic>.from(prescriptionImage.map((x) => x.toJson())),
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

  factory DeletePrescriptionResponse.fromJson(Map<String, dynamic> json) =>
      DeletePrescriptionResponse(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : DeletePrescriptionResponseData.fromJson(json["data"]),
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

  factory DeletePrescriptionResponseData.fromJson(Map<String, dynamic> json) =>
      DeletePrescriptionResponseData(
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

class DeleteReportResponse {
  DeleteReportResponse({
    this.success,
    this.data,
  });

  bool success;
  DeleteReportResponseData data;

  factory DeleteReportResponse.fromJson(Map<String, dynamic> json) =>
      DeleteReportResponse(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : DeleteReportResponseData.fromJson(json["data"]),
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

  factory DeleteReportResponseData.fromJson(Map<String, dynamic> json) =>
      DeleteReportResponseData(
        reportImage: json["report_image"] == null
            ? null
            : List<String>.from(json["report_image"].map((x) => x)),
        name: json["name"] == null ? null : json["name"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]).toLocal(),
        description: json["description"] == null ? null : json["description"],
        patient: json["patient"] == null ? null : json["patient"],
        userId: json["user_id"] == null ? null : json["user_id"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "report_image": reportImage == null
            ? null
            : List<dynamic>.from(reportImage.map((x) => x)),
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

  factory DeleteBillResponse.fromJson(Map<String, dynamic> json) =>
      DeleteBillResponse(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : DeleteBillResponseData.fromJson(json["data"]),
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

  factory DeleteBillResponseData.fromJson(Map<String, dynamic> json) =>
      DeleteBillResponseData(
        billImage: json["bill_image"] == null
            ? null
            : List<String>.from(json["bill_image"].map((x) => x)),
        name: json["name"] == null ? null : json["name"],
        amount: json["amount"] == null ? null : json["amount"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]).toLocal(),
        description: json["description"] == null ? null : json["description"],
        patient: json["patient"] == null ? null : json["patient"],
        userId: json["user_id"] == null ? null : json["user_id"],
        id: json["id"] == null ? null : json["id"],
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
      };
}

class RegisterLoginResponse {
  RegisterLoginResponse({
    this.success,
    this.data,
    this.error,
  });

  bool success;
  RegisterLoginResponseData data;
  String error;
  factory RegisterLoginResponse.fromJson(Map<String, dynamic> json) =>
      RegisterLoginResponse(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : RegisterLoginResponseData.fromJson(json["data"]),
        error: json["error"] == null ? null : json["error"],
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null ? null : data.toJson(),
        "error": error == null ? null : error,
      };
}

class RegisterLoginResponseData {
  RegisterLoginResponseData(
      {this.id,
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
      this.isActive,
      this.newUser});

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
  bool isActive;
  bool newUser;

  factory RegisterLoginResponseData.fromJson(Map<String, dynamic> json) =>
      RegisterLoginResponseData(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        emailId: json["email_id"] == null ? null : json["email_id"],
        uid: json["uid"] == null ? null : json["uid"],
        gender: json["gender"] == null ? null : json["gender"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        countryCode: json["country_code"] == null ? null : json["country_code"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        googleAddress:
            json["google_address"] == null ? null : json["google_address"],
        userAddress: json["user_address"] == null ? null : json["user_address"],
        city: json["city"] == null ? null : json["city"],
        state: json["state"] == null ? null : json["state"],
        bloodGroup: json["blood_group"] == null ? null : json["blood_group"],
        xAuthToken: json["x_auth_token"] == null ? null : json["x_auth_token"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        newUser: json["new_user"] == null ? null : json["new_user"],
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
        "is_active": isActive == null ? null : isActive,
        "x_auth_token": xAuthToken == null ? null : xAuthToken,
      };
}

class MapsNearbyMedicalsResponse {
  MapsNearbyMedicalsResponse({
    this.success,
    this.data,
  });

  bool success;
  MapsNearbyMedicalsResponseData data;

  factory MapsNearbyMedicalsResponse.fromJson(Map<String, dynamic> json) => MapsNearbyMedicalsResponse(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : MapsNearbyMedicalsResponseData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data.toJson(),
  };
}

class MapsNearbyMedicalsResponseData {
  MapsNearbyMedicalsResponseData({
    this.htmlAttributions,
    this.nextPageToken,
    this.results,
    this.status,
  });

  List<dynamic> htmlAttributions;
  String nextPageToken;
  List<MapsNearbyMedicalsResponseResult> results;
  String status;

  factory MapsNearbyMedicalsResponseData.fromJson(Map<String, dynamic> json) => MapsNearbyMedicalsResponseData(
    htmlAttributions: json["html_attributions"] == null ? [] : List<dynamic>.from(json["html_attributions"].map((x) => x)),
    nextPageToken: json["next_page_token"] == null ? null : json["next_page_token"],
    results: json["results"] == null ? [] : List<MapsNearbyMedicalsResponseResult>.from(json["results"].map((x) => MapsNearbyMedicalsResponseResult.fromJson(x))),
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "html_attributions": htmlAttributions == null ? null : List<dynamic>.from(htmlAttributions.map((x) => x)),
    "next_page_token": nextPageToken == null ? null : nextPageToken,
    "results": results == null ? null : List<dynamic>.from(results.map((x) => x.toJson())),
    "status": status == null ? null : status,
  };
}

class MapsNearbyMedicalsResponseResult {
  MapsNearbyMedicalsResponseResult({
    this.businessStatus,
    this.geometry,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    this.name,
    this.openingHours,
    this.photos,
    this.placeId,
    this.plusCode,
    this.rating,
    this.reference,
    this.scope,
    this.types,
    this.userRatingsTotal,
    this.vicinity,
  });

  String businessStatus;
  MapsNearbyMedicalsResponseGeometry geometry;
  String icon;
  String iconBackgroundColor;
  String iconMaskBaseUri;
  String name;
  MapsNearbyMedicalsResponseOpeningHours openingHours;
  List<MapsNearbyMedicalsResponsePhoto> photos;
  String placeId;
  MapsNearbyMedicalsResponsePlusCode plusCode;
  double rating;
  String reference;
  String scope;
  List<String> types;
  int userRatingsTotal;
  String vicinity;

  factory MapsNearbyMedicalsResponseResult.fromJson(Map<String, dynamic> json) => MapsNearbyMedicalsResponseResult(
    businessStatus: json["business_status"] == null ? null : json["business_status"],
    geometry: json["geometry"] == null ? null : MapsNearbyMedicalsResponseGeometry.fromJson(json["geometry"]),
    icon: json["icon"] == null ? null : json["icon"],
    iconBackgroundColor: json["icon_background_color"] == null ? null : json["icon_background_color"],
    iconMaskBaseUri: json["icon_mask_base_uri"] == null ? null : json["icon_mask_base_uri"],
    name: json["name"] == null ? null : json["name"],
    openingHours: json["opening_hours"] == null ? null : MapsNearbyMedicalsResponseOpeningHours.fromJson(json["opening_hours"]),
    photos: json["photos"] == null ? [] : List<MapsNearbyMedicalsResponsePhoto>.from(json["photos"].map((x) => MapsNearbyMedicalsResponsePhoto.fromJson(x))),
    placeId: json["place_id"] == null ? null : json["place_id"],
    plusCode: json["plus_code"] == null ? null : MapsNearbyMedicalsResponsePlusCode.fromJson(json["plus_code"]),
    rating: json["rating"] == null ? null : json["rating"].toDouble(),
    reference: json["reference"] == null ? null : json["reference"],
    scope: json["scope"] == null ? null : json["scope"],
    types: json["types"] == null ? [] : List<String>.from(json["types"].map((x) => x)),
    userRatingsTotal: json["user_ratings_total"] == null ? null : json["user_ratings_total"],
    vicinity: json["vicinity"] == null ? null : json["vicinity"],
  );

  Map<String, dynamic> toJson() => {
    "business_status": businessStatus == null ? null : businessStatus,
    "geometry": geometry == null ? null : geometry.toJson(),
    "icon": icon == null ? null : icon,
    "icon_background_color": iconBackgroundColor == null ? null : iconBackgroundColor,
    "icon_mask_base_uri": iconMaskBaseUri == null ? null : iconMaskBaseUri,
    "name": name == null ? null : name,
    "opening_hours": openingHours == null ? null : openingHours.toJson(),
    "photos": photos == null ? null : List<dynamic>.from(photos.map((x) => x.toJson())),
    "place_id": placeId == null ? null : placeId,
    "plus_code": plusCode == null ? null : plusCode.toJson(),
    "rating": rating == null ? null : rating,
    "reference": reference == null ? null : reference,
    "scope": scope == null ? null : scope,
    "types": types == null ? null : List<dynamic>.from(types.map((x) => x)),
    "user_ratings_total": userRatingsTotal == null ? null : userRatingsTotal,
    "vicinity": vicinity == null ? null : vicinity,
  };
}

class MapsNearbyMedicalsResponseGeometry {
  MapsNearbyMedicalsResponseGeometry({
    this.location,
    this.viewport,
  });

  MapsNearbyMedicalsResponseLocation location;
  MapsNearbyMedicalsResponseViewport viewport;

  factory MapsNearbyMedicalsResponseGeometry.fromJson(Map<String, dynamic> json) => MapsNearbyMedicalsResponseGeometry(
    location: json["location"] == null ? null : MapsNearbyMedicalsResponseLocation.fromJson(json["location"]),
    viewport: json["viewport"] == null ? null : MapsNearbyMedicalsResponseViewport.fromJson(json["viewport"]),
  );

  Map<String, dynamic> toJson() => {
    "location": location == null ? null : location.toJson(),
    "viewport": viewport == null ? null : viewport.toJson(),
  };
}

class MapsNearbyMedicalsResponseLocation {
  MapsNearbyMedicalsResponseLocation({
    this.lat,
    this.lng,
  });

  double lat;
  double lng;

  factory MapsNearbyMedicalsResponseLocation.fromJson(Map<String, dynamic> json) => MapsNearbyMedicalsResponseLocation(
    lat: json["lat"] == null ? null : json["lat"].toDouble(),
    lng: json["lng"] == null ? null : json["lng"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat == null ? null : lat,
    "lng": lng == null ? null : lng,
  };
}

class MapsNearbyMedicalsResponseViewport {
  MapsNearbyMedicalsResponseViewport({
    this.northeast,
    this.southwest,
  });

  MapsNearbyMedicalsResponseLocation northeast;
  MapsNearbyMedicalsResponseLocation southwest;

  factory MapsNearbyMedicalsResponseViewport.fromJson(Map<String, dynamic> json) => MapsNearbyMedicalsResponseViewport(
    northeast: json["northeast"] == null ? null : MapsNearbyMedicalsResponseLocation.fromJson(json["northeast"]),
    southwest: json["southwest"] == null ? null : MapsNearbyMedicalsResponseLocation.fromJson(json["southwest"]),
  );

  Map<String, dynamic> toJson() => {
    "northeast": northeast == null ? null : northeast.toJson(),
    "southwest": southwest == null ? null : southwest.toJson(),
  };
}

class MapsNearbyMedicalsResponseOpeningHours {
  MapsNearbyMedicalsResponseOpeningHours({
    this.openNow,
  });

  bool openNow;

  factory MapsNearbyMedicalsResponseOpeningHours.fromJson(Map<String, dynamic> json) => MapsNearbyMedicalsResponseOpeningHours(
    openNow: json["open_now"] == null ? null : json["open_now"],
  );

  Map<String, dynamic> toJson() => {
    "open_now": openNow == null ? null : openNow,
  };
}

class MapsNearbyMedicalsResponsePhoto {
  MapsNearbyMedicalsResponsePhoto({
    this.height,
    this.htmlAttributions,
    this.photoReference,
    this.width,
  });

  int height;
  List<String> htmlAttributions;
  String photoReference;
  int width;

  factory MapsNearbyMedicalsResponsePhoto.fromJson(Map<String, dynamic> json) => MapsNearbyMedicalsResponsePhoto(
    height: json["height"] == null ? null : json["height"],
    htmlAttributions: json["html_attributions"] == null ? [] : List<String>.from(json["html_attributions"].map((x) => x)),
    photoReference: json["photo_reference"] == null ? null : json["photo_reference"],
    width: json["width"] == null ? null : json["width"],
  );

  Map<String, dynamic> toJson() => {
    "height": height == null ? null : height,
    "html_attributions": htmlAttributions == null ? null : List<dynamic>.from(htmlAttributions.map((x) => x)),
    "photo_reference": photoReference == null ? null : photoReference,
    "width": width == null ? null : width,
  };
}

class MapsNearbyMedicalsResponsePlusCode {
  MapsNearbyMedicalsResponsePlusCode({
    this.compoundCode,
    this.globalCode,
  });

  String compoundCode;
  String globalCode;

  factory MapsNearbyMedicalsResponsePlusCode.fromJson(Map<String, dynamic> json) => MapsNearbyMedicalsResponsePlusCode(
    compoundCode: json["compound_code"] == null ? null : json["compound_code"],
    globalCode: json["global_code"] == null ? null : json["global_code"],
  );

  Map<String, dynamic> toJson() => {
    "compound_code": compoundCode == null ? null : compoundCode,
    "global_code": globalCode == null ? null : globalCode,
  };
}

class MapsPlaceDetailsResponse {
  MapsPlaceDetailsResponse({
    this.success,
    this.data,
  });

  bool success;
  MapsPlaceDetailsResponseData data;

  factory MapsPlaceDetailsResponse.fromJson(Map<String, dynamic> json) => MapsPlaceDetailsResponse(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : MapsPlaceDetailsResponseData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data.toJson(),
  };
}

class MapsPlaceDetailsResponseData {
  MapsPlaceDetailsResponseData({
    this.htmlAttributions,
    this.result,
    this.status,
  });

  List<dynamic> htmlAttributions;
  MapsPlaceDetailsResponseResult result;
  String status;

  factory MapsPlaceDetailsResponseData.fromJson(Map<String, dynamic> json) => MapsPlaceDetailsResponseData(
    htmlAttributions: json["html_attributions"] == null ? [] : List<dynamic>.from(json["html_attributions"].map((x) => x)),
    result: json["result"] == null ? null : MapsPlaceDetailsResponseResult.fromJson(json["result"]),
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "html_attributions": htmlAttributions == null ? null : List<dynamic>.from(htmlAttributions.map((x) => x)),
    "result": result == null ? null : result.toJson(),
    "status": status == null ? null : status,
  };
}

class MapsPlaceDetailsResponseResult {
  MapsPlaceDetailsResponseResult({
    this.addressComponents,
    this.adrAddress,
    this.businessStatus,
    this.formattedAddress,
    this.formattedPhoneNumber,
    this.geometry,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    this.internationalPhoneNumber,
    this.name,
    this.openingHours,
    this.photos,
    this.placeId,
    this.plusCode,
    this.rating,
    this.reference,
    this.reviews,
    this.types,
    this.url,
    this.userRatingsTotal,
    this.utcOffset,
    this.vicinity,
    this.website,
  });

  List<MapsPlaceDetailsResponseAddressComponent> addressComponents;
  String adrAddress;
  String businessStatus;
  String formattedAddress;
  String formattedPhoneNumber;
  MapsPlaceDetailsResponseGeometry geometry;
  String icon;
  String iconBackgroundColor;
  String iconMaskBaseUri;
  String internationalPhoneNumber;
  String name;
  MapsPlaceDetailsResponseOpeningHours openingHours;
  List<MapsPlaceDetailsResponsePhoto> photos;
  String placeId;
  MapsPlaceDetailsResponsePlusCode plusCode;
  double rating;
  String reference;
  List<MapsPlaceDetailsResponseReview> reviews;
  List<String> types;
  String url;
  int userRatingsTotal;
  int utcOffset;
  String vicinity;
  String website;

  factory MapsPlaceDetailsResponseResult.fromJson(Map<String, dynamic> json) => MapsPlaceDetailsResponseResult(
    addressComponents: json["address_components"] == null ? [] : List<MapsPlaceDetailsResponseAddressComponent>.from(json["address_components"].map((x) => MapsPlaceDetailsResponseAddressComponent.fromJson(x))),
    adrAddress: json["adr_address"] == null ? null : json["adr_address"],
    businessStatus: json["business_status"] == null ? null : json["business_status"],
    formattedAddress: json["formatted_address"] == null ? null : json["formatted_address"],
    formattedPhoneNumber: json["formatted_phone_number"] == null ? null : json["formatted_phone_number"],
    geometry: json["geometry"] == null ? null : MapsPlaceDetailsResponseGeometry.fromJson(json["geometry"]),
    icon: json["icon"] == null ? null : json["icon"],
    iconBackgroundColor: json["icon_background_color"] == null ? null : json["icon_background_color"],
    iconMaskBaseUri: json["icon_mask_base_uri"] == null ? null : json["icon_mask_base_uri"],
    internationalPhoneNumber: json["international_phone_number"] == null ? null : json["international_phone_number"],
    name: json["name"] == null ? null : json["name"],
    openingHours: json["opening_hours"] == null ? null : MapsPlaceDetailsResponseOpeningHours.fromJson(json["opening_hours"]),
    photos: json["photos"] == null ? [] : List<MapsPlaceDetailsResponsePhoto>.from(json["photos"].map((x) => MapsPlaceDetailsResponsePhoto.fromJson(x))),
    placeId: json["place_id"] == null ? null : json["place_id"],
    plusCode: json["plus_code"] == null ? null : MapsPlaceDetailsResponsePlusCode.fromJson(json["plus_code"]),
    rating: json["rating"] == null ? null : json["rating"].toDouble(),
    reference: json["reference"] == null ? null : json["reference"],
    reviews: json["reviews"] == null ? [] : List<MapsPlaceDetailsResponseReview>.from(json["reviews"].map((x) => MapsPlaceDetailsResponseReview.fromJson(x))),
    types: json["types"] == null ? [] : List<String>.from(json["types"].map((x) => x)),
    url: json["url"] == null ? null : json["url"],
    userRatingsTotal: json["user_ratings_total"] == null ? null : json["user_ratings_total"],
    utcOffset: json["utc_offset"] == null ? null : json["utc_offset"],
    vicinity: json["vicinity"] == null ? null : json["vicinity"],
    website: json["website"] == null ? null : json["website"],
  );

  Map<String, dynamic> toJson() => {
    "address_components": addressComponents == null ? null : List<dynamic>.from(addressComponents.map((x) => x.toJson())),
    "adr_address": adrAddress == null ? null : adrAddress,
    "business_status": businessStatus == null ? null : businessStatus,
    "formatted_address": formattedAddress == null ? null : formattedAddress,
    "formatted_phone_number": formattedPhoneNumber == null ? null : formattedPhoneNumber,
    "geometry": geometry == null ? null : geometry.toJson(),
    "icon": icon == null ? null : icon,
    "icon_background_color": iconBackgroundColor == null ? null : iconBackgroundColor,
    "icon_mask_base_uri": iconMaskBaseUri == null ? null : iconMaskBaseUri,
    "international_phone_number": internationalPhoneNumber == null ? null : internationalPhoneNumber,
    "name": name == null ? null : name,
    "opening_hours": openingHours == null ? null : openingHours.toJson(),
    "photos": photos == null ? null : List<dynamic>.from(photos.map((x) => x.toJson())),
    "place_id": placeId == null ? null : placeId,
    "plus_code": plusCode == null ? null : plusCode.toJson(),
    "rating": rating == null ? null : rating,
    "reference": reference == null ? null : reference,
    "reviews": reviews == null ? null : List<dynamic>.from(reviews.map((x) => x.toJson())),
    "types": types == null ? null : List<dynamic>.from(types.map((x) => x)),
    "url": url == null ? null : url,
    "user_ratings_total": userRatingsTotal == null ? null : userRatingsTotal,
    "utc_offset": utcOffset == null ? null : utcOffset,
    "vicinity": vicinity == null ? null : vicinity,
    "website": website == null ? null : website,
  };
}

class MapsPlaceDetailsResponseAddressComponent {
  MapsPlaceDetailsResponseAddressComponent({
    this.longName,
    this.shortName,
    this.types,
  });

  String longName;
  String shortName;
  List<String> types;

  factory MapsPlaceDetailsResponseAddressComponent.fromJson(Map<String, dynamic> json) => MapsPlaceDetailsResponseAddressComponent(
    longName: json["long_name"] == null ? null : json["long_name"],
    shortName: json["short_name"] == null ? null : json["short_name"],
    types: json["types"] == null ? [] : List<String>.from(json["types"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "long_name": longName == null ? null : longName,
    "short_name": shortName == null ? null : shortName,
    "types": types == null ? null : List<dynamic>.from(types.map((x) => x)),
  };
}

class MapsPlaceDetailsResponseGeometry {
  MapsPlaceDetailsResponseGeometry({
    this.location,
    this.viewport,
  });

  MapsPlaceDetailsResponseLocation location;
  MapsPlaceDetailsResponseViewport viewport;

  factory MapsPlaceDetailsResponseGeometry.fromJson(Map<String, dynamic> json) => MapsPlaceDetailsResponseGeometry(
    location: json["location"] == null ? null : MapsPlaceDetailsResponseLocation.fromJson(json["location"]),
    viewport: json["viewport"] == null ? null : MapsPlaceDetailsResponseViewport.fromJson(json["viewport"]),
  );

  Map<String, dynamic> toJson() => {
    "location": location == null ? null : location.toJson(),
    "viewport": viewport == null ? null : viewport.toJson(),
  };
}

class MapsPlaceDetailsResponseLocation {
  MapsPlaceDetailsResponseLocation({
    this.lat,
    this.lng,
  });

  double lat;
  double lng;

  factory MapsPlaceDetailsResponseLocation.fromJson(Map<String, dynamic> json) => MapsPlaceDetailsResponseLocation(
    lat: json["lat"] == null ? null : json["lat"].toDouble(),
    lng: json["lng"] == null ? null : json["lng"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat == null ? null : lat,
    "lng": lng == null ? null : lng,
  };
}

class MapsPlaceDetailsResponseViewport {
  MapsPlaceDetailsResponseViewport({
    this.northeast,
    this.southwest,
  });

  MapsPlaceDetailsResponseLocation northeast;
  MapsPlaceDetailsResponseLocation southwest;

  factory MapsPlaceDetailsResponseViewport.fromJson(Map<String, dynamic> json) => MapsPlaceDetailsResponseViewport(
    northeast: json["northeast"] == null ? null : MapsPlaceDetailsResponseLocation.fromJson(json["northeast"]),
    southwest: json["southwest"] == null ? null : MapsPlaceDetailsResponseLocation.fromJson(json["southwest"]),
  );

  Map<String, dynamic> toJson() => {
    "northeast": northeast == null ? null : northeast.toJson(),
    "southwest": southwest == null ? null : southwest.toJson(),
  };
}

class MapsPlaceDetailsResponseOpeningHours {
  MapsPlaceDetailsResponseOpeningHours({
    this.openNow,
    this.periods,
    this.weekdayText,
  });

  bool openNow;
  List<MapsPlaceDetailsResponsePeriod> periods;
  List<String> weekdayText;

  factory MapsPlaceDetailsResponseOpeningHours.fromJson(Map<String, dynamic> json) => MapsPlaceDetailsResponseOpeningHours(
    openNow: json["open_now"] == null ? null : json["open_now"],
    periods: json["periods"] == null ? [] : List<MapsPlaceDetailsResponsePeriod>.from(json["periods"].map((x) => MapsPlaceDetailsResponsePeriod.fromJson(x))),
    weekdayText: json["weekday_text"] == null ? [] : List<String>.from(json["weekday_text"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "open_now": openNow == null ? null : openNow,
    "periods": periods == null ? null : List<dynamic>.from(periods.map((x) => x.toJson())),
    "weekday_text": weekdayText == null ? null : List<dynamic>.from(weekdayText.map((x) => x)),
  };
}

class MapsPlaceDetailsResponsePeriod {
  MapsPlaceDetailsResponsePeriod({
    this.close,
    this.open,
  });

  MapsPlaceDetailsResponseClose close;
  MapsPlaceDetailsResponseClose open;

  factory MapsPlaceDetailsResponsePeriod.fromJson(Map<String, dynamic> json) => MapsPlaceDetailsResponsePeriod(
    close: json["close"] == null ? null : MapsPlaceDetailsResponseClose.fromJson(json["close"]),
    open: json["open"] == null ? null : MapsPlaceDetailsResponseClose.fromJson(json["open"]),
  );

  Map<String, dynamic> toJson() => {
    "close": close == null ? null : close.toJson(),
    "open": open == null ? null : open.toJson(),
  };
}

class MapsPlaceDetailsResponseClose {
  MapsPlaceDetailsResponseClose({
    this.day,
    this.time,
  });

  int day;
  String time;

  factory MapsPlaceDetailsResponseClose.fromJson(Map<String, dynamic> json) => MapsPlaceDetailsResponseClose(
    day: json["day"] == null ? null : json["day"],
    time: json["time"] == null ? null : json["time"],
  );

  Map<String, dynamic> toJson() => {
    "day": day == null ? null : day,
    "time": time == null ? null : time,
  };
}

class MapsPlaceDetailsResponsePhoto {
  MapsPlaceDetailsResponsePhoto({
    this.height,
    this.htmlAttributions,
    this.photoReference,
    this.width,
  });

  int height;
  List<String> htmlAttributions;
  String photoReference;
  int width;

  factory MapsPlaceDetailsResponsePhoto.fromJson(Map<String, dynamic> json) => MapsPlaceDetailsResponsePhoto(
    height: json["height"] == null ? null : json["height"],
    htmlAttributions: json["html_attributions"] == null ? [] : List<String>.from(json["html_attributions"].map((x) => x)),
    photoReference: json["photo_reference"] == null ? null : json["photo_reference"],
    width: json["width"] == null ? null : json["width"],
  );

  Map<String, dynamic> toJson() => {
    "height": height == null ? null : height,
    "html_attributions": htmlAttributions == null ? null : List<dynamic>.from(htmlAttributions.map((x) => x)),
    "photo_reference": photoReference == null ? null : photoReference,
    "width": width == null ? null : width,
  };
}

class MapsPlaceDetailsResponsePlusCode {
  MapsPlaceDetailsResponsePlusCode({
    this.compoundCode,
    this.globalCode,
  });

  String compoundCode;
  String globalCode;

  factory MapsPlaceDetailsResponsePlusCode.fromJson(Map<String, dynamic> json) => MapsPlaceDetailsResponsePlusCode(
    compoundCode: json["compound_code"] == null ? null : json["compound_code"],
    globalCode: json["global_code"] == null ? null : json["global_code"],
  );

  Map<String, dynamic> toJson() => {
    "compound_code": compoundCode == null ? null : compoundCode,
    "global_code": globalCode == null ? null : globalCode,
  };
}

class MapsPlaceDetailsResponseReview {
  MapsPlaceDetailsResponseReview({
    this.authorName,
    this.authorUrl,
    this.language,
    this.profilePhotoUrl,
    this.rating,
    this.relativeTimeDescription,
    this.text,
    this.time,
  });

  String authorName;
  String authorUrl;
  String language;
  String profilePhotoUrl;
  int rating;
  String relativeTimeDescription;
  String text;
  int time;

  factory MapsPlaceDetailsResponseReview.fromJson(Map<String, dynamic> json) => MapsPlaceDetailsResponseReview(
    authorName: json["author_name"] == null ? null : json["author_name"],
    authorUrl: json["author_url"] == null ? null : json["author_url"],
    language: json["language"] == null ? null : json["language"],
    profilePhotoUrl: json["profile_photo_url"] == null ? null : json["profile_photo_url"],
    rating: json["rating"] == null ? null : json["rating"],
    relativeTimeDescription: json["relative_time_description"] == null ? null : json["relative_time_description"],
    text: json["text"] == null ? null : json["text"],
    time: json["time"] == null ? null : json["time"],
  );

  Map<String, dynamic> toJson() => {
    "author_name": authorName == null ? null : authorName,
    "author_url": authorUrl == null ? null : authorUrl,
    "language": language == null ? null : language,
    "profile_photo_url": profilePhotoUrl == null ? null : profilePhotoUrl,
    "rating": rating == null ? null : rating,
    "relative_time_description": relativeTimeDescription == null ? null : relativeTimeDescription,
    "text": text == null ? null : text,
    "time": time == null ? null : time,
  };
}

class AddEditReminderResponse {
  AddEditReminderResponse({
    this.success,
    this.data,
  });

  bool success;
  AddEditReminderResponseData data;

  factory AddEditReminderResponse.fromJson(Map<String, dynamic> json) => AddEditReminderResponse(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : AddEditReminderResponseData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data.toJson(),
  };
}

class AddEditReminderResponseData {
  AddEditReminderResponseData({
    this.reminderType,
    this.family,
    this.dateTime,
    this.description,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  String reminderType;
  String family;
  DateTime dateTime;
  String description;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;
  String id;

  factory AddEditReminderResponseData.fromJson(Map<String, dynamic> json) => AddEditReminderResponseData(
    reminderType: json["reminder_type"] == null ? null : json["reminder_type"],
    family: json["family"] == null ? null : json["family"],
    dateTime: json["date_time"] == null ? null : DateTime.parse(json["date_time"]).toLocal(),
    description: json["description"] == null ? null : json["description"],
    userId: json["user_id"] == null ? null : json["user_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]).toLocal(),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]).toLocal(),
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "reminder_type": reminderType == null ? null : reminderType,
    "family": family == null ? null : family,
    "date_time": dateTime == null ? null : dateTime.toIso8601String(),
    "description": description == null ? null : description,
    "user_id": userId == null ? null : userId,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "id": id == null ? null : id,
  };
}

class GetReminderResponse {
  GetReminderResponse({
    this.success,
    this.data,
  });

  bool success;
  GetReminderResponseData data;

  factory GetReminderResponse.fromJson(Map<String, dynamic> json) => GetReminderResponse(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : GetReminderResponseData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data.toJson(),
  };
}

class GetReminderResponseData {
  GetReminderResponseData({
    this.id,
    this.reminderType,
    this.familyObject,
    this.description,
    this.dateTime,
    this.userId,
  });

  String id;
  String reminderType;
  GetReminderResponseFamilyObject familyObject;
  String description;
  DateTime dateTime;
  String userId;

  factory GetReminderResponseData.fromJson(Map<String, dynamic> json) => GetReminderResponseData(
    id: json["_id"] == null ? null : json["_id"],
    reminderType: json["reminder_type"] == null ? null : json["reminder_type"],
    familyObject: json["familyObject"] == null ? null : GetReminderResponseFamilyObject.fromJson(json["familyObject"]),
    description: json["description"] == null ? null : json["description"],
    dateTime: json["date_time"] == null ? null : DateTime.parse(json["date_time"]).toLocal(),
    userId: json["user_id"] == null ? null : json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "reminder_type": reminderType == null ? null : reminderType,
    "familyObject": familyObject == null ? null : familyObject.toJson(),
    "description": description == null ? null : description,
    "date_time": dateTime == null ? null : dateTime.toIso8601String(),
    "user_id": userId == null ? null : userId,
  };
}

class GetReminderResponseFamilyObject {
  GetReminderResponseFamilyObject({
    this.name,
    this.relationship,
    this.age,
    this.avatar,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  String name;
  String relationship;
  int age;
  String avatar;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;
  String id;

  factory GetReminderResponseFamilyObject.fromJson(Map<String, dynamic> json) => GetReminderResponseFamilyObject(
    name: json["name"] == null ? null : json["name"],
    relationship: json["relationship"] == null ? null : json["relationship"],
    age: json["age"] == null ? null : json["age"],
    avatar: json["avatar"] == null ? null : json["avatar"],
    userId: json["user_id"] == null ? null : json["user_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]).toLocal(),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]).toLocal(),
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "relationship": relationship == null ? null : relationship,
    "age": age == null ? null : age,
    "avatar": avatar == null ? null : avatar,
    "user_id": userId == null ? null : userId,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "id": id == null ? null : id,
  };
}

class GetReminderListResponse {
  GetReminderListResponse({
    this.success,
    this.data,
  });

  bool success;
  List<GetReminderListResponseDatum> data;

  factory GetReminderListResponse.fromJson(Map<String, dynamic> json) => GetReminderListResponse(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : List<GetReminderListResponseDatum>.from(json["data"].map((x) => GetReminderListResponseDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetReminderListResponseDatum {
  GetReminderListResponseDatum({
    this.id,
    this.reminderType,
    this.dateTime,
    this.description,
    this.familyObject,
    this.userId,
    this.check
  });

  String id;
  String reminderType;
  DateTime dateTime;
  String description;
  GetReminderListResponseFamilyObject familyObject;
  String userId;
  bool check;

  factory GetReminderListResponseDatum.fromJson(Map<String, dynamic> json) => GetReminderListResponseDatum(
    id: json["_id"] == null ? null : json["_id"],
    reminderType: json["reminder_type"] == null ? null : json["reminder_type"],
    dateTime: json["date_time"] == null ? null : DateTime.parse(json["date_time"]).toLocal(),
    description: json["description"] == null ? null : json["description"],
    familyObject: json["familyObject"] == null ? null : GetReminderListResponseFamilyObject.fromJson(json["familyObject"]),
    userId: json["user_id"] == null ? null : json["user_id"],
    check: json["check"] == null ? null : json["check"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "reminder_type": reminderType == null ? null : reminderType,
    "date_time": dateTime == null ? null : dateTime.toIso8601String(),
    "description": description == null ? null : description,
    "familyObject": familyObject == null ? null : familyObject.toJson(),
    "user_id": userId == null ? null : userId,
  };
}

class GetReminderListResponseFamilyObject {
  GetReminderListResponseFamilyObject({
    this.name,
    this.relationship,
    this.age,
    this.avatar,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  String name;
  String relationship;
  int age;
  String avatar;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;
  String id;

  factory GetReminderListResponseFamilyObject.fromJson(Map<String, dynamic> json) => GetReminderListResponseFamilyObject(
    name: json["name"] == null ? null : json["name"],
    relationship: json["relationship"] == null ? null : json["relationship"],
    age: json["age"] == null ? null : json["age"],
    avatar: json["avatar"] == null ? null : json["avatar"],
    userId: json["user_id"] == null ? null : json["user_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]).toLocal(),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]).toLocal(),
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "relationship": relationship == null ? null : relationship,
    "age": age == null ? null : age,
    "avatar": avatar == null ? null : avatar,
    "user_id": userId == null ? null : userId,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "id": id == null ? null : id,
  };
}

class GetDocumentsFamilyResponse {
  GetDocumentsFamilyResponse({
    this.success,
    this.data,
  });

  bool success;
  GetDocumentsFamilyResponseData data;

  factory GetDocumentsFamilyResponse.fromJson(Map<String, dynamic> json) => GetDocumentsFamilyResponse(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : GetDocumentsFamilyResponseData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data.toJson(),
  };
}

class GetDocumentsFamilyResponseData {
  GetDocumentsFamilyResponseData({
    this.bill,
    this.report,
    this.prescription,
  });

  List<GetDocumentsFamilyResponseBill> bill;
  List<GetDocumentsFamilyResponseBill> report;
  List<GetDocumentsFamilyResponsePrescription> prescription;

  factory GetDocumentsFamilyResponseData.fromJson(Map<String, dynamic> json) => GetDocumentsFamilyResponseData(
    bill: json["bill"] == null ? [] : List<GetDocumentsFamilyResponseBill>.from(json["bill"].map((x) => GetDocumentsFamilyResponseBill.fromJson(x))),
    report: json["report"] == null ? [] : List<GetDocumentsFamilyResponseBill>.from(json["report"].map((x) => GetDocumentsFamilyResponseBill.fromJson(x))),
    prescription: json["prescription"] == null ? [] : List<GetDocumentsFamilyResponsePrescription>.from(json["prescription"].map((x) => GetDocumentsFamilyResponsePrescription.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "bill": bill == null ? null : List<dynamic>.from(bill.map((x) => x.toJson())),
    "report": report == null ? null : List<dynamic>.from(report.map((x) => x.toJson())),
    "prescription": prescription == null ? null : List<dynamic>.from(prescription.map((x) => x.toJson())),
  };
}

class GetDocumentsFamilyResponseBill {
  GetDocumentsFamilyResponseBill({
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
  int amount;
  DateTime date;
  String description;
  List<ImageListRequest> billImage;
  GetDocumentsFamilyResponsePatient patient;
  String userId;
  List<ImageListRequest> reportImage;

  factory GetDocumentsFamilyResponseBill.fromJson(Map<String, dynamic> json) => GetDocumentsFamilyResponseBill(
    id: json["_id"] == null ? null : json["_id"],
    name: json["name"] == null ? null : json["name"],
    amount: json["amount"] == null ? null : json["amount"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]).toLocal(),
    description: json["description"] == null ? null : json["description"],
    billImage: json["bill_image"] == null ? null : List<ImageListRequest>.from(json["bill_image"].map((x) => ImageListRequest.fromJson(x))),
    patient: json["patient"] == null ? null : GetDocumentsFamilyResponsePatient.fromJson(json["patient"]),
    userId: json["user_id"] == null ? null : json["user_id"],
    reportImage: json["report_image"] == null ? null : List<ImageListRequest>.from(json["report_image"].map((x) => ImageListRequest.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "name": name == null ? null : name,
    "amount": amount == null ? null : amount,
    "date": date == null ? null : date.toUtc().toIso8601String(),
    "description": description == null ? null : description,
    "bill_image": billImage == null ? null : List<dynamic>.from(billImage.map((x) => x.toJson())),
    "patient": patient == null ? null : patient.toJson(),
    "user_id": userId == null ? null : userId,
    "report_image": reportImage == null ? null : List<dynamic>.from(reportImage.map((x) => x.toJson())),
  };
}

class GetDocumentsFamilyResponsePatient {
  GetDocumentsFamilyResponsePatient({
    this.name,
    this.relationship,
    this.age,
    this.avatar,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  String name;
  String relationship;
  int age;
  String avatar;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;
  String id;

  factory GetDocumentsFamilyResponsePatient.fromJson(Map<String, dynamic> json) => GetDocumentsFamilyResponsePatient(
    name: json["name"] == null ? null : json["name"],
    relationship: json["relationship"] == null ? null : json["relationship"],
    age: json["age"] == null ? null : json["age"],
    avatar: json["avatar"] == null ? null : json["avatar"],
    userId: json["user_id"] == null ? null : json["user_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]).toLocal(),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]).toLocal(),
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "relationship": relationship == null ? null : relationship,
    "age": age == null ? null : age,
    "avatar": avatar == null ? null : avatar,
    "user_id": userId == null ? null : userId,
    "createdAt": createdAt == null ? null : createdAt.toUtc().toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toUtc().toIso8601String(),
    "id": id == null ? null : id,
  };
}

class GetDocumentsFamilyResponsePrescription {
  GetDocumentsFamilyResponsePrescription({
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
  List<ImageListRequest> prescriptionImage;
  GetDocumentsFamilyResponsePatient patient;
  String userId;

  factory GetDocumentsFamilyResponsePrescription.fromJson(Map<String, dynamic> json) => GetDocumentsFamilyResponsePrescription(
    id: json["_id"] == null ? null : json["_id"],
    doctorName: json["doctor_name"] == null ? null : json["doctor_name"],
    clinicName: json["clinic_name"] == null ? null : json["clinic_name"],
    userAilment: json["user_ailment"] == null ? null : json["user_ailment"],
    consultationDate: json["consultation_date"] == null ? null : DateTime.parse(json["consultation_date"]).toLocal(),
    doctorAdvice: json["doctor_advice"] == null ? null : json["doctor_advice"],
    prescriptionImage: json["prescription_image"] == null ? null : List<ImageListRequest>.from(json["prescription_image"].map((x) => ImageListRequest.fromJson(x))),
    patient: json["patient"] == null ? null : GetDocumentsFamilyResponsePatient.fromJson(json["patient"]),
    userId: json["user_id"] == null ? null : json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "doctor_name": doctorName == null ? null : doctorName,
    "clinic_name": clinicName == null ? null : clinicName,
    "user_ailment": userAilment == null ? null : userAilment,
    "consultation_date": consultationDate == null ? null : consultationDate.toUtc().toIso8601String(),
    "doctor_advice": doctorAdvice == null ? null : doctorAdvice,
    "prescription_image": prescriptionImage == null ? null : List<dynamic>.from(prescriptionImage.map((x) => x.toJson())),
    "patient": patient == null ? null : patient.toJson(),
    "user_id": userId == null ? null : userId,
  };
}

class GetDocumentsFamilyResponseCommonObject {
  GetDocumentsFamilyResponseCommonObject({
    this.id,
    this.name,
    this.amount,
    this.date,
    this.description,
    this.images,
    this.patient,
    this.userId,
    this.relationship,
    this.age,
    this.avatar,
    this.createdAt,
    this.updatedAt,
    this.doctorName,
    this.clinicName,
    this.userAilment,
    this.consultationDate,
    this.doctorAdvice,
    this.type
  });

  String id;
  String name;
  int amount;
  DateTime date;
  String description;
  List<ImageListRequest> images;
  GetDocumentsFamilyResponsePatient patient;
  String userId;
  String relationship;
  int age;
  String avatar;
  DateTime createdAt;
  DateTime updatedAt;
  String doctorName;
  String clinicName;
  String userAilment;
  DateTime consultationDate;
  String doctorAdvice;
  String type;
}

class GetHealthScoreResponse {
  GetHealthScoreResponse({
    this.success,
    this.data,
  });

  bool success;
  GetHealthScoreResponseData data;

  factory GetHealthScoreResponse.fromJson(Map<String, dynamic> json) => GetHealthScoreResponse(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : GetHealthScoreResponseData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data.toJson(),
  };
}

class GetHealthScoreResponseData {
  GetHealthScoreResponseData({
    this.score,
  });

  double score;

  factory GetHealthScoreResponseData.fromJson(Map<String, dynamic> json) => GetHealthScoreResponseData(
    score: json["score"] == null ? null : json["score"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "score": score == null ? null : score,
  };
}

class WaterCheckResponse {
  WaterCheckResponse({
    this.success,
    this.data,
  });

  bool success;
  WaterCheckResponseData data;

  factory WaterCheckResponse.fromJson(Map<String, dynamic> json) => WaterCheckResponse(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : WaterCheckResponseData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data.toJson(),
  };
}

class WaterCheckResponseData {
  WaterCheckResponseData({
    this.targetAmount,
    this.dailyWaterConsumed,
    this.date,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  int targetAmount;
  int dailyWaterConsumed;
  DateTime date;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;
  String id;

  factory WaterCheckResponseData.fromJson(Map<String, dynamic> json) => WaterCheckResponseData(
    targetAmount: json["target_amount"] == null ? null : json["target_amount"],
    dailyWaterConsumed: json["daily_water_consumed"] == null ? null : json["daily_water_consumed"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    userId: json["user_id"] == null ? null : json["user_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "target_amount": targetAmount == null ? null : targetAmount,
    "daily_water_consumed": dailyWaterConsumed == null ? null : dailyWaterConsumed,
    "date": date == null ? null : date.toIso8601String(),
    "user_id": userId == null ? null : userId,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "id": id == null ? null : id,
  };
}

class MedicineCheckUncheckResponse {
  MedicineCheckUncheckResponse({
    this.success,
    this.data,
  });

  bool success;
  MedicineCheckUncheckResponseData data;

  factory MedicineCheckUncheckResponse.fromJson(Map<String, dynamic> json) => MedicineCheckUncheckResponse(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : MedicineCheckUncheckResponseData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data.toJson(),
  };
}

class MedicineCheckUncheckResponseData {
  MedicineCheckUncheckResponseData({
    this.check,
    this.medicineTime,
    this.userId,
    this.medicineId,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  bool check;
  DateTime medicineTime;
  String userId;
  String medicineId;
  DateTime createdAt;
  DateTime updatedAt;
  String id;

  factory MedicineCheckUncheckResponseData.fromJson(Map<String, dynamic> json) => MedicineCheckUncheckResponseData(
    check: json["check"] == null ? null : json["check"],
    medicineTime: json["medicine_time"] == null ? null : DateTime.parse(json["medicine_time"]),
    userId: json["user_id"] == null ? null : json["user_id"],
    medicineId: json["medicine_id"] == null ? null : json["medicine_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "check": check == null ? null : check,
    "medicine_time": medicineTime == null ? null : medicineTime.toIso8601String(),
    "user_id": userId == null ? null : userId,
    "medicine_id": medicineId == null ? null : medicineId,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "id": id == null ? null : id,
  };
}
