class MedicineModel {
  String? medId;
  String medName;
  String description;
  double price;
  double mrp;
  String offer;
  String imageUrl;
  String storeID;

  MedicineModel(
      {required this.description,
      required this.imageUrl,
      required this.storeID,
       this.medId,
      required this.medName,
      required this.mrp,
      required this.offer,
      required this.price});

  Map<String, dynamic> toJson(id) => {
        "medId":id   ,
        "storeID":storeID,
        "medName": medName,
        "description": description,
        "price": price,
        "mrp": mrp,
        "offer": offer,
        "imageUrl": imageUrl
      };

  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(
      storeID:json["storeID"],
        description: json["description"],
        imageUrl: json["imageUrl"],
        medId: json["medId"],
        medName: json["medName"],
        mrp: json["mrp"],
        offer: json["offer"],
        price: json["price"]);
  }
}
