import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class UserEntity extends Equatable {
  const UserEntity({required this.id, required this.name});

  final String id;
  final String name;

  @override
  List<Object> get props => ['id', 'name'];

  @override
  String toString() {
    return '''
      ${describeIdentity(this)}(
        id: $id,
        name: $name,
      )
    ''';
  }
}
