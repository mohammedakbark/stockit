// //collection
// class Medicinemodel {
//   String productname;
//   String description;
//   String mrp;
//   String offer;
//   String price;
//   String? imageUrl;
//   String? id;

//   Medicinemodel({
//     required this.productname,
//     required this.description,
//     required this.mrp,
//     required this.offer,
//     required this.price,
//     this.imageUrl,
//     this.id,
//   });


//   Map<String, dynamic> toMap() => {
//         "productname": productname,
//         "description": description,
//         "id": id,
//         "mrp": mrp,
//         "offer":offer,
//         "price":price,
//         "imageUrl": imageUrl,
//       };

//   factory Medicinemodel.fromMap(Map<String, dynamic> data) {
//     return Medicinemodel(
//       productname: data["productname"],
//       description: data["description"],
//       mrp: data["mrp"],
//       offer: data["offer"],
//       price: data["price"],
//       imageUrl: data["imageUrl"],
//       id: data["id"],
//     );
//   }
// }