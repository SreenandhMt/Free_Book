import 'package:ebooks_free/core/entitles/main_entities.dart';
import 'package:ebooks_free/feature/search/domain/usecase/search_usecase.dart';
import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  SearchProvider(this.searchUsecase);
  SearchUsecase searchUsecase;

  bool isLoding = false;
  
  List<MainDataEntities>? searchQuary;

  Future<void>init()async{
    isLoding=true;
    notifyListeners();
    await getSearchQuary("");
    isLoding=false;
    notifyListeners();
  }

  Future<void> getSearchQuary(String search)async
  {
    searchQuary = await searchUsecase.searchData(search);
    notifyListeners();
    return;
  }
}