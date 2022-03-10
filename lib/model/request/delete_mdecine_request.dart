class DeleteMedicineRequest {
  DeleteMedicineRequest({
    this.id,
  });

  String id;

  factory DeleteMedicineRequest.fromJson(Map<String, dynamic> json) =>
      DeleteMedicineRequest(
        id: json["_id"] == null ? null : json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
      };
}
