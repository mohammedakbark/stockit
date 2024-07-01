import 'package:stockit/data/model/add_product_store.dart';

class OrderModel {
  String name;
  String cardNumber;
  String cardType;
  int numberOfMembers;
  String storeId;
  String? orderId;
  String uid;
  String orderStatus;
  List<dynamic> storeProductModel;

  OrderModel(
      {required this.orderStatus,
      required this.cardNumber,
      required this.name,required this.cardType,required this.numberOfMembers,
       this.orderId,
      required this.storeId,
      required this.storeProductModel,
      required this.uid});

  Map<String, dynamic> toJson(id) {
        final list=storeProductModel.map((e) => e.tojson(e.productId)).toList();
        return  {

        "storeId": storeId,
        'cardType':cardType,
        "numberOfMembers":numberOfMembers,
        "name":name,
        "cardNumber":cardNumber,
        "orderId":id,
        "uid": uid,
        "orderStatus": orderStatus,
        "storeProductModel": list
      };

  }

  factory OrderModel.fromJosn(Map<String, dynamic> json) {
    final list=json["storeProductModel"] as List<dynamic>;
    List<dynamic> storeProductModelList =
        list.map((i) => StoreProductModel.fromJson(i as Map<String,dynamic> )).toList();
    return OrderModel(
      name:json["name"]??"N/A",
      cardNumber:json["cardNumber"]??"N/A",
      cardType:json["cardType"]??"N/A",
      numberOfMembers:json["numberOfMembers"]??"N/A",

      orderId:json["orderId"],
        orderStatus: json["orderStatus"],
        storeId: json["storeId"],
        storeProductModel:storeProductModelList,
        uid: json["uid"]);
  }
}
