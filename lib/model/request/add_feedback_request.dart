class AddFeedbackRequest {
  AddFeedbackRequest({
    this.experience,
    this.description,
    this.feedbackOptions,
  });

  String experience;
  String description;
  List<String> feedbackOptions;

  factory AddFeedbackRequest.fromJson(Map<String, dynamic> json) =>
      AddFeedbackRequest(
        experience: json["experience"] == null ? null : json["experience"],
        description: json["description"] == null ? null : json["description"],
        feedbackOptions: json["feedback_options"] == null
            ? null
            : List<String>.from(json["feedback_options"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "experience": experience == null ? null : experience,
        "description": description == null ? null : description,
        "feedback_options": feedbackOptions == null
            ? null
            : List<dynamic>.from(feedbackOptions.map((x) => x)),
      };
}
