class NotificationModelForNethiOrder {
  String message;
  String from;
  String? notId;
  String toID;

  NotificationModelForNethiOrder(
      {required this.from,
      required this.toID,
       this.notId,
      required this.message});

  Map<String, dynamic> toJson(id) => { "message": message, "from": from,"notId":id,"toID":toID};

  factory NotificationModelForNethiOrder.fromjson(Map<String, dynamic> json) {
    return NotificationModelForNethiOrder(
      toID: json["toID"],
      notId:json["notId"],
        from: json["from"], message: json["message"]);
  }
}
