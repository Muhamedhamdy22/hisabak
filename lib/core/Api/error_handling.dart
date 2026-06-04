class BaseException implements Exception {
  int? code;
  String? message;
  BaseException({this.code, this.message});
}

class BadRequestException extends BaseException {
  BadRequestException([String? message])
      : super(message: message , code: 400);
}

class NotFoundException extends BaseException {
  NotFoundException([String? message])
      : super(message: message , code: 404);
}
class ConflictException extends BaseException {
  ConflictException([String? message])
      : super(message: message , code: 409);
}
class InternalServerErrorException extends BaseException {
  InternalServerErrorException([String? message])
      : super(message: message , code: 500);
}
class AuthFailedException extends BaseException {
  AuthFailedException([String? message])
      : super(message: message , code: 99);
}
class GeneralException extends BaseException {
  GeneralException([String? message])
      : super(message: message , code: 0);
}