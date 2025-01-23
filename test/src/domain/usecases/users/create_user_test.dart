import 'package:courses_app/src/domain/repositories/auth_repo.dart';
import 'package:courses_app/src/domain/usecases/users/create_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

void main() {
  late CreateUser usecase;
  late AuthRepo repository;

  setUp(() {
    repository = MockAuthRepo();
    usecase = CreateUser(repository);
  });

  const params = CreateUserParams.empty();

  test('should call the [AuthRepo.createUser]', () async {
    when(() => repository.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(named: 'avatar')))
        .thenAnswer((_) async => const Right(null));

    final result = await usecase(params);

    expect(result, equals(const Right<dynamic, void>(null)));

    verify(() => repository.createUser(
        createdAt: params.createdAt, name: params.name, avatar: params.avatar)).called(1);

    verifyNoMoreInteractions(repository);
  });
}
