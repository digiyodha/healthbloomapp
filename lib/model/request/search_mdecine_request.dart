class SearchMedicineRequest {
  SearchMedicineRequest({
    this.name,
  });

  String name;

  factory SearchMedicineRequest.fromJson(Map<String, dynamic> json) =>
      SearchMedicineRequest(
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
      };
}
