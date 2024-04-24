import 'package:flutter/foundation.dart';

@immutable
class NetworkClientException implements Exception {
  const NetworkClientException(this.message, {this.stackTrace});

  final String message;
  final StackTrace? stackTrace;

  @override
  String toString() => '${describeIdentity(this)}(message: $message)';
}
