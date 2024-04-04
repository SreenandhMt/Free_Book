import 'package:ebooks_free/core/entitles/main_entities.dart';
import 'package:ebooks_free/feature/my_pdf/domain/usecase/account_domain_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/module/main_module.dart';

class AccountProvider extends ChangeNotifier{

  List<MainDataEntities>? publicBooks;
  List<MainDataEntities>? favoriteBooks;
  List<MainDataEntities>? privateBooks;

  AccountProvider(this.accountUcecase);
  AccountUcecaseImp accountUcecase;
  
  Future<void> createBook(MainDataModule mainDataModule,Uint8List uint8list)async{
    await accountUcecase.createBook(mainDataModule);
  }

  Future<void>getAllData()async{
    final uid = FirebaseAuth.instance.currentUser!.uid;
    publicBooks = await accountUcecase.myPublicBooks(uid);
    favoriteBooks = await accountUcecase.getFavoritebook(uid);
    privateBooks = await accountUcecase.getPrivateBooks(uid);
    notifyListeners();
    
    return;
  }

  Future<List<MainDataEntities>> myPublicBooks(String uid)async{
    return await accountUcecase.myPublicBooks(uid);
  }
  
}

// Future<void> createBook(MainDataModule mainDataModule);
//   Future<void> createPrivateBooks(String uid,MainDataModule mainDataModule);
//   Future<List<MainDataModule>> getPrivateBooks(String uid);
//   Future<void> deletePrivateBooks(String id);
//   Future<List<MainDataModule>> myPublicBooks(String uid);
//   Future<List<MainDataModule>> getFavoritebook(String uid);
//   Future<void> addFavoritebook(MainDataModule mainDataModule);
//   Future<void> deleteFavoritebook(id);