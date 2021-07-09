import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as Http;
import 'package:pokemon_app/api_manager/http_wrapper.dart';

enum ApiType { DefaultApi, DioApi }

class ApiResponseInjector {
  // SINGLETON LOGIC
  static final _instance = new ApiResponseInjector._internal();
  ApiResponseInjector._internal();

  factory ApiResponseInjector() => _instance;

  Future<HttpWrapper> httpDataSource(ApiType _apiType) async {
    switch (_apiType) {
      case ApiType.DefaultApi:
        return await HttpWrapper.create(
            _apiType.toString(), DefaultV2ApiResponseHandler());
      case ApiType.DioApi:
        return await HttpWrapper.create(
            _apiType.toString(), DioApiResponseHandler());
      default:
        throw Exception("Should have a response type");
    }
  }
}

class MappedResponse<T> {
  int code;
  bool success;
  dynamic content;
  String message;
  String errorCode;

  MappedResponse(
      {this.code,
      this.content,
      this.message,
      this.success,
      this.errorCode = ''});
}

abstract class ApiResponseHandler {
  Future<Map<String, String>> httpheaders(String token, String contentType);
  MappedResponse processResponse(Http.Response response);
  MappedResponse processDioResponse(Response response);
}

class DefaultV2ApiResponseHandler implements ApiResponseHandler {
  Map<String, String> _appDeviceInfo = null;

  @override
  Future<Map<String, String>> httpheaders(
      String token, String contentType) async {
    // TODO get these values here and return
    if (_appDeviceInfo == null) {}

    Map<String, String> headers = {};
    // _appDeviceInfo.forEach((key, value) {
    //   headers[key] = value;
    // });
    var date = DateTime.now().toString();
    headers['RequestDateTime'] = date;
    headers['Accept-Language'] = "en";
    headers[HttpHeaders.contentTypeHeader] = contentType;
    if (token != null)
      headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    return headers;
  }

  @override
  MappedResponse<dynamic> processResponse(Http.Response response) {
    if (!kReleaseMode) {
      print(response.statusCode);
      print(response.body);
    }

    if (response.statusCode >= 500) {
      throw HttpCustomException(
          code: response.statusCode, message: "Unable to process request");
    }

    if (response.statusCode == 200 &&
        response.headers['content-type'] == 'text/plain; charset=utf-8') {
      return MappedResponse<dynamic>(
          code: response.statusCode,
          success: true,
          message: "SUCCESS",
          content: response.body);
    }
    if (!((response.statusCode < 200) ||
        (response.statusCode >= 300) ||
        (response.body == null))) {
      var body = response.body != null && response.body.isNotEmpty
          ? json.decode(response.body)
          : response.reasonPhrase;
      return MappedResponse<dynamic>(
          code: response.statusCode,
          success: true,
          message: "SUCCESS",
          content: body);
    } else {
      var body, message, errorCode;

      if (response.statusCode == 401) {
        if (response.body == null) {
          body = null;
          message = 'unauthorized';
          errorCode = "404";
        } else {
          try {
            body = json.decode(response.body);
            message = _extractErrorMessage(body);
            errorCode = _extractErrorCode(body);
          } catch (e) {
            var abc = e;
          }
        }
      } else {
        body = json.decode(response.body);
        message = _extractErrorMessage(body);
        errorCode = _extractErrorCode(body);
      }

      return MappedResponse<dynamic>(
          code: response.statusCode,
          success: false,
          message: message,
          content: body,
          errorCode: errorCode);
    }
  }

  String _extractErrorCode(body) {
    String errorCode = '401';
    return errorCode;
  }

  String _extractErrorMessage(body) {
    String errorMessage = "Failed to process request";
    if (body['error_description'] != null) {
      errorMessage = body['error_description'];
      return errorMessage;
    } else if (body['error_message'] != null) {
      errorMessage = body['error_message'];
      return errorMessage;
    } else {
      return errorMessage;
    }
  }

  @override
  MappedResponse processDioResponse(Response response) {
    throw UnimplementedError();
  }
}

class DioApiResponseHandler implements ApiResponseHandler {
  Map<String, String> _appDeviceInfo = null;
  @override
  Future<Map<String, String>> httpheaders(
      String token, String contentType) async {
    // TODO get these values here and return
    if (_appDeviceInfo == null) {}

    Map<String, String> headers = {};
    _appDeviceInfo.forEach((key, value) {
      headers[key] = value;
    });
    var date = DateTime.now().toString();
    headers['RequestDateTime'] = date;
    headers['Accept-Language'] = "en";
    headers[HttpHeaders.contentTypeHeader] = contentType;
    if (token != null)
      headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    return headers;
  }

  MappedResponse<dynamic> processDioResponse(Response response) {
    try {
      if (!kReleaseMode) {
        print(response.statusCode);
        print(response.data);
      }
      if (!((response.statusCode < 200) ||
          (response.statusCode >= 300) ||
          (response.data == null))) {
        var body = response.data != null && response.data.isNotEmpty
            ? response.data
            : response.statusCode;
        return MappedResponse<dynamic>(
            code: response.statusCode,
            success: true,
            message: "SUCCESS",
            content: body);
      } else {
        var body = json.decode(response.data);
        var message = _extractErrorMessage(body);

        return MappedResponse<dynamic>(
            code: response.statusCode,
            success: false,
            message: message,
            content: body);
      }
    } catch (e) {
      print(e);
    }
  }

  String _extractErrorMessage(body) {
    String errorMessage = "Failed to process request";
    if (body['errors'] != null) {
      var keys = body['errors'].keys.toList();
      List values = body['errors'].values.toList();
      if (body["title"].toString().isNotEmpty) {
        if (values.length != 0) errorMessage = values[0].first.toString();
      } else
        errorMessage = '${keys[0]}: ${body["title"]}';
    } else if (body['response'] != null) {
      if (body['response']['Message'] != null) {
        errorMessage = body['response']['Message'];
      } else if (body['response']['message'] != null) {
        errorMessage = body['response']['message'];
      }
    } else if (body['error'] != null) {
      if (body['error'].toString().isNotEmpty) {
        if (body['error']['message'] != null) {
          if (body['error']['message'].toString().isNotEmpty) {
            errorMessage = body['error']['message'];
          }
        }
      }
    } else if (body['error_description'] != null) {
      if (body['error_description'].toString().isNotEmpty)
        errorMessage = body['error_description'];
    } else if (body['message'] != null) {
      if (body['message'].toString().isNotEmpty) errorMessage = body['message'];
    } else if (body['errorCategory'] != null) {
      if (body['errorCategory'].toString().isNotEmpty)
        errorMessage = body['errorCategory'];
    } else if (body['errorDescription'] != null) {
      if (body['errorDescription'].toString().isNotEmpty)
        errorMessage = body['errorDescription'];
    }
    return errorMessage;
  }

  @override
  MappedResponse processResponse(Http.Response response) {
    throw UnimplementedError();
  }
}
