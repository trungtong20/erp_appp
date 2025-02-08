import 'package:erp_appp/core/network/base_dio.dart';
import 'package:erp_appp/core/utils/navigation_service.dart';
import 'package:erp_appp/core/utils/shared_preferences_manager.dart';
import 'package:erp_appp/cubit/auth/auth_cubit.dart';
import 'package:erp_appp/cubit/language/change_language_cubit.dart';
import 'package:erp_appp/data/repositories/admin_repository.dart';
import 'package:erp_appp/data/repositories/authen_repository.dart';
import 'package:erp_appp/data/service/authen_service.dart';
import 'package:dio/dio.dart';
import 'package:erp_appp/data/service/database_service.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt serviceLocator = GetIt.instance;
Future setupLocator() async {

  final dbService = DatabaseService();
  await dbService.initConnection(); 

  serviceLocator.registerSingleton<DatabaseService>(dbService);

  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(
      () => SharedPreferencesManager(sharedPreferences: sharedPreferences));
  serviceLocator.registerLazySingleton(() => NavigationService());
  serviceLocator.registerLazySingleton<BaseDio>(() => BaseDio());


// dio
  final baseDio = serviceLocator<BaseDio>();
  final dio = baseDio.createDio();
  serviceLocator.registerLazySingleton<Dio>(() => dio);

  //service
  serviceLocator.registerLazySingleton<AuthenService>(() => AuthenService(dio));

  // repository
  serviceLocator
      .registerLazySingleton<AuthenRepository>(() => AuthenRepositoryImpl(
            authenService: serviceLocator(),
          ));
serviceLocator.registerLazySingleton<AdminRepository>(
    () => AdminRepositoryImpl(serviceLocator.get<DatabaseService>()));
  // cubit
  serviceLocator.registerLazySingleton(() => AuthCubit());
  serviceLocator.registerLazySingleton(() => LanguageCubit());
}
