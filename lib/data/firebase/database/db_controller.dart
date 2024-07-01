import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:stockit/data/helper/login_preference.dart';
import 'package:stockit/data/helper/service.dart';
import 'package:stockit/data/model/add_product_store.dart';
import 'package:stockit/data/model/booking_model.dart';
import 'package:stockit/data/model/feedback_model.dart';
import 'package:stockit/data/model/labtest_model.dart';
import 'package:stockit/data/model/medicine_model.dart';
import 'package:stockit/data/model/notificationFromNethioOrder.dart';
import 'package:stockit/data/model/notification_model.dart';
import 'package:stockit/data/model/order_model.dart';
import 'package:stockit/data/model/product_neethi_model.dart';
import 'package:stockit/data/model/store_model.dart';
import 'package:stockit/presentation/common/profile.dart';

class DbController with ChangeNotifier {
  static List<String> labTest = [
    "Women",
    "Cancer Screening",
    "Fever",
    "Diabeties",
    "Joint Pain",
    "Full Body Checkup",
    "Kidney",
    "Liver",
    "Lungs",
    "Heart",
    "Thyroid",
    "Bones"
  ];

  String? storeId;
  StoreModel? storeModel;
  Future getCurrentStoreData(id) async {
    storeId = id;
    final snaphot = await db.collection("Store").doc(id).get();

    if (snaphot.exists) {
      storeModel = StoreModel.fromjson(snaphot.data()!);
    }
  }

  final db = FirebaseFirestore.instance;
//----------------------------------CREATE
  Future addNewStore(StoreModel storeModel) async {
    await locationFromAddress(storeModel.branch).then((value) {
      final data = value[0];

      StoreModel model = StoreModel(
          branch: storeModel.branch,
          latitude: data.latitude,
          longitude: data.longitude,
          imageUrl: storeModel.imageUrl,
          name: storeModel.name,
          password: storeModel.password,
          phoneNumber: storeModel.phoneNumber,
          pin: storeModel.pin,
          storeId: storeModel.storeId,
          storeType: storeModel.storeType);

      db.collection("Store").doc(storeModel.storeId).set(model.toJson());
    });
  }

//-----------------------------------DELETE

  deleteAStore(id) async {
    db.collection('Store').doc(id).delete();
    // notifyListeners();
  }

//----------------------------------UPDATE

//--------------------------------READ

//.......................Authentivcation.......................
  Future<bool> checkTheStoreAlredyExistorNot(id) async {
    final snapshot = await db.collection("Store").doc(id).get();

    if (snapshot.exists) {
      log("true");
      return true;
    } else {
      log("fslse");
      return false;
    }
  }

