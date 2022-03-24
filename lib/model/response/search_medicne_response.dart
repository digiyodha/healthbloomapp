class SearchMedicineResponse {
  SearchMedicineResponse({
    this.success,
    this.data,
  });

  bool success;
  List<SearchMedicineResponseDatum> data;

  factory SearchMedicineResponse.fromJson(Map<String, dynamic> json) =>
      SearchMedicineResponse(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : List<SearchMedicineResponseDatum>.from(json["data"]
                .map((x) => SearchMedicineResponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SearchMedicineResponseDatum {
  SearchMedicineResponseDatum({
    this.id,
    this.medicineName,
    this.amount,
    this.dosage,
    this.doses,
    this.duration,
    this.timeObject,
    this.startDate,
    this.reminderTime,
    this.alarmTimer,
    this.patient,
    this.userId,
    this.startHour,
    this.description,
    this.totalTablets,
    this.tabletsLeft,
    this.durationLeft,
  });

  String id;
  String medicineName;
  int amount;
  String dosage;
  String doses;
  String duration;
  List<TimeObject> timeObject;
  DateTime startDate;
  String reminderTime;
  bool alarmTimer;
  Patient patient;
  String userId;
  DateTime startHour;
  String description;
  int totalTablets;
  int tabletsLeft;
  int durationLeft;

  factory SearchMedicineResponseDatum.fromJson(Map<String, dynamic> json) =>
      SearchMedicineResponseDatum(
        id: json["_id"] == null ? null : json["_id"],
        medicineName:
            json["medicine_name"] == null ? null : json["medicine_name"],
        amount: json["amount"] == null ? null : json["amount"],
        dosage: json["dosage"] == null ? null : json["dosage"],
        doses: json["doses"] == null ? null : json["doses"],
        duration: json["duration"] == null ? null : json["duration"],
        timeObject: json["timeObject"] == null
            ? null
            : List<TimeObject>.from(
                json["timeObject"].map((x) => TimeObject.fromJson(x))),
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]).toLocal(),
        reminderTime:
            json["reminder_time"] == null ? null : json["reminder_time"],
        alarmTimer: json["alarm_timer"] == null ? null : json["alarm_timer"],
        patient:
            json["patient"] == null ? null : Patient.fromJson(json["patient"]),
        userId: json["user_id"] == null ? null : json["user_id"],
        startHour: json["start_hour"] == null
            ? null
            : DateTime.parse(json["start_hour"]).toLocal(),
        description: json["description"] == null ? null : json["description"],
        totalTablets:
            json["total_tablets"] == null ? null : json["total_tablets"],
        tabletsLeft: json["tablets_left"] == null ? null : json["tablets_left"],
        durationLeft:
            json["duration_left"] == null ? null : json["duration_left"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "medicine_name": medicineName == null ? null : medicineName,
        "amount": amount == null ? null : amount,
        "dosage": dosage == null ? null : dosage,
        "doses": doses == null ? null : doses,
        "duration": duration == null ? null : duration,
        "timeObject": timeObject == null
            ? null
            : List<dynamic>.from(timeObject.map((x) => x.toJson())),
        "start_date": startDate == null ? null : startDate.toIso8601String(),
        "reminder_time": reminderTime == null ? null : reminderTime,
        "alarm_timer": alarmTimer == null ? null : alarmTimer,
        "patient": patient == null ? null : patient.toJson(),
        "user_id": userId == null ? null : userId,
        "start_hour": startHour == null ? null : startHour.toIso8601String(),
        "description": description == null ? null : description,
        "total_tablets": totalTablets == null ? null : totalTablets,
        "tablets_left": tabletsLeft == null ? null : tabletsLeft,
        "duration_left": durationLeft == null ? null : durationLeft,
      };
}

class Patient {
  Patient({
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

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        name: json["name"] == null ? null : json["name"],
        relationship:
            json["relationship"] == null ? null : json["relationship"],
        age: json["age"] == null ? null : json["age"],
        avatar: json["avatar"] == null ? null : json["avatar"],
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

class TimeObject {
  TimeObject({
    this.startTime,
    this.endTime,
    this.medicineId,
    this.isActive,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  DateTime startTime;
  DateTime endTime;
  String medicineId;
  bool isActive;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;
  String id;

  factory TimeObject.fromJson(Map<String, dynamic> json) => TimeObject(
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]).toLocal(),
        endTime:
            json["end_time"] == null ? null : DateTime.parse(json["end_time"]).toLocal(),
        medicineId: json["medicine_id"] == null ? null : json["medicine_id"],
        isActive: json["is_active"] == null ? null : json["is_active"],
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
        "start_time": startTime == null ? null : startTime.toUtc().toIso8601String(),
        "end_time": endTime == null ? null : endTime.toUtc().toIso8601String(),
        "medicine_id": medicineId == null ? null : medicineId,
        "is_active": isActive == null ? null : isActive,
        "user_id": userId == null ? null : userId,
        "createdAt": createdAt == null ? null : createdAt.toUtc().toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toUtc().toIso8601String(),
        "id": id == null ? null : id,
      };
}