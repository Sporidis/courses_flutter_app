import 'package:courses_app/core/errors/exceptions.dart';
import 'package:courses_app/core/errors/failure.dart';
import 'package:courses_app/src/data/datasources/auth_remote_data_source.dart';
import 'package:courses_app/src/data/repository/auth_repo_impl.dart';
import 'package:courses_app/src/domain/entities/auth/user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRemoteDataSource remoteDataSource;
  late AuthRepoImpl authRepoImpl;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    authRepoImpl = AuthRepoImpl(remoteDataSource);
  });

  const tException = ApiException(message: 'Unknown Error Occurred', code: 500);

  group('createUser', () {
    const createdAt = 'createdAt';
    const name = 'name';
    const avatar = 'avatar';
    test('should call [remoteDataSource.createUser] ', () async {
      when(() => remoteDataSource.createUser(
              createdAt: any(named: 'createdAt'),
              name: any(named: 'name'),
              avatar: any(named: 'avatar')))
          .thenAnswer((_) async => Future.value());

      final result = await authRepoImpl.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      expect(result, equals(const Right(null)));

      verify(() => remoteDataSource.createUser(
          createdAt: 'createdAt', name: 'name', avatar: 'avatar')).called(1);

      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'should return [Left] when [remoteDataSource.createUser] throws an error',
        () async {
      when(() => remoteDataSource.createUser(
              createdAt: any(named: 'createdAt'),
              name: any(named: 'name'),
              avatar: any(named: 'avatar')))
          .thenThrow(tException);

      final result = await authRepoImpl.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      expect(
          result,
          equals(Left(
              ApiFailure(message: tException.message, code: tException.code))));

      verify(() => remoteDataSource.createUser(
          createdAt: 'createdAt', name: 'name', avatar: 'avatar')).called(1);

      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('getUsers', () {
    test('should call [remoteDataSource.getUsers] ', () async {
      when(() => remoteDataSource.getUsers())
          .thenAnswer((_) async => []);

      final result = await authRepoImpl.getUsers();

      expect(result, isA<Right<dynamic, List<User>>>());

      verify(() => remoteDataSource.getUsers()).called(1);

      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'should return [Left] when [remoteDataSource.getUsers] throws an error',
        () async {
      when(() => remoteDataSource.getUsers()).thenThrow(tException);

      final result = await authRepoImpl.getUsers();

      expect(
          result,
          equals(Left(
              ApiFailure(message: tException.message, code: tException.code))));

      verify(() => remoteDataSource.getUsers()).called(1);

      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
