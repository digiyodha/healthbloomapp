class AddBillRequest {
  AddBillRequest({
    this.name,
    this.amount,
    this.date,
    this.description,
    this.billImage,
    this.patient,
  });

  String name;
  double amount;
  DateTime date;
  String description;
  List<String> billImage;
  String patient;

  factory AddBillRequest.fromJson(Map<String, dynamic> json) => AddBillRequest(
        name: json["name"] == null ? null : json["name"],
        amount: json["amount"] == null ? null : json["amount"].toDouble(),
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        description: json["description"] == null ? null : json["description"],
        billImage: json["bill_image"] == null
            ? null
            : List<String>.from(json["bill_image"].map((x) => x)),
        patient: json["patient"] == null ? null : json["patient"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "amount": amount == null ? null : amount,
        "date": date == null
            ? null
            : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "description": description == null ? null : description,
        "bill_image": billImage == null
            ? null
            : List<dynamic>.from(billImage.map((x) => x)),
        "patient": patient == null ? null : patient,
      };
}

class DeleteDocumentRequest {
  DeleteDocumentRequest({
    this.id,
  });

  String id;

  factory DeleteDocumentRequest.fromJson(Map<String, dynamic> json) =>
      DeleteDocumentRequest(
        id: json["_id"] == null ? null : json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
      };
}

class RegisterLoginRequest {
  RegisterLoginRequest({
    this.name,
    this.emailId,
    this.uid,
    this.avatar,
    this.phoneNumber,
    this.countryCode,
    this.fcmToken
  });

  String name;
  String emailId;
  String uid;
  String avatar;
  dynamic phoneNumber;
  String countryCode;
  String fcmToken;

  factory RegisterLoginRequest.fromJson(Map<String, dynamic> json) =>
      RegisterLoginRequest(
        name: json["name"] == null ? null : json["name"],
        emailId: json["email_id"] == null ? null : json["email_id"],
        uid: json["uid"] == null ? null : json["uid"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        phoneNumber: json["phone_number"],
        countryCode: json["country_code"] == null ? null : json["country_code"],
        fcmToken: json["fcm_token"]
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "email_id": emailId == null ? null : emailId,
        "uid": uid == null ? null : uid,
        "avatar": avatar == null ? null : avatar,
        "phone_number": phoneNumber,
        "country_code": countryCode == null ? null : countryCode,
        "fcm_token" : fcmToken
      };
}


class MapsNearbyMedicalsRequest {
  MapsNearbyMedicalsRequest({
    this.hours,
    this.distance,
    this.latitude,
    this.longitude,
    this.rating,
  });

  String hours;
  String distance;
  String latitude;
  String longitude;
  String rating;

  factory MapsNearbyMedicalsRequest.fromJson(Map<String, dynamic> json) => MapsNearbyMedicalsRequest(
    hours: json["hours"] == null ? null : json["hours"],
    distance: json["distance"] == null ? null : json["distance"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    rating: json["rating"] == null ? null : json["rating"],
  );

  Map<String, dynamic> toJson() => {
    "hours": hours == null ? null : hours,
    "distance": distance == null ? null : distance,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "rating": rating == null ? null : rating,
  };
}

class MapsPlaceDetailsRequest {
  MapsPlaceDetailsRequest({
    this.placeId,
  });

  String placeId;

  factory MapsPlaceDetailsRequest.fromJson(Map<String, dynamic> json) => MapsPlaceDetailsRequest(
    placeId: json["place_id"] == null ? null : json["place_id"],
  );

  Map<String, dynamic> toJson() => {
    "place_id": placeId == null ? null : placeId,
  };
}

class AddReminderRequest {
  AddReminderRequest({
    this.reminderType,
    this.dateTime,
    this.description,
    this.family,
  });

  String reminderType;
  DateTime dateTime;
  String description;
  String family;

  factory AddReminderRequest.fromJson(Map<String, dynamic> json) => AddReminderRequest(
    reminderType: json["reminder_type"] == null ? null : json["reminder_type"],
    dateTime: json["date_time"] == null ? null : DateTime.parse(json["date_time"]),
    description: json["description"] == null ? null : json["description"],
    family: json["family"] == null ? null : json["family"],
  );

  Map<String, dynamic> toJson() => {
    "reminder_type": reminderType == null ? null : reminderType,
    "date_time": dateTime == null ? null : dateTime.toIso8601String(),
    "description": description == null ? null : description,
    "family": family == null ? null : family,
  };
}

class EditReminderRequest {
  EditReminderRequest({
    this.id,
    this.reminderType,
    this.dateTime,
    this.description,
    this.family,
  });

  String id;
  String reminderType;
  DateTime dateTime;
  String description;
  String family;

  factory EditReminderRequest.fromJson(Map<String, dynamic> json) => EditReminderRequest(
    id: json["_id"] == null ? null : json["_id"],
    reminderType: json["reminder_type"] == null ? null : json["reminder_type"],
    dateTime: json["date_time"] == null ? null : DateTime.parse(json["date_time"]),
    description: json["description"] == null ? null : json["description"],
    family: json["family"] == null ? null : json["family"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "reminder_type": reminderType == null ? null : reminderType,
    "date_time": dateTime == null ? null : dateTime.toIso8601String(),
    "description": description == null ? null : description,
    "family": family == null ? null : family,
  };
}

class DeleteReminderRequest {
  DeleteReminderRequest({
    this.id,
  });

  String id;

  factory DeleteReminderRequest.fromJson(Map<String, dynamic> json) => DeleteReminderRequest(
    id: json["_id"] == null ? null : json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
  };
}

class GetFamilyReminderRequest {
  GetFamilyReminderRequest({
    this.family,
  });

  String family;

  factory GetFamilyReminderRequest.fromJson(Map<String, dynamic> json) => GetFamilyReminderRequest(
    family: json["family"] == null ? null : json["family"],
  );

  Map<String, dynamic> toJson() => {
    "family": family == null ? null : family,
  };
}

class GetReminderRequest {
  GetReminderRequest({
    this.id,
  });

  String id;

  factory GetReminderRequest.fromJson(Map<String, dynamic> json) => GetReminderRequest(
    id: json["_id"] == null ? null : json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
  };
}
