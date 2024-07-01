class LabtestModel {
  String productname;
  String description;
  String mrp;
  String offer;
  String price;
  String category;
  String? id;
  String storeId;

  LabtestModel({
    required this.storeId,
    required this.category,
    required this.productname,
    required this.description,
    required this.mrp,
    required this.offer,
    required this.price,
    
    this.id,
  });


  Map<String, dynamic> toMap(ids) => {
    "category":category,
    "storeId":storeId,
        "productname": productname,
        "description": description,
        "id": ids,
        "mrp": mrp,
        "offer":offer,
        "price":price,
        
      };

  factory LabtestModel.fromMap(Map<String, dynamic> data) {
    return LabtestModel(
      storeId:data["storeId"],
      category:data["category"],
      productname: data["productname"],
      description: data["description"],
      mrp: data["mrp"],
      offer: data["offer"],
      price: data["price"],
     
      id: data["id"],
    );
  }
}