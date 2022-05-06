import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/data/repository/dio/dio_client.dart';
import 'package:news_app/data/repository/dio/logging_interceptor.dart';
import 'package:news_app/data/repository/news_repo.dart';
import 'package:news_app/providers/auth_provider.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/providers/search_provider.dart';
import 'package:news_app/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => DioClient(AppConstants.BASE_URL, sl(), loggingInterceptor: sl(), sharedPreferences: sl()));

  // Repository
  sl.registerLazySingleton(() => NewsRepo(dioClient: sl(), sharedPreferences: sl()));

  // Provider
  sl.registerFactory(() => AuthProvider(sharedPreferences: sl()));
  sl.registerFactory(() => NewsProvider(newsRepo: sl()));
  sl.registerFactory(() => SearchProvider(newsRepo: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
