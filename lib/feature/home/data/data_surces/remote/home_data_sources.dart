import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebooks_free/core/module/main_module.dart';

FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

class HomeData {

  Future<List<MainDataModule>> getCategoryData(String category)async
  {
      return await _firebaseFirestore.collection("books").where("category",isEqualTo: category).get().then((value) => value.docs.map((e) => MainDataModule.formJson(e.data())).toList());
  }
  
}