import 'package:ebooks_free/core/module/main_module.dart';

abstract class SearchRepository {
  Future<List<MainDataModule>> searchData(String search);
}