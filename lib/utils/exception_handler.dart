import 'dart:async';
import 'dart:io';

import 'package:pokemon_app/api_manager/http_wrapper.dart';

class ExceptionData {
  String title;
  String message;
  int code;
  ExceptionData({this.title, this.message, this.code = -1});
}

class ExceptionHandler {
  static final ExceptionHandler _exceptionHandler =
      ExceptionHandler._internal();
  ExceptionHandler._internal();
  factory ExceptionHandler() => _exceptionHandler;

  Future<ExceptionData> handleException(Exception e) async {
    var data = _makeException(e);
    return data;
  }

  ExceptionData _makeException(Exception e) {
    switch (e.runtimeType) {
      case TimeoutException:
        return ExceptionData(
            title: "TimeoutException",
            message: "Check your internet connection.");
      case SocketException:
        return ExceptionData(
            title: "Connectivity", message: "Check your internet connection.");

      case HttpException:
        return ExceptionData(
            title: "Error", message: (e as HttpException).message);

      case HttpCustomException:
        return ExceptionData(
            title: "Error",
            message: (e as HttpCustomException).message,
            code: (e as HttpCustomException).code);
      case BadRequestException:
        return ExceptionData(
            title: "BadRequestException", message: "Bad Request");
      case UnauthorizedAccessException:
        return ExceptionData(
            title: "UnauthorizedAccessException", message: "Bad Request");
      case ResourceNotFoundException:
        return ExceptionData(
            title: "ResourceNotFoundException", message: "Bad Request");
      default:
        return ExceptionData(
            title: "Error", message: "Unable to process request.");
    }
  }
}
