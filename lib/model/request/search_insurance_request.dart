class SearchInsuranceRequest {
  SearchInsuranceRequest({
    this.name,
  });

  String name;

  factory SearchInsuranceRequest.fromJson(Map<String, dynamic> json) =>
      SearchInsuranceRequest(
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
      };
}
