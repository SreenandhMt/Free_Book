import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebooks_free/core/module/main_module.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class SearchScreenData {

  Future<List<MainDataModule>> searchData(String search)async {
    List<MainDataModule> searchQuray=[];
    final data = await _firestore.collection("books").get().then((value) => value.docs.map((e) => MainDataModule.formJson(e.data())).toList());
    if(search.isEmpty){
      data.shuffle();
      return data;
    }else{
      for (var row in data) {
      if(row.bookName!.toLowerCase().contains(search.toLowerCase())||search.toLowerCase().contains(row.bookName!.toLowerCase()))
      {
        searchQuray.add(row);
      }else if(row.category!.toLowerCase().contains(search.toLowerCase())||search.toLowerCase().contains(row.category!.toLowerCase())){
        searchQuray.add(row);
      }
    }
    return searchQuray;
    }
  }
}