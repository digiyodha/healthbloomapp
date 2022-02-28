class AddMedicineResponse {
  AddMedicineResponse({
    this.success,
    this.data,
  });

  bool success;
  AddMedicineResponseData data;

  factory AddMedicineResponse.fromJson(Map<String, dynamic> json) =>
      AddMedicineResponse(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : AddMedicineResponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null ? null : data.toJson(),
      };
}

class AddMedicineResponseData {
  AddMedicineResponseData({
    this.time,
    this.reminderTime,
    this.alarmTimer,
    this.medicineName,
    this.amount,
    this.dosage,
    this.doses,
    this.duration,
    this.startDate,
    this.patient,
    this.userId,
    this.id,
  });

  List<dynamic> time;
  String reminderTime;
  bool alarmTimer;
  String medicineName;
  int amount;
  int dosage;
  int doses;
  String duration;
  DateTime startDate;
  String patient;
  String userId;
  String id;

  factory AddMedicineResponseData.fromJson(Map<String, dynamic> json) =>
      AddMedicineResponseData(
        time: json["time"] == null
            ? null
            : List<dynamic>.from(json["time"].map((x) => x)),
        reminderTime:
            json["reminder_time"] == null ? null : json["reminder_time"],
        alarmTimer: json["alarm_timer"] == null ? null : json["alarm_timer"],
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
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "time": time == null ? null : List<dynamic>.from(time.map((x) => x)),
        "reminder_time": reminderTime == null ? null : reminderTime,
        "alarm_timer": alarmTimer == null ? null : alarmTimer,
        "medicine_name": medicineName == null ? null : medicineName,
        "amount": amount == null ? null : amount,
        "dosage": dosage == null ? null : dosage,
        "doses": doses == null ? null : doses,
        "duration": duration == null ? null : duration,
        "start_date": startDate == null ? null : startDate.toIso8601String(),
        "patient": patient == null ? null : patient,
        "user_id": userId == null ? null : userId,
        "id": id == null ? null : id,
      };
}
