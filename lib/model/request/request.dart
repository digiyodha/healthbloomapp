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
  List<ImageListRequest> billImage;
  String patient;

  factory AddBillRequest.fromJson(Map<String, dynamic> json) => AddBillRequest(
        name: json["name"] == null ? null : json["name"],
        amount: json["amount"] == null ? null : json["amount"].toDouble(),
        date: json["date"] == null ? null : DateTime.parse(json["date"]).toLocal(),
        description: json["description"] == null ? null : json["description"],
        billImage: json["bill_image"] == null ? null : List<ImageListRequest>.from(json["bill_image"].map((x) => ImageListRequest.fromJson(x))),
        patient: json["patient"] == null ? null : json["patient"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "amount": amount == null ? null : amount,
        "date": date == null
            ? null
            : date.toUtc().toIso8601String(),
        "description": description == null ? null : description,
        "bill_image": billImage == null ? null : List<dynamic>.from(billImage.map((x) => x.toJson())),
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
    dateTime: json["date_time"] == null ? null : DateTime.parse(json["date_time"]).toLocal(),
    description: json["description"] == null ? null : json["description"],
    family: json["family"] == null ? null : json["family"],
  );

  Map<String, dynamic> toJson() => {
    "reminder_type": reminderType == null ? null : reminderType,
    "date_time": dateTime == null ? null : dateTime.toUtc().toIso8601String(),
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
    dateTime: json["date_time"] == null ? null : DateTime.parse(json["date_time"]).toLocal(),
    description: json["description"] == null ? null : json["description"],
    family: json["family"] == null ? null : json["family"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "reminder_type": reminderType == null ? null : reminderType,
    "date_time": dateTime == null ? null : dateTime.toUtc().toIso8601String(),
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

class PlacesNextPageRequest {
  PlacesNextPageRequest({
    this.nextPageToken,
  });

  String nextPageToken;

  factory PlacesNextPageRequest.fromJson(Map<String, dynamic> json) => PlacesNextPageRequest(
    nextPageToken: json["next_page_token"] == null ? null : json["next_page_token"],
  );

  Map<String, dynamic> toJson() => {
    "next_page_token": nextPageToken == null ? null : nextPageToken,
  };
}

class GetDocumentsFamilyRequest {
  GetDocumentsFamilyRequest({
    this.fromDate,
    this.toDate,
    this.patient,
  });

  DateTime fromDate;
  DateTime toDate;
  String patient;

  factory GetDocumentsFamilyRequest.fromJson(Map<String, dynamic> json) => GetDocumentsFamilyRequest(
    fromDate: json["from_date"] == null ? null : DateTime.parse(json["from_date"]).toLocal(),
    toDate: json["to_date"] == null ? null : DateTime.parse(json["to_date"]).toLocal(),
    patient: json["patient"] == null ? null : json["patient"],
  );

  Map<String, dynamic> toJson() => {
    "from_date": fromDate == null ? "" : fromDate.toUtc().toIso8601String(),
    "to_date": toDate == null ? "" : toDate.toUtc().toIso8601String(),
    "patient": patient == null ? null : patient,
  };
}

class ImageListRequest {
  ImageListRequest({
    this.assetUrl,
    this.assetSize,
    this.assetName,
    this.assetType,
    this.thumbnailUrl,
  });

  String assetUrl;
  int assetSize;
  String assetName;
  String assetType;
  String thumbnailUrl;

  factory ImageListRequest.fromJson(Map<String, dynamic> json) => ImageListRequest(
    assetUrl: json["asset_url"] == null ? null : json["asset_url"],
    assetSize: json["asset_size"] == null ? null : json["asset_size"],
    assetName: json["asset_name"] == null ? null : json["asset_name"],
    assetType: json["asset_type"] == null ? null : json["asset_type"],
    thumbnailUrl: json["thumbnail_url"] == null ? null : json["thumbnail_url"],
  );

  Map<String, dynamic> toJson() => {
    "asset_url": assetUrl == null ? null : assetUrl,
    "asset_size": assetSize == null ? null : assetSize,
    "asset_name": assetName == null ? null : assetName,
    "asset_type": assetType == null ? null : assetType,
    "thumbnail_url": thumbnailUrl == null ? null : thumbnailUrl,
  };
}
