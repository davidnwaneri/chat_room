import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class Failure extends Equatable {
  const Failure(
    this.message, {
    this.stackTrace,
  });

  final String message;
  final StackTrace? stackTrace;

  @override
  List<Object?> get props => [message, stackTrace];
}

class ConversationFailure extends Failure {
  const ConversationFailure(
    super.message, {
    super.stackTrace,
  });
}
