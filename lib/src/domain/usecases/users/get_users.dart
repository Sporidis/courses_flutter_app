import 'package:courses_app/core/usecase/usecase.dart';
import 'package:courses_app/core/utils/typedef.dart';
import 'package:courses_app/src/domain/entities/auth/user.dart';
import 'package:courses_app/src/domain/repositories/auth_repo.dart';

class GetUsers extends UsecaseWithoutParams<List<User>> {
  final AuthRepo _repository;

  GetUsers(this._repository);

  @override
  ResultFuture<List<User>> call() async => _repository.getUsers();

}