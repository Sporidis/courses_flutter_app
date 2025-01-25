import 'dart:convert';

import 'package:courses_app/core/errors/exceptions.dart';
import 'package:courses_app/core/utils/constants.dart';
import 'package:courses_app/src/data/datasources/auth_remote_data_source.dart';
import 'package:courses_app/src/data/datasources/auth_remote_data_source_impl.dart';
import 'package:courses_app/src/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockHttpClient();
    remoteDataSource = AuthRemoteDataSourceImpl(client);
    registerFallbackValue(Uri());
  });

  group('createUser', () {
    const createdAt = 'createdAt';
    const name = 'name';
    const avatar = 'avatar';
    test('should complete successfully when the status code is 200 or 201 ',
        () async {
      when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (_) async => http.Response('User created successfully', 201));

      final methodCall = remoteDataSource.createUser;

      expect(methodCall(avatar: avatar, createdAt: createdAt, name: name),
          completes);

      verify(() => client.post(Uri.https(kBaseUrl, kCreateUserEndpoint),
          body: jsonEncode(
            {'createdAt': createdAt, 'name': name, 'avatar': avatar},
          ))).called(1);
      verifyNoMoreInteractions(client);
    });

    test('should throw an exception when the status code is not 200 or 201',
        () async {
      when(() => client.post(any(), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('User not created', 400));

      final methodCall = remoteDataSource.createUser;

      expect(
          () async =>
              methodCall(avatar: avatar, createdAt: createdAt, name: name),
          throwsA(const ApiException(message: 'User not created', code: 400)));

      verify(() => client.post(Uri.https(kBaseUrl, kCreateUserEndpoint),
          body: jsonEncode(
            {'createdAt': createdAt, 'name': name, 'avatar': avatar},
          ))).called(1);
      verifyNoMoreInteractions(client);
    });
  });

  group('getUsers', () {
    final tUsers = [
      const UserModel.empty(),
    ];
    test('should return [List<UserModel>] when the status code is 200',
        () async {
      when(() => client.get(any())).thenAnswer(
          (_) async => http.Response(jsonEncode([tUsers.first.toMap()]), 200));

      final result = await remoteDataSource.getUsers();

      expect(result, equals(tUsers));

      verify(() => client.get(Uri.https(kBaseUrl, kGetUsersEndpoint)))
          .called(1);
      verifyNoMoreInteractions(client);
    });

    test('should throw an exception when the status code is not 200 or 201',
        () async {
      const tMessage = 'User not found';
      when(() => client.get(any())).thenAnswer(
        (_) async => http.Response(
          tMessage,
          500,
        ),
      );

      final methodCall = remoteDataSource.getUsers;

      expect(
        () => methodCall(),
        throwsA(
          const ApiException(message: 'User not found', code: 500),
        ),
      );

      verify(() => client.get(Uri.https(kBaseUrl,kGetUsersEndpoint)))
          .called(1);
      verifyNoMoreInteractions(client);
    });
  });
}
