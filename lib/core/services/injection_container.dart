import 'package:courses_app/src/data/datasources/auth_remote_data_source.dart';
import 'package:courses_app/src/data/datasources/auth_remote_data_source_impl.dart';
import 'package:courses_app/src/data/repository/auth_repo_impl.dart';
import 'package:courses_app/src/domain/repositories/auth_repo.dart';
import 'package:courses_app/src/domain/usecases/users/create_user.dart';
import 'package:courses_app/src/domain/usecases/users/get_users.dart';
import 'package:courses_app/src/presentation/cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  sl
    //App logic
    ..registerFactory(() => AuthCubit(createUser: sl(), getUsers: sl()))
    //Use cases
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUsers(sl()))
    //Repository
    ..registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()))
    //Data sources
    ..registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(sl()))
    //External dependencies
    ..registerLazySingleton(http.Client.new);
}
