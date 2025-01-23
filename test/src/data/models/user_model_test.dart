import 'dart:convert';

import 'package:courses_app/core/utils/typedef.dart';
import 'package:courses_app/src/data/models/user_model.dart';
import 'package:courses_app/src/domain/entities/auth/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();
  test('should be a subclass of [User] entity', () {
    expect(tModel, isA<User>());
  });

  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson) as DataMap;

  group('fromMap', () {
    test('should return a valid [UserModel]', () {
      final result = UserModel.fromMap(tMap);

      expect(result, equals(tModel));
    });
  });

  group('fromJson', () {
    test('should return a valid [UserModel]', () {
      final result = UserModel.fromJson(tJson);

      expect(result, equals(tModel));
    });
  });

  group('toMap', () {
    test('should return a [DataMap] from [UserModel]', () {
      final result = tModel.toMap();

      expect(result, equals(tMap));
    });
  });

  group('toJson', () {
    test('should return a [String] from [UserModel]', () {
      final result = tModel.toJson();

      final tJson = jsonEncode({
        "avatar": "_empty.avatar",
        "createdAt": "_empty.createdAt",
        "name": "_empty.name",
        "id": "1"
      });

      expect(result, equals(tJson));
    });
  });

  group('copyWith', () {
    test('should return a copy of [UserModel]', () {
      final result = tModel.copyWith(avatar: 'avatar');

      expect(result.name, equals(tModel.name));
      expect(result, isA<UserModel>());
    });
  });
}
