import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebooks_free/core/module/main_module.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore _firebaseFirestore  = FirebaseFirestore.instance;

class AccountDataSurces {
  
  Future<void> createBook(MainDataModule mainDataModule)async
  {
    await _firebaseFirestore.collection("books").add({
      "audioUrl": mainDataModule.audioUrl,
      "text": mainDataModule.text,
      "haveAudio": mainDataModule.haveAudio,
      "partName": mainDataModule.partName,
      "bookAbout": mainDataModule.bookAbout,
      "bookImageUrl": mainDataModule.bookImageUrl,
      "bookName": mainDataModule.bookName,
      "category": mainDataModule.category,
      "id": "",
      "oid": FirebaseAuth.instance.currentUser!.uid,
      "pdfUrl": mainDataModule.pdfUrl,
    });
    return;
  }
}