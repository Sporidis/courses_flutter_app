import 'dart:convert';

import 'package:courses_app/core/errors/exceptions.dart';
import 'package:courses_app/core/utils/constants.dart';
import 'package:courses_app/core/utils/typedef.dart';
import 'package:courses_app/src/data/datasources/auth_remote_data_source.dart';
import 'package:courses_app/src/data/models/user_model.dart';
import 'package:http/http.dart' as http;

const kCreateUserEndpoint = '/test-api/users';
const kGetUsersEndpoint = '/test-api/users';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    try {
      final response = await _client.post(
        Uri.https(kBaseUrl, kCreateUserEndpoint),
        body: jsonEncode({
          'createdAt': createdAt,
          'name': name,
          'avatar': avatar,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      } else {
        throw ApiException(message: response.body, code: response.statusCode);
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), code: 505);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response =
          await _client.get(Uri.https(kBaseUrl, kGetUsersEndpoint));

      if (response.statusCode != 200) {
        throw ApiException(message: response.body, code: response.statusCode);
      }
      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map((userData) => UserModel.fromMap(userData))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), code: 505);
    }
  }
}
