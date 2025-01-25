import 'package:courses_app/src/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar});
  Future<List<UserModel>> getUsers();
}

// returning model instead of entity (Clean Architecture)
// dont have to return an error, just throw it