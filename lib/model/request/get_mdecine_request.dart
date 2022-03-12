class GetMedicineRequest {
  GetMedicineRequest({
    this.id,
  });

  String id;

  factory GetMedicineRequest.fromJson(Map<String, dynamic> json) =>
      GetMedicineRequest(
        id: json["_id"] == null ? null : json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
      };
}
