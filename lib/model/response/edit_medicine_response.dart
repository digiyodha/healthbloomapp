class EditMedicineResponse {
  EditMedicineResponse({
    this.success,
    this.data,
  });

  bool success;
  EditMedicineResponseData data;

  factory EditMedicineResponse.fromJson(Map<String, dynamic> json) =>
      EditMedicineResponse(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : EditMedicineResponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null ? null : data.toJson(),
      };
}

class EditMedicineResponseData {
  EditMedicineResponseData(
      {this.time,
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
      this.description});

  List<DateTime> time;
  String reminderTime;
  bool alarmTimer;
  String medicineName;
  int amount;
  String dosage;
  String doses;
  String duration;
  DateTime startDate;
  String patient;
  String userId;
  String id;
  String description;

  factory EditMedicineResponseData.fromJson(Map<String, dynamic> json) =>
      EditMedicineResponseData(
        time: json["time"] == null
            ? null
            : List<DateTime>.from(json["time"].map((x) => DateTime.parse(x).toLocal())),
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
            : DateTime.parse(json["start_date"]).toLocal(),
        patient: json["patient"] == null ? null : json["patient"],
        userId: json["user_id"] == null ? null : json["user_id"],
        id: json["id"] == null ? null : json["id"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "time": time == null
            ? null
            : List<dynamic>.from(time.map((x) => x.toIso8601String())),
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
        "description": description == null ? null : description,
      };
}
