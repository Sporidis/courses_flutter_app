import 'package:equatable/equatable.dart';

class ApiException extends Equatable {
  final String message;
  final int code;

  const ApiException({required this.message, required this.code});

  @override
  List<Object?> get props => [message, code];
}
