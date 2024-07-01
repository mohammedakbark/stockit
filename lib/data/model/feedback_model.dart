class FeedbackModel {
  String ?feedBackId;
  String email;
  String uid;
  String suggestions;

  FeedbackModel(
      {
         this.feedBackId,
        required this.email, required this.suggestions, required this.uid});

  Map<String, dynamic> toJosn(id) =>
      {
        "feedBackId":id,
        "email": email, "uid": uid, "suggestions": suggestions};

  factory FeedbackModel.fromJosn(Map<String, dynamic> json) {
    return FeedbackModel(
      feedBackId:json["feedBackId"],
        email: json["email"],
        suggestions: json["suggestions"],
        uid: json["uid"]);
  }
}
