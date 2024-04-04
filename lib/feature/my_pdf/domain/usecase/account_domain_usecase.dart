import 'package:ebooks_free/feature/my_pdf/data/repository/account_data_repository.dart';

import '../../../../core/module/main_module.dart';

abstract class AccountUcecase {
  Future<void> createBook(MainDataModule mainDataModule);
  Future<void> createPrivateBooks(String uid,MainDataModule mainDataModule);
  Future<List<MainDataModule>> getPrivateBooks(String uid);
  Future<void> deletePrivateBooks(String id);
  Future<List<MainDataModule>> myPublicBooks(String uid);
  Future<List<MainDataModule>> getFavoritebook(String uid);
  Future<void> addFavoritebook(MainDataModule mainDataModule);
  Future<void> deleteFavoritebook(id);
}

class AccountUcecaseImp extends AccountUcecase{
  AccountUcecaseImp(this.repositoryImp);
  AccountRepositoryImp repositoryImp;
  @override
  Future<void> addFavoritebook(MainDataModule mainDataModule) {
    return repositoryImp.addFavoritebook(mainDataModule);
  }

  @override
  Future<void> createBook(MainDataModule mainDataModule) {
    return repositoryImp.createBook(mainDataModule);
  }

  @override
  Future<void> createPrivateBooks(String uid, MainDataModule mainDataModule) {
    return repositoryImp.createPrivateBooks(uid, mainDataModule);
  }

  @override
  Future<void> deleteFavoritebook(id) {
    return repositoryImp.deleteFavoritebook(id);
  }

  @override
  Future<void> deletePrivateBooks(String id) {
    return repositoryImp.deletePrivateBooks(id);
  }

  @override
  Future<List<MainDataModule>> getFavoritebook(String uid) {
    return repositoryImp.getFavoritebook(uid);
  }

  @override
  Future<List<MainDataModule>> getPrivateBooks(String uid) {
    return repositoryImp.getPrivateBooks(uid);
  }

  @override
  Future<List<MainDataModule>> myPublicBooks(String uid) {
    return repositoryImp.myPublicBooks(uid);
  }
  
}