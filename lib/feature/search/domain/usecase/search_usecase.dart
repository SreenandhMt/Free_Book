import 'package:ebooks_free/feature/search/data/repository/search_repository.dart';

import '../../../../core/module/main_module.dart';

class SearchUsecase {
  SearchUsecase(this.searchRepository);
  SearchRepositoryImp searchRepository;

  Future<List<MainDataModule>> searchData(String search) {
    return searchRepository.searchData(search);
  }
}