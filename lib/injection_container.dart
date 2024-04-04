import 'package:ebooks_free/feature/home/data/data_surces/remote/home_data_sources.dart';
import 'package:ebooks_free/feature/home/data/repository/home_data_repository.dart';
import 'package:ebooks_free/feature/home/domain/usecase/home_usecase.dart';
import 'package:ebooks_free/feature/home/presentaion/provider/home_provider.dart';
import 'package:ebooks_free/feature/my_pdf/data/data_surces/account_data_surces.dart';
import 'package:ebooks_free/feature/my_pdf/data/repository/account_data_repository.dart';
import 'package:ebooks_free/feature/my_pdf/domain/usecase/account_domain_usecase.dart';
import 'package:ebooks_free/feature/my_pdf/presentaion/provider/account_provider.dart';
import 'package:ebooks_free/feature/search/data/data_surces/search_data_surces.dart';
import 'package:ebooks_free/feature/search/data/repository/search_repository.dart';
import 'package:ebooks_free/feature/search/domain/usecase/search_usecase.dart';
import 'package:ebooks_free/feature/search/presentaion/provider/search_data_provider.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies()async{
  
  sl.registerSingleton<HomeData>(HomeData());
  sl.registerSingleton<HomeDataRepositoryimp>(HomeDataRepositoryimp(sl()));
  sl.registerSingleton<HomeDataUsecaseImp>(HomeDataUsecaseImp(sl()));
  sl.registerFactory<HomeDataProvider>(() => HomeDataProvider(sl()));

  sl.registerSingleton<SearchScreenData>(SearchScreenData());
  sl.registerSingleton<SearchRepositoryImp>(SearchRepositoryImp(sl()));
  sl.registerSingleton<SearchUsecase>(SearchUsecase(sl()));
  sl.registerFactory<SearchProvider>(() => SearchProvider(sl()));

  sl.registerSingleton<AccountDataSurces>(AccountDataSurces());
  sl.registerSingleton<AccountRepositoryImp>(AccountRepositoryImp(sl()));
  sl.registerSingleton<AccountUcecaseImp>(AccountUcecaseImp(sl()));
  sl.registerFactory<AccountProvider>(() => AccountProvider(sl()));
}