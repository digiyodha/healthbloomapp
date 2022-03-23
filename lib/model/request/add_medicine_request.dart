class AddMedicineRequest {
  AddMedicineRequest({
    this.description,
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
  String description;
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

  factory AddMedicineRequest.fromJson(Map<String, dynamic> json) =>
      AddMedicineRequest(
        description: json["description"] == null ? null : json["description"],
        medicineName:
            json["medicine_name"] == null ? null : json["medicine_name"],
        amount: json["amount"] == null ? null : json["amount"],
        dosage: json["dosage"] == null ? null : json["dosage"],
        doses: json["doses"] == null ? null : json["doses"],
        duration: json["duration"] == null ? null : json["duration"],
        time: json["time"] == null
            ? null
            : List<DateTime>.from(json["time"].map((x) => DateTime.parse(x).toLocal())),
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]).toLocal(),
        reminderTime:
            json["reminder_time"] == null ? null : json["reminder_time"],
        alarmTimer: json["alarm_timer"] == null ? null : json["alarm_timer"],
        patient: json["patient"] == null ? null : json["patient"],
      );

  Map<String, dynamic> toJson() => {
        "description": description == null ? null : description,
        "medicine_name": medicineName == null ? null : medicineName,
        "amount": amount == null ? null : amount,
        "dosage": dosage == null ? null : dosage,
        "doses": doses == null ? null : doses,
        "duration": duration == null ? null : duration,
        "time": time == null
            ? null
            : List<dynamic>.from(time.map((x) => x.toUtc().toIso8601String())),
        "start_date": startDate == null
            ? null
            : startDate.toUtc().toIso8601String(),
        "reminder_time": reminderTime == null ? null : reminderTime,
        "alarm_timer": alarmTimer == null ? null : alarmTimer,
        "patient": patient == null ? null : patient,
      };
}
