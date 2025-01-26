import 'package:courses_app/src/domain/entities/auth/user.dart';
import 'package:courses_app/src/domain/usecases/users/create_user.dart';
import 'package:courses_app/src/domain/usecases/users/get_users.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required CreateUser createUser,
    required GetUsers getUsers,
  })  : _createUser = createUser,
        _getUsers = getUsers,
        super(const AuthInitial()) {
    on<CreateUserEvent>(_createUserHandler);
    on<GetUsersEvent>(_getUsersHandler);
  }

  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> _createUserHandler(
      CreateUserEvent event, Emitter<AuthState> emit) async {
    emit(const CreatingUser());

    final result = await _createUser(
      CreateUserParams(
        createdAt: event.createdAt,
        name: event.name,
        avatar: event.avatar,
      ),
    );

    result.fold(
      (error) => emit(AuthError(error.errorMessage)),
      (_) => emit(const UserCreated()),
    );
  }

  Future<void> _getUsersHandler(
      GetUsersEvent event, Emitter<AuthState> emit) async {
    emit(const GettingUsers());

    final result = await _getUsers();

    result.fold(
      (error) => emit(AuthError(error.errorMessage)),
      (users) => emit(UsersLoaded(users)),
    );
  }
}
