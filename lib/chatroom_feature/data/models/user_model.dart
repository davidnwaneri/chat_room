import 'package:chatroom/chatroom_feature/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

class UserModel extends UserEntity {
  const UserModel({required super.id, required super.name});

  factory UserModel.fromString(String name) {
    try {
      return UserModel(
        id: name.characters.string,
        name: name,
      );
    } on FormatException {
      rethrow;
    }
  }
}
