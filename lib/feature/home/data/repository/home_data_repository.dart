import 'package:ebooks_free/core/module/main_module.dart';
import 'package:ebooks_free/feature/home/data/data_surces/remote/home_data_sources.dart';

import '../../domain/repository/home_repository.dart';

class HomeDataRepositoryimp extends HomeDataRepository {
  HomeDataRepositoryimp(this.homeData);
  HomeData homeData;


  @override
  Future<List<MainDataModule>> getCategoryData(String categoryName) async{
    return await homeData.getCategoryData(categoryName);
  }
}