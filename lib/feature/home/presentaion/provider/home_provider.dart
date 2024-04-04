import 'package:ebooks_free/core/entitles/main_entities.dart';
import 'package:ebooks_free/feature/home/domain/usecase/home_usecase.dart';
import 'package:flutter/foundation.dart';

class HomeDataProvider extends ChangeNotifier{
  HomeDataProvider(this.dataUsecaseImp);
  HomeDataUsecaseImp dataUsecaseImp;

  bool isLoding=false;

  List<MainDataEntities>? classics,motivational,comady,general,top10,story,horror,history;
  
  Future<List<MainDataEntities>> getCategoryData(String categoryName)async
  {
    return await dataUsecaseImp.getCategoryData(categoryName);
  }

  Future<void>init()async{
    isLoding=true;
    notifyListeners();
    await getAllData();
    isLoding=false;
    notifyListeners();
  }

  Future<void> getAllData()async
  {
    
    classics = await dataUsecaseImp.getCategoryData("classics");
    motivational =await dataUsecaseImp.getCategoryData("motivational");
    comady = await dataUsecaseImp.getCategoryData("comady");
    general = await dataUsecaseImp.getCategoryData("general");
    story = await dataUsecaseImp.getCategoryData("story");
    horror = await dataUsecaseImp.getCategoryData("horror");
    history = await dataUsecaseImp.getCategoryData("history");
    horror!.shuffle();
    story!.shuffle();
    history!.shuffle();
    classics!.shuffle();
    motivational!.shuffle();
    comady!.shuffle();
    general!.shuffle();
    // top10 = await _dataUsecaseImp.getCategoryData("top10");
    notifyListeners();
    return;
  }
}