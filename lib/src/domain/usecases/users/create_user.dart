import 'package:courses_app/core/usecase/usecase.dart';
import 'package:courses_app/core/utils/typedef.dart';
import 'package:courses_app/src/domain/repositories/auth_repo.dart';
import 'package:equatable/equatable.dart';

class CreateUser extends UsecaseWithParams<void, CreateUserParams> {
  final AuthRepo _repository;

  CreateUser(this._repository);

  ResultVoid createUser(
          {required String createdAt,
          required String name,
          required String avatar}) async =>
      _repository.createUser(createdAt: createdAt, name: name, avatar: avatar);

  @override
  ResultFuture<void> call(CreateUserParams params) async =>
      _repository.createUser(createdAt: params.createdAt, name: params.name, avatar: params.avatar);
}

class CreateUserParams extends Equatable {
  final String createdAt;
  final String name;
  final String avatar;

  const CreateUserParams.empty() : this(createdAt: '_empty.string', name: '_empty.string', avatar: '_empty.string');

  const CreateUserParams(
      {required this.createdAt, required this.name, required this.avatar});

  @override
  List<Object?> get props => [createdAt, name, avatar];
}
