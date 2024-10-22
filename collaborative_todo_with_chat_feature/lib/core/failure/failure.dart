import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message: message);
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message: message);
}
