import 'package:ebooks_free/core/module/main_module.dart';

abstract class HomeDataRepository{
  Future<List<MainDataModule>> getCategoryData(String categoryName);
}