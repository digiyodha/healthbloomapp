class DeleteInsuranceRequest {
  DeleteInsuranceRequest({
    this.id,
  });

  String id;

  factory DeleteInsuranceRequest.fromJson(Map<String, dynamic> json) =>
      DeleteInsuranceRequest(
        id: json["_id"] == null ? null : json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
      };
}
