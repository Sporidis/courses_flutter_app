import 'package:courses_app/core/errors/exceptions.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int code;

  String get errorMessage => 'Error $code: $message';

  const Failure({required this.message, required this.code});

  @override
  List<Object?> get props => [message, code];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, required super.code});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, required super.code});
}

class ApiFailure extends Failure {
  const ApiFailure({required super.message, required super.code});

  ApiFailure.fromException(ApiException e)
      : this(message: e.message, code: e.code);
}
