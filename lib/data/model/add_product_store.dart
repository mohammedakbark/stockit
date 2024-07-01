class StoreProductModel {
  String? productId;
  String storeId;
  String productName;
  int qty;
  String price;
  String category;
  String imageUrl;
  String isItSpecial;
  StoreProductModel(
      {required this.category,
      
      required this.imageUrl,
      required this.price,
       this.productId,
       required this.isItSpecial,
      required this.productName,
      required this.qty,
      required this.storeId});
  Map<String, dynamic> tojson(id) => {
        "productId": id,
        "storeId": storeId,
        "productName": productName,
        "qty": qty,
        "price": price,
        "category": category,
        "imageUrl":imageUrl,
        "isItSpecial":isItSpecial
      };
factory StoreProductModel.fromJson(Map<String, dynamic> json) {
    return StoreProductModel(
      imageUrl:json["imageUrl"],
      isItSpecial:json["isItSpecial"],
        category: json["category"],
        price: json["price"],
        productId: json["productId"],
        productName: json["productName"],
        qty: json["qty"],
        storeId: json["storeId"]);
  }
}
