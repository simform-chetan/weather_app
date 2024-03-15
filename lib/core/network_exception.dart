import 'package:weather_app/core/app_strings.dart';

class NetworkException implements Exception {
  const NetworkException([this.message, this.prefix]);

  final String? message;
  final String? prefix;

  @override
  String toString() => "$prefix: $message";
}

class FetchDataException extends NetworkException {
  const FetchDataException([String? message])
      : super(message, AppStrings.somethingWentWrong);
}

class BadRequestException extends NetworkException {
  const BadRequestException([message]) : super(message, 'Invalid Request');
}

class UnauthorisedException extends NetworkException {
  const UnauthorisedException([message]) : super(message, 'Unauthorised');
}

class ForbiddenException extends NetworkException {
  const ForbiddenException([message]) : super(message, 'Forbidden');
}

class InternalServerError extends NetworkException {
  const InternalServerError([message])
      : super(message, 'Internal Server Error');
}

class NotFoundException extends NetworkException {
  const NotFoundException([message]) : super(message, 'Not Found');
}
