import 'package:courses_app/core/errors/exceptions.dart';
import 'package:courses_app/core/errors/failure.dart';
import 'package:courses_app/core/utils/typedef.dart';
import 'package:courses_app/src/data/datasources/auth_remote_data_source.dart';
import 'package:courses_app/src/domain/entities/auth/user.dart';
import 'package:courses_app/src/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource _remoteDataSource;
  
  const AuthRepoImpl(this._remoteDataSource);

  @override
  ResultVoid createUser({required String createdAt, required String name, required String avatar}) async{
    try {
      await _remoteDataSource.createUser(createdAt: createdAt, name: name, avatar: avatar);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async{
    try {
      final users = await _remoteDataSource.getUsers();
      return Right(users);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

}