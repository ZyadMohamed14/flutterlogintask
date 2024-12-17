import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../../feature/login/data/login_api_services.dart';
import '../../feature/login/data/login_repo_implementation.dart';
import '../../feature/login/domain/login_cubit.dart';

final getIt = GetIt.instance;
Future<void> setupGetIt() async {
  // 1. Register FirebaseAuth as a singleton
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // 2. Register LoginApiServices as a singleton with injected FirebaseAuth
  getIt.registerLazySingleton<LoginApiServices>(
          () => LoginApiServices(auth: getIt<FirebaseAuth>()));

  // 3. Register LoginRepositoryImpl as a singleton with injected LoginApiServices
  getIt.registerLazySingleton<LoginRepositoryImpl>(
          () => LoginRepositoryImpl(apiServices: getIt<LoginApiServices>()));

  // 4. Register LoginCubit as a factory (to allow fresh instances when needed)
  getIt.registerFactory<LoginCubit>(
          () => LoginCubit(loginService: getIt<LoginApiServices>()));


}