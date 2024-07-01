class NotificationModel {
  String message;
  String from;
  String? notId;

  NotificationModel(
      {required this.from,
       this.notId,
      required this.message});

  Map<String, dynamic> toJson(id) => { "message": message, "from": from,"notId":id};

  factory NotificationModel.fromjson(Map<String, dynamic> json) {
    return NotificationModel(
      notId:json["notId"],
        from: json["from"], message: json["message"]);
  }
}
