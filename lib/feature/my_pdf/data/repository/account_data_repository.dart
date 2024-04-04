import 'package:ebooks_free/core/module/main_module.dart';
import 'package:ebooks_free/feature/my_pdf/data/data_surces/account_data_surces.dart';

import '../../domain/repository/account_domain_repository.dart';

class AccountRepositoryImp extends AccountRepository {
  AccountRepositoryImp(this.dataSurces);
  AccountDataSurces dataSurces;

  @override
  Future<void> addFavoritebook(MainDataModule mainDataModule) {
    return dataSurces.addFavoritebook(mainDataModule);
  }

  @override
  Future<void> createBook(MainDataModule mainDataModule) {
    return dataSurces.createBook(mainDataModule);
  }

  @override
  Future<void> createPrivateBooks(String uid, MainDataModule mainDataModule) {
    return dataSurces.createPrivateBooks(uid, mainDataModule);
  }

  @override
  Future<void> deleteFavoritebook(id) {
    return dataSurces.deleteFavoritebook(id);
  }

  @override
  Future<void> deletePrivateBooks(String id) {
    return dataSurces.deletePrivateBooks(id);
  }

  @override
  Future<List<MainDataModule>> getFavoritebook(String uid) {
   return dataSurces.getFavoritebook(uid);
  }

  @override
  Future<List<MainDataModule>> getPrivateBooks(String uid) {
    return dataSurces.getPrivateBooks(uid);
  }

  @override
  Future<List<MainDataModule>> myPublicBooks(String uid) {
    return dataSurces.myPublicBooks(uid);
  }
  
}