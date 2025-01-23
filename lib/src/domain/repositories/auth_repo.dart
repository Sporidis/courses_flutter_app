import 'package:courses_app/core/utils/typedef.dart';
import 'package:courses_app/src/domain/entities/auth/user.dart';

abstract class AuthRepo {
  const AuthRepo();

  ResultVoid createUser(
      {required String createdAt,
      required String name,
      required String avatar});

  ResultFuture<List<User>> getUsers();
}
