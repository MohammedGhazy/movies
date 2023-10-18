import 'package:movies/core/network/error_message_model.dart';

class ServerExceptions {
  final ErrorMessageModel errorMessageModel;

  const ServerExceptions({
    required this.errorMessageModel
  });
}

class LocalDatabaseException implements Exception {
  final String message;

  const LocalDatabaseException({
    required this.message,
  });
}
