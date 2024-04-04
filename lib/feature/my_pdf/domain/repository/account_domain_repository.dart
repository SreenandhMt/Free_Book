import '../../../../core/module/main_module.dart';

abstract class AccountRepository {
  Future<void> createBook(MainDataModule mainDataModule);
  Future<void> createPrivateBooks(String uid,MainDataModule mainDataModule);
  Future<List<MainDataModule>> getPrivateBooks(String uid);
  Future<void> deletePrivateBooks(String id);
  Future<List<MainDataModule>> myPublicBooks(String uid);
  Future<List<MainDataModule>> getFavoritebook(String uid);
  Future<void> addFavoritebook(MainDataModule mainDataModule);
  Future<void> deleteFavoritebook(id);
}