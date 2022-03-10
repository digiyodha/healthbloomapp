class EditMedicineRequest {
  EditMedicineRequest({
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
  String patient;

  factory EditMedicineRequest.fromJson(Map<String, dynamic> json) =>
      EditMedicineRequest(
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
        patient: json["patient"] == null ? null : json["patient"],
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
        "start_date": startDate == null
            ? null
            : "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "reminder_time": reminderTime == null ? null : reminderTime,
        "alarm_timer": alarmTimer == null ? null : alarmTimer,
        "patient": patient == null ? null : patient,
      };
}
