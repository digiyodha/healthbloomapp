class DeleteMedicineResponse {
  DeleteMedicineResponse({
    this.success,
    this.data,
  });

  bool success;
  DeleteMedicineResponseData data;

  factory DeleteMedicineResponse.fromJson(Map<String, dynamic> json) =>
      DeleteMedicineResponse(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : DeleteMedicineResponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null ? null : data.toJson(),
      };
}

class DeleteMedicineResponseData {
  DeleteMedicineResponseData({
    this.reminderTime,
    this.alarmTimer,
    this.time,
    this.medicineName,
    this.amount,
    this.dosage,
    this.doses,
    this.duration,
    this.startDate,
    this.patient,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.id,
    this.description,
  });

  String reminderTime;
  bool alarmTimer;
  List<DateTime> time;
  String medicineName;
  int amount;
  String dosage;
  String doses;
  String duration;
  DateTime startDate;
  String patient;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;
  String id;
  String description;

  factory DeleteMedicineResponseData.fromJson(Map<String, dynamic> json) =>
      DeleteMedicineResponseData(
        reminderTime:
            json["reminder_time"] == null ? null : json["reminder_time"],
        alarmTimer: json["alarm_timer"] == null ? null : json["alarm_timer"],
        time: json["time"] == null
            ? null
            : List<DateTime>.from(json["time"].map((x) => DateTime.parse(x))),
        medicineName:
            json["medicine_name"] == null ? null : json["medicine_name"],
        amount: json["amount"] == null ? null : json["amount"],
        dosage: json["dosage"] == null ? null : json["dosage"],
        doses: json["doses"] == null ? null : json["doses"],
        duration: json["duration"] == null ? null : json["duration"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        patient: json["patient"] == null ? null : json["patient"],
        userId: json["user_id"] == null ? null : json["user_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        id: json["id"] == null ? null : json["id"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "reminder_time": reminderTime == null ? null : reminderTime,
        "alarm_timer": alarmTimer == null ? null : alarmTimer,
        "time": time == null
            ? null
            : List<dynamic>.from(time.map((x) => x.toIso8601String())),
        "medicine_name": medicineName == null ? null : medicineName,
        "amount": amount == null ? null : amount,
        "dosage": dosage == null ? null : dosage,
        "doses": doses == null ? null : doses,
        "duration": duration == null ? null : duration,
        "start_date": startDate == null ? null : startDate.toIso8601String(),
        "patient": patient == null ? null : patient,
        "user_id": userId == null ? null : userId,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "id": id == null ? null : id,
        "description": description == null ? null : description,
      };
}
