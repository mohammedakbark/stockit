class StoreModel {
  String storeId;
  String name;
  String imageUrl;
  String password;
  String branch;
  String pin;
  int phoneNumber;
  String storeType;
  double latitude;
  double longitude;

  StoreModel(
      {required this.branch,
      required this.latitude,required this.longitude,
      required this.imageUrl,
      required this.name,
      required this.password,
      required this.phoneNumber,
      required this.pin,
      required this.storeId,
      required this.storeType});

  Map<String, dynamic> toJson() => {
        "storeId": storeId,
        "latitude":latitude,
        "name": name,
        "imageUrl": imageUrl,
        "password": password,
        "branch": branch,
        "longitude":longitude,
        "pin": pin,
        "phoneNumber": phoneNumber,
        "storeType": storeType
      };
  factory StoreModel.fromjson(Map<String, dynamic> json) {
    return StoreModel(
      latitude:json["latitude"],
longitude: json["longitude"],
        branch: json["branch"],
        imageUrl: json["imageUrl"],
        name: json["name"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
        pin: json["pin"],
        storeId: json["storeId"],
        storeType: json["storeType"]);
  }
}
