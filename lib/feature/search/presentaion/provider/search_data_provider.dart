import 'package:ebooks_free/core/entitles/main_entities.dart';
import 'package:ebooks_free/feature/search/domain/usecase/search_usecase.dart';
import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  SearchProvider(this.searchUsecase);
  SearchUsecase searchUsecase;
  
  List<MainDataEntities>? searchQuary;

  Future<void> getSearchQuary(String search)async
  {
    searchQuary = await searchUsecase.searchData(search);
    notifyListeners();
    return;
  }
}