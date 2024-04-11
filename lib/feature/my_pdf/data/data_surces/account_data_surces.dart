import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebooks_free/core/module/main_module.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore _firebaseFirestore  = FirebaseFirestore.instance;

class AccountDataSurces {
  
  Future<void> createBook(MainDataModule mainDataModule)async
  {
    await _firebaseFirestore.collection("books").doc(mainDataModule.bookName!).set({
      "audioUrl": mainDataModule.audioUrl,
      "text": mainDataModule.text,
      "haveAudio": mainDataModule.haveAudio,
      "partName": mainDataModule.partName,
      "bookAbout": mainDataModule.bookAbout,
      "bookImageUrl": mainDataModule.bookImageUrl,
      "bookName": mainDataModule.bookName,
      "category": mainDataModule.category,
      "id":mainDataModule.bookName!,
      "oid": FirebaseAuth.instance.currentUser!.uid,
      "pdfUrl": mainDataModule.pdfUrl,
    });
    return;
  }

  Future<void> createPrivateBooks(String uid,MainDataModule mainDataModule)async{
    await _firebaseFirestore.collection("books-private").doc(mainDataModule.bookImageUrl!+mainDataModule.bookName!).set({
      "audioUrl": mainDataModule.audioUrl,
      "text": mainDataModule.text,
      "haveAudio": mainDataModule.haveAudio,
      "partName": mainDataModule.partName,
      "bookAbout": mainDataModule.bookAbout,
      "bookImageUrl": mainDataModule.bookImageUrl,
      "bookName": mainDataModule.bookName,
      "category": mainDataModule.category,
      "id": mainDataModule.bookImageUrl!+mainDataModule.bookName!,
      "oid": FirebaseAuth.instance.currentUser!.uid,
      "pdfUrl": mainDataModule.pdfUrl,
    }); //where("oid",isEqualTo: uid).get().then((value) => value.docs.map((e) => MainDataModule.formJson(e.data())).toList());
  }

  Future<List<MainDataModule>> getPrivateBooks(String uid)async{
    return await _firebaseFirestore.collection("books-private").where("oid",isEqualTo: uid).get().then((value) => value.docs.map((e) => MainDataModule.formJson(e.data())).toList());
  }

  Future<void> deletePrivateBooks(String id)async{
    await _firebaseFirestore.collection("books-private").doc(id).delete();
  }

  Future<List<MainDataModule>> myPublicBooks(String uid)async{
    return await _firebaseFirestore.collection("books").where("oid",isEqualTo: uid).get().then((value) => value.docs.map((e) => MainDataModule.formJson(e.data())).toList());
  }

  Future<List<MainDataModule>> getFavoritebook(String uid)async
  {
    return await _firebaseFirestore.collection("favorite").doc(uid).collection("books").get().then((value) => value.docs.map((e) => MainDataModule.formJson(e.data())).toList());
  }

  Future<void> addFavoritebook(MainDataModule mainDataModule)async
  {
    await _firebaseFirestore.collection("favorite").doc(FirebaseAuth.instance.currentUser!.uid).collection("books").doc(mainDataModule.bookImageUrl!+mainDataModule.bookName!).set(
      {
        "audioUrl": mainDataModule.audioUrl,
      "text": mainDataModule.text,
      "haveAudio": mainDataModule.haveAudio,
      "partName": mainDataModule.partName,
      "bookAbout": mainDataModule.bookAbout,
      "bookImageUrl": mainDataModule.bookImageUrl,
      "bookName": mainDataModule.bookName,
      "category": mainDataModule.category,
      "id": mainDataModule.bookImageUrl!+mainDataModule.bookName!,
      "oid": FirebaseAuth.instance.currentUser!.uid,
      "pdfUrl": mainDataModule.pdfUrl,
      }
    );
  }
  
  Future<void> deleteFavoritebook(id)async
  {
    await _firebaseFirestore.collection("favorite").doc(FirebaseAuth.instance.currentUser!.uid).collection("books").doc(id).delete();
    
  }
}