import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final String? code;

  const Failure(this.message, {this.code});

  @override
  List<Object?> get props => [message, code];

  @override
  String toString() =>
      code != null
          ? 'runTimeType: $message (code: $code)'
          : 'runTimeType: $message';
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure(super.message, {super.code, this.statusCode});

  @override
  List<Object?> get props => [message, code, statusCode];
}

class AuthFailure extends Failure {
  const AuthFailure(super.message, {super.code});
}
