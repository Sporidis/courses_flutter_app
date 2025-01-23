import 'dart:convert';

import 'package:courses_app/core/utils/typedef.dart';
import 'package:courses_app/src/domain/entities/auth/user.dart';

class UserModel extends User {
  const UserModel(
      {required super.avatar,
      required super.createdAt,
      required super.name,
      required super.id});

  UserModel.fromMap(DataMap map)
      : this(
          avatar: map['avatar'] as String,
          createdAt: map['createdAt'] as String,
          name: map['name'] as String,
          id: map['id'] as String,
        );

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  UserModel copyWith({
    String? avatar,
    String? createdAt,
    String? name,
    String? id,
  }) {
    return UserModel(
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  DataMap toMap() => {
        'avatar': avatar,
        'createdAt': createdAt,
        'name': name,
        'id': id,
      };

  String toJson() => jsonEncode(toMap());

  const UserModel.empty()
      : this(
          avatar: '_empty.avatar',
          createdAt: '_empty.createdAt',
          name: '_empty.name',
          id: '1',
        );
}
