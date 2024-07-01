class BookingModel {
  String uid;
  String? bookingId;
  String productId;
  String typeOfOrder;
  String name;
  String gender;
  String detail;
  String age;
  String date;
  String time;
  String status;
  String storeId;

  BookingModel(
      {required this.age,
      required this.storeId,
      required this.date,
       this.bookingId,
       required this.status,
      required this.productId,
      required this.detail,
      required this.gender,
      required this.name,
      required this.time,
      required this.typeOfOrder,
      required this.uid});

  Map<String, dynamic> toJosn(id) => {
        "uid": uid,
        "storeId":storeId,
        "bookingId":id,
        "status":status,
        "productId":productId,

        "typeOfOrder": typeOfOrder,
        "name": name,
        "gender": gender,
        "detail": detail,
        "age": age,
        "date": date,
        "time": time
      };

  factory BookingModel.fromjosn(Map<String, dynamic> json) {
    return BookingModel(
      storeId:json["storeId"],
      status:json["status"],
      productId: json["productId"],
      bookingId: json["bookingId"],
        age: json["age"],
        date: json["date"],
        detail: json["detail"],
        gender: json["gender"],
        name: json["name"],
        time: json["time"],
        typeOfOrder: json["typeOfOrder"],
        uid: json["uid"]);
  }
}
