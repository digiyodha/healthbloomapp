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
    this.time,
    this.startDate,
    this.reminderTime,
    this.alarmTimer,
    this.patient,
    this.userId,
  });

  String id;
  String medicineName;
  int amount;
  String dosage;
  String doses;
  String duration;
  List<DateTime> time;
  DateTime startDate;
  String reminderTime;
  bool alarmTimer;
  Patient patient;
  String userId;

  factory SearchMedicineResponseDatum.fromJson(Map<String, dynamic> json) =>
      SearchMedicineResponseDatum(
        id: json["_id"] == null ? null : json["_id"],
        medicineName:
            json["medicine_name"] == null ? null : json["medicine_name"],
        amount: json["amount"] == null ? null : json["amount"],
        dosage: json["dosage"] == null ? null : json["dosage"],
        doses: json["doses"] == null ? null : json["doses"],
        duration: json["duration"] == null ? null : json["duration"],
        time: json["time"] == null
            ? null
            : List<DateTime>.from(json["time"].map((x) => DateTime.parse(x))),
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        reminderTime:
            json["reminder_time"] == null ? null : json["reminder_time"],
        alarmTimer: json["alarm_timer"] == null ? null : json["alarm_timer"],
        patient:
            json["patient"] == null ? null : Patient.fromJson(json["patient"]),
        userId: json["user_id"] == null ? null : json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "medicine_name": medicineName == null ? null : medicineName,
        "amount": amount == null ? null : amount,
        "dosage": dosage == null ? null : dosage,
        "doses": doses == null ? null : doses,
        "duration": duration == null ? null : duration,
        "time": time == null
            ? null
            : List<dynamic>.from(time.map((x) => x.toIso8601String())),
        "start_date": startDate == null ? null : startDate.toIso8601String(),
        "reminder_time": reminderTime == null ? null : reminderTime,
        "alarm_timer": alarmTimer == null ? null : alarmTimer,
        "patient": patient == null ? null : patient.toJson(),
        "user_id": userId == null ? null : userId,
      };
}

class Patient {
  Patient({
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

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
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