  List<StoreModel> existingStore = [];
  checkStoreForLogin(String storeType, String storeid, String password,
      dynamic page, context) async {
    final snapshot = await db.collection('Store').doc(storeid).get();
    if (snapshot.exists) {
      if (snapshot.data()!["storeType"] == storeType) {
        if (snapshot.data()!["password"] == password &&
            snapshot.data()!["storeId"] == storeid) {
          getCurrentStoreData(storeid).then((value) {
            LoginPreference.setPreference(storeid);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => page),
                (route) => false);
          });
        } else {
          Services.errorMessage(context, "Id and Password does not match!");
        }
      } else {
        Services.errorMessage(context, "This user is not exist in this store");
      }
    } else {
      Services.errorMessage(context, "INVALID-CREDENTIAL");
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllStore(String storeType) {
    return db
        .collection("Store")
        .where('storeType', isEqualTo: storeType)
        .snapshots();
  }

  List<StoreModel> storeForSearch = [];
  getAllStoreForSearch(String storeType) async {
    final snapshot = await db
        .collection("Store")
        .where('storeType', isEqualTo: storeType)
        .get();

    storeForSearch =
        snapshot.docs.map((e) => StoreModel.fromjson(e.data())).toList();
  }

//========ration search
  List<StoreModel> storeSearchResult = [];

  searchStore(String key) {
    storeSearchResult = List.from(storeForSearch);

    storeSearchResult = storeForSearch
        .where((element) =>
            element.branch.toLowerCase().contains(key.toLowerCase()))
        .toList();
    notifyListeners();
  }

//========maveli earch

//==========supplyu search

  Future<DocumentSnapshot> getSelectedStore(id) async {
    return await db.collection("Store").doc(id).get();
  }
  //---------------------------USER USER USER......................

  getRationProductDataForOrder(storeIds, selectedCategory) {
    return db
        .collection("Ration Products")
        .where("storeId", isEqualTo: storeIds)
        .where("category", isEqualTo: selectedCategory)
        .snapshots();
  }

  getRationSpeciaProductDataForOrder(storeIds, selectedCategory) {
    return db
        .collection("Ration Products")
        .where("storeId", isEqualTo: storeId)
        .where("category", isEqualTo: selectedCategory)
        .where("isItSpecial", isEqualTo: "Special")
        .snapshots();
  }

  getMaveliAndSupplycoSpecialProductForOrder(collection, storeId) {
    return db
        .collection(collection)
        .where("storeId", isEqualTo: storeId)
        .where("isItSpecial", isEqualTo: "Special")
        .snapshots();
  }

  getMaveliAndSupplycoAllProductForOrder(collection, storeId) {
    return db
        .collection(collection)
        .where("storeId", isEqualTo: storeId)
        .snapshots();
  }

  likeMyProduct(uid, storeID, StoreModel storeModel) async {
    final doc =
        db.collection("firebase").doc(uid).collection("Fav Store").doc(storeID);

    final snapshot = await doc.get();

    if (snapshot.exists) {
      doc.delete();
    } else {
      await doc.set(storeModel.toJson());
    }
  }

  Stream<DocumentSnapshot> checkProductisLikedORNot(
    uid,
    storeID,
  ) {
    return db
        .collection("firebase")
        .doc(uid)
        .collection("Fav Store")
        .doc(storeID)
        .snapshots();
  }

  Stream<QuerySnapshot> getMyFavStore(uid) {
    return db
        .collection("firebase")
        .doc(uid)
        .collection("Fav Store")
        .snapshots();
  }

  Future<DocumentSnapshot> getSelectedUserdata(uid) async {
    return db.collection("firebase").doc(uid).get();
  }

// getSpecilaRationProductDataForOrder(collectionPath,storeId,selectedCategory){

// return  db.collection("Ration Products").where("storeId",isEqualTo: storeId).where("category",isEqualTo: selectedCategory).snapshots();

// }

  Stream<QuerySnapshot> getSelectedNeethiProductByCategory(
      selectedCategory, storeId) {
    print(selectedCategory);
    return db
        .collection("Lab Test")
        .where("storeId", isEqualTo: storeId)
        .where("category", isEqualTo: selectedCategory)
        .snapshots();
  }

  String? currentStoreid;
  getStorId(id) {
    currentStoreid = id;
    log(currentStoreid.toString());
  }

//---------------Ration........................
  Future addProductToRationStore(StoreProductModel productModel) async {
    final docs = db.collection("Ration Products").doc();
    docs.set(productModel.tojson(docs.id));
  }

  //........
  Stream<QuerySnapshot> getRationProduct(card, storeID) {
    log(storeID.toString());
    return db
        .collection("Ration Products")
        .where("storeId", isEqualTo: storeID)
        .where("category", isEqualTo: card)
        .snapshots();
  }

  getSpecialRationProducts(storeID) {
    return db
        .collection("Ration Products")
        .where("storeId", isEqualTo: storeID)
        .where("isItSpecial", isEqualTo: "Special")
        .snapshots();
  }

  // ..--------------------Maveli--------

  Future addProductToMaveliStore(StoreProductModel productModel) async {
    final docs = db.collection("Maveli Products").doc();
    docs.set(productModel.tojson(docs.id));
  }

  Stream<QuerySnapshot> getMaveliProduct(storeID) {
    return db
        .collection("Maveli Products")
        .where("storeId", isEqualTo: storeID)
        .snapshots();
  }

  getSpecialMaveliProducts(storeID) {
    return db
        .collection("Maveli Products")
        .where("storeId", isEqualTo: storeID)
        .where("isItSpecial", isEqualTo: "Special")
        .snapshots();
  }

  // ..--------------------Supplyco--------

  Future addProductToSupplycoStore(StoreProductModel productModel) async {
    final docs = db.collection("Supplyco Products").doc();
    docs.set(productModel.tojson(docs.id));
  }

  Stream<QuerySnapshot> getSupplycoProduct(storeIDs) {
    return db
        .collection("Supplyco Products")
        .where("storeId", isEqualTo: storeIDs)
        .snapshots();
  }

  getSpecialSupplycoProducts(storeID) {
    return db
        .collection("Supplyco Products")
        .where("storeId", isEqualTo: storeID)
        .where("isItSpecial", isEqualTo: "Special")
        .snapshots();
  }

  //----------------....................ORDER.............................----------------------------//

  Future addNewOrder(OrderModel orderModel) async {
    final doc = db.collection("Orders").doc();

    doc.set(orderModel.toJson(doc.id));
  }

  Stream<QuerySnapshot> getMyOrders() {
    return db
        .collection("Orders")
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        // .where("orderStatus", isEqualTo: "Confirmed")
        .snapshots();
  }

  Stream<QuerySnapshot> getOrderInStore(storid) {
// print(storeModel!.storeId);
    return db
        .collection("Orders")
        .where("storeId", isEqualTo: storid)
        .snapshots();
  }

  deleteMyOrder(id) {
    db.collection("Orders").doc(id).delete();
  }

  Stream<DocumentSnapshot> getSelectedOrderInStore(orderID) {
// print(storeModel!.storeId);
    return db.collection("Orders").doc(orderID).snapshots();
  }

  _deleteFromOrder(orderId, StoreProductModel storeProductModel) async {
    final snapshot = await db.collection("Orders").doc(orderId).get();
    if (snapshot.exists) {
      log("exist");
      OrderModel orderModel;
      orderModel = OrderModel.fromJosn(snapshot.data()!);

      List<StoreProductModel> list = [];
      list = orderModel.storeProductModel as List<StoreProductModel>;

      // if (list.isEmpty) {
      //   log("1");
      //   db.collection("Orders").doc(orderId).delete();
      // } else if (list.length > 1) {
      //   log("5");
      //   list.remove(storeProductModel);
      //   log("j");
      //   log(list.length.toString());
      //   db.collection("Orders").doc(orderId).update({
      //     "storeProductModel": list.map((e) => e.tojson(e.productId)).toList()
      //   });
      // } else {
      log("3");
      db.collection("Orders").doc(orderId).delete();
      // }
    }
  }

  sendNotificationToUser(
      uid, NotificationModel model, orderId, storeProductModel) {
    final doc =
        db.collection("firebase").doc(uid).collection("Notification").doc();
    doc.set(model.toJson(doc.id));
    _deleteFromOrder(orderId, storeProductModel);
  }

  Stream<QuerySnapshot> getCurrentUserNotification() {
    return db
        .collection("firebase")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Notification")
        .snapshots();
  }

//=====================FEEDBACk

  Future addToFeedBAck(FeedbackModel feedbackModel) async {
    final doc = db.collection("Feedback").doc();
    doc.set(feedbackModel.toJosn(doc.id));
  }
  //
  //===========================================NEETHI STORE

  addNewMedicine(MedicineModel medicineModel) async {
    final doc = db.collection("Medicine").doc();
    doc.set(medicineModel.toJson(doc.id));
  }

  Stream<QuerySnapshot> getAllMedicines(id) {
    // log(id.toString());
    return db
        .collection("Medicine")
        .where("storeID", isEqualTo: id)
        .snapshots();
  }

  Stream<QuerySnapshot> getSelectedStoreMedicineMedicines(storeID) {
    return db
        .collection("Medicine")
        .where("storeID", isEqualTo: storeID)
        .snapshots();
  }

  Future deleteSelectedMedicine(id) async {
    await db.collection("Medicine").doc(id).delete();
  }

  List<MedicineModel> listOfMedicine = [];
  getMyMedicineForSearch(storeID) async {
    final snapshot = await db
        .collection("Medicine")
        .where("storeID", isEqualTo: storeID)
        .get();

    listOfMedicine =
        snapshot.docs.map((e) => MedicineModel.fromJson(e.data())).toList();
  }

  List<MedicineModel> searchResulOfMedicines = [];

  searchMedicineForStore(String key) {
    searchResulOfMedicines = List.from(listOfMedicine);
    searchResulOfMedicines = listOfMedicine
        .where((element) =>
            element.medName.toLowerCase().contains(key.toLowerCase()))
        .toList();
    notifyListeners();
  }

  cleaMedicineData() {
    listOfMedicine.clear();
  }

  ///////////////////////

  Future<void> addLabtest(
    LabtestModel labtestmodel,
  ) async {
    final docRef = db.collection("Lab Test").doc();
    await docRef.set(labtestmodel.toMap(docRef.id));
    // fetchAllLabtest();
  }

  Stream<QuerySnapshot> getSelectedStoreAllLapTest(storeid) {
    return db
        .collection("Lab Test")
        .where("storeId", isEqualTo: storeid)
        .snapshots();
  }

  List<LabtestModel> listOFLabTest = [];
  getAllLabTestForSearch(storeid) async {
    final snapshot = await db
        .collection("Lab Test")
        .where("storeId", isEqualTo: storeid)
        .get();
    listOFLabTest =
        snapshot.docs.map((e) => LabtestModel.fromMap(e.data())).toList();
  }

  List<LabtestModel> resultOfLabtestsearch = [];

  searchLabtest(String key) {
    resultOfLabtestsearch = listOFLabTest;
    resultOfLabtestsearch = listOFLabTest
        .where((element) =>
            element.productname.toLowerCase().contains(key.toLowerCase()))
        .toList();
    notifyListeners();
  }

  Stream<QuerySnapshot> getSelectedStoreLapTest(storeId) {
    return db
        .collection("Lab Test")
        .where("storeId", isEqualTo: storeId)
        .snapshots();
  }

  deleteSelectedLabTest(id) {
    db.collection("Lab Test").doc(id).delete();
  }

  List<LabtestModel> labTestList = [];

  getMyLabTest(storeI) async {
    final snapshot = await db
        .collection("Lab Test")
        .where("storeId", isEqualTo: storeI)
        .get();

    labTestList =
        snapshot.docs.map((e) => LabtestModel.fromMap(e.data())).toList();
  }

  List<LabtestModel> labTestSearchResult = [];
  searchlabTest(
    String key,
  ) {
    labTestSearchResult = List.from(labTestList);

    labTestSearchResult = labTestList
        .where((element) => element.productname
            .toLowerCase()
            .contains(key.toString().toLowerCase()))
        .toList();
    notifyListeners();
  }

  cleaLabTestData() {
    labTestList.clear();
    // labTestSearchResult=[];
  }

//////////////////////////////////////
  addProduct(ProductNeethiModel productNeethiModel) async {
    final docRef = db.collection("Neethi Products").doc();
    await docRef.set(productNeethiModel.toJson(docRef.id));
  }

  Stream<QuerySnapshot> getAllNeethiProducts(id) {
    // log(id);
    return db
        .collection("Neethi Products")
        .where("storeId", isEqualTo: id)
        .snapshots();
  }

  List<ProductNeethiModel> listOFneethoiProductForSeach = [];
  getNeethiProducForSearch(id) async {
    final snapshot = await db
        .collection("Neethi Products")
        .where("storeId", isEqualTo: id)
        .get();
    listOFneethoiProductForSeach = snapshot.docs
        .map((e) => ProductNeethiModel.fromJson(e.data()))
        .toList();
  }

  List<ProductNeethiModel> searchResultOfNeethiProduct = [];

  searchNeethiProdut(String key) {
    searchResultOfNeethiProduct = List.from(listOFneethoiProductForSeach);
    searchResultOfNeethiProduct = listOFneethoiProductForSeach
        .where((element) =>
            element.prodName.toLowerCase().contains(key.toLowerCase()))
        .toList();
    notifyListeners();
  }

  Stream<QuerySnapshot> getSelectedNeethiProducts(id) {
    return db
        .collection("Neethi Products")
        .where("storeId", isEqualTo: id)
        .snapshots();
  }

  List<ProductNeethiModel> listOfNethiproductForSearch = [];
  getNeethiProdutForSearch(id) async {
    final snapshot = await db
        .collection("Neethi Products")
        .where("storeId", isEqualTo: id)
        .get();
    listOfNethiproductForSearch = snapshot.docs
        .map((e) => ProductNeethiModel.fromJson(e.data()))
        .toList();
  }

  List<ProductNeethiModel> searchResultofNeethiProduct = [];

  seachNeethiproduct(String key) {
    searchResultofNeethiProduct = List.from(listOfNethiproductForSearch);

    searchResultofNeethiProduct = listOfNethiproductForSearch
        .where((element) =>
            element.prodName.toLowerCase().contains(key.toLowerCase()))
        .toList();
    notifyListeners();
  }

  Stream<QuerySnapshot> getAllMedicineOFSellectedNeethi(storeId) {
    return db
        .collection("Medicine")
        .where("storeID", isEqualTo: storeId)
        .snapshots();
  }

  List<MedicineModel> listofMEdiceForSearch = [];
  getAllMedicineOFSellectedNeethiForSearch(storeids) async {
    final snapshot = await db
        .collection("Medicine")
        .where("storeID", isEqualTo: storeids)
        .get();
    listofMEdiceForSearch =
        snapshot.docs.map((e) => MedicineModel.fromJson(e.data())).toList();
  }

  List<MedicineModel> resultOfMedicn = [];
  sarchmedince(String key) {
    resultOfMedicn = List.from(listofMEdiceForSearch);
    resultOfMedicn = listofMEdiceForSearch
        .where((element) =>
            element.medName.toLowerCase().contains(key.toLowerCase()))
        .toList();
    notifyListeners();
  }

  //==========================================================
  //==========================================================
  Future bookOrder(BookingModel bookingModel) async {
    final doc = db.collection("Booking").doc();
    doc.set(bookingModel.toJosn(doc.id));
  }

  Stream<QuerySnapshot> fetchMyCompletdOrderOfNethi() {
    return db
        .collection("Booking")
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("status", isEqualTo: "Completed")
        .snapshots();
  }

  //=====Neeethi Order Notifiation

  Future sendNotificationToUserbookingStatusOFUser(
      toID, NotificationModelForNethiOrder model) async {
    final docs = db
        .collection("firebase")
        .doc(toID)
        .collection("Notification From Nethi")
        .doc();

    docs.set(model.toJson(docs.id));
  }

  Stream<QuerySnapshot> fetchMyNethiNotifcaition() {
    return db
        .collection("firebase")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Notification From Nethi")
        .snapshots();
  }

  Stream<QuerySnapshot> getMedAndProdctOrderFornethiModule(id) {
    return db
        .collection("Booking")
        .where("storeId", isEqualTo: id)
        .where("typeOfOrder", isNotEqualTo: "Lab Test")
        .snapshots();
  }

  Stream<QuerySnapshot> getLabTestFornethiModule(storeId) {
    return db
        .collection("Booking")
        .where("storeId", isEqualTo: storeId)
        .where("typeOfOrder", isEqualTo: "Lab Test")
        .snapshots();
  }

  Future<DocumentSnapshot> fetchSelectedItem(collection, id) {
    return db.collection(collection).doc(id).get();
  }

  //----------------ploadPrescription

  Future uploadPrescription(url, storeIdd) async {
    final data = db.collection("Prescription").doc();
    data.set({
      "id": data.id,
      "uid": FirebaseAuth.instance.currentUser!.uid,
      "prescription": url,
      "storeId": storeIdd
    });
  }

  Stream<QuerySnapshot> fetchAllPrescrion(id) {
    return db
        .collection("Prescription")
        .where("storeId", isEqualTo: id)
        .snapshots();
  }

  Future deletePrescription(id) async {
    db.collection("Prescription").doc(id).delete();
  }

  deleteBooking(id) {
    db.collection("Booking").doc(id).delete();
  }

  Future deleteSelectedProductByOrderConfirmation(collection, id) async {
    db.collection(collection).doc(id).delete();
  }

  Stream<QuerySnapshot> getAllFeddback() {
    return db.collection("Feedback").snapshots();
  }

  ///----------------------------------D E L E T E -----------------------------------
  ///
  ///
  // _getDeletionorderdeleteOrder(productId,storeId)async{

  //  final snapshot=await db.collection("Orders").where("storeId",isEqualTo: storeId).get();

  //  List<OrderModel>listOFOrders=snapshot.docs.map((e) => OrderModel.fromJosn(e.data())).toList();

  //  for(var i in listOFOrders){
  // for(var j in i.storeProductModel){
  //       String deleteingproductId=j.productId;

  //       if(deleteingproductId==productId){
  //         _deleteSelectedOrderOrder(i)

  //       }

  // }

  //  }

  // }
  _deleteSelectedOrderOrder(id) async {
    db.collection("Orders").doc(id).delete();
  }

  deleteProductOfCurrentStore(storeproductCollection, productId) async {
    db
        .collection(storeproductCollection)
        .doc(productId)
        .delete()
        .then((value) {});
  }
}
