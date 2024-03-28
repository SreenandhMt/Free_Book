import 'package:ebooks_free/core/entitles/main_entities.dart';
import 'package:ebooks_free/feature/home/domain/usecase/home_usecase.dart';
import 'package:flutter/foundation.dart';

class HomeDataProvider extends ChangeNotifier{
  HomeDataProvider(this._dataUsecaseImp);
  HomeDataUsecaseImp _dataUsecaseImp;

  List<MainDataEntities>? comics,motivational,comady,general,top10;
  
  Future<List<MainDataEntities>> getCategoryData(String categoryName)async
  {
    return await _dataUsecaseImp.getCategoryData(categoryName);
  }

  Future<void> getAllData()async
  {
    comics = await _dataUsecaseImp.getCategoryData("comics");
    motivational =await _dataUsecaseImp.getCategoryData("motivational");
    comady = await _dataUsecaseImp.getCategoryData("comady");
    general = await _dataUsecaseImp.getCategoryData("general");
    top10 = await _dataUsecaseImp.getCategoryData("top10");
    ChangeNotifier();
    return;
  }
}