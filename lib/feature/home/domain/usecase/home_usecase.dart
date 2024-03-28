import 'package:ebooks_free/core/entitles/main_entities.dart';

import '../../data/repository/home_data_repository.dart';

abstract class HomeDataUsecase {
  Future<List<MainDataEntities>> getCategoryData(String categoryName);
}

class HomeDataUsecaseImp extends HomeDataUsecase{
  HomeDataUsecaseImp(this._homeDataRepositoryimp);
  HomeDataRepositoryimp _homeDataRepositoryimp;
  @override
  Future<List<MainDataEntities>> getCategoryData(String categoryName) async{
    return await _homeDataRepositoryimp.getCategoryData(categoryName);
  }
  
}