import 'package:ebooks_free/core/module/main_module.dart';
import 'package:ebooks_free/feature/search/data/data_surces/search_data_surces.dart';

import '../../domain/repository/search_repository.dart';

class SearchRepositoryImp extends SearchRepository {
  SearchRepositoryImp(this.searchScreenData);
  SearchScreenData searchScreenData;

  @override
  Future<List<MainDataModule>> searchData(String search) {
    return searchScreenData.searchData(search);
  }
  
}