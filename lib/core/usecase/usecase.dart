import 'package:courses_app/core/utils/typedef.dart';

abstract class UsecaseWithoutParams<T> {
  ResultFuture<T> call();
}

abstract class UsecaseWithParams<T, P> {
  ResultFuture<T> call(P params);
}