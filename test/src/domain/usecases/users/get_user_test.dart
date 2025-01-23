
import 'package:courses_app/src/domain/entities/auth/user.dart';
import 'package:courses_app/src/domain/repositories/auth_repo.dart';
import 'package:courses_app/src/domain/usecases/users/get_users.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

void main(){
  late AuthRepo repository;
  late GetUsers usecase;

  setUp(() {
    repository = MockAuthRepo();
    usecase = GetUsers(repository);
  });

  const tResponse = [User.empty()];
  test('should call the [AuthRepo.getUsers] and return [List<User>]', () async {
    when(() => repository.getUsers()).thenAnswer((_) async => const Right(tResponse));

    final result = await usecase();

    expect(result, equals(const Right<dynamic, List<User>>(tResponse)));

    verify(() => repository.getUsers()).called(1);

    verifyNoMoreInteractions(repository);
  });
}