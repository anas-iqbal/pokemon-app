import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_app/api_manager/api_handler.dart';

class HttpWrapper {
  static var _http = http.Client();
  static bool isSSLEnabled = false;
  static Map<String, HttpWrapper> _instanceCache = {};
  ApiResponseHandler _apiResponseHandler;
  static Dio dio = Dio();

  HttpWrapper._internal(ApiResponseHandler apiResponseHandler) {
    _apiResponseHandler = apiResponseHandler;
  }

  static Future<HttpWrapper> create(
      String name, ApiResponseHandler apiResponseHandler) async {
    if (!_instanceCache.containsKey(name)) {
      await _init();

      _instanceCache[name] = new HttpWrapper._internal(apiResponseHandler);
    }

    return _instanceCache[name];
  }

  static _init() async {
    if (isSSLEnabled) {
      // Apply SSL certificate on http layer which automatically checks certificate before the network handshake
      var context = await _setTrustedCertificateContext();
      final ioc = new HttpClient(context: context);
      _http = new IOClient(ioc);
    } else {
      // Temporary For development purpose allow bad certificates
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      _http = new IOClient(ioc);
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
  }

  static Future<SecurityContext> _setTrustedCertificateContext() async {
    // ByteData data = await rootBundle.load('assets/certificate.pem');
    SecurityContext context = SecurityContext();
    // context.setTrustedCertificatesBytes(data.buffer.asUint8List());
    return context;
  }

  Future<dynamic> get(String url,
      {String id, String token, Map<String, String> queryParameters}) async {
    await checkInternetAvailable();

    String uriWithId = '$url${id == null ? '' : '/$id'}';
    String query = _buildQuery(queryParameters);
    Uri uri = Uri.parse('$uriWithId${query.length > 0 ? '?$query' : ''}');
    var headers =
        await _apiResponseHandler.httpheaders(token, 'application/json');
    if (!kReleaseMode) {
      print(uri.toString());
      print(headers.toString());
    }

    var res =
        await _http.get(uri, headers: headers).timeout(Duration(seconds: 80));
    MappedResponse processed = _apiResponseHandler.processResponse(res);
    return _returnResponse(processed);
  }

  Future<dynamic> post(String url,
      {@required dynamic body,
      String token,
      Map<String, String> queryParameters}) async {
    // await checkInternetAvailable();
    // var uri = Uri.parse('$url');
    String query = _buildQuery(queryParameters);
    Uri uri = Uri.parse('$url${query.length > 0 ? '?$query' : ''}');
    var headers =
        await _apiResponseHandler.httpheaders(token, 'application/json');

    if (!kReleaseMode) {
      print(uri.toString());
      print(headers.toString());
      print(body != null ? json.encode(body) : body);
    }

    var res = await _http
        .post(uri,
            body: body == null ? body : json.encode(body), headers: headers)
        .timeout(Duration(seconds: 80));
    MappedResponse processed = _apiResponseHandler.processResponse(res);
    return _returnResponse(processed);
  }

  Future<dynamic> put(String url,
      {@required Map<String, dynamic> body, String token}) async {
    await checkInternetAvailable();

    var uri = Uri.parse('$url');
    var headers =
        await _apiResponseHandler.httpheaders(token, 'application/json');

    if (!kReleaseMode) {
      print(uri.toString());
      print(headers.toString());
      print(body != null ? json.encode(body) : body);
    }

    var res = await _http
        .put(uri,
            body: body == null ? body : json.encode(body), headers: headers)
        .timeout(Duration(seconds: 80));
    MappedResponse processed = _apiResponseHandler.processResponse(res);
    return _returnResponse(processed);
  }

  Future<dynamic> patch(String url,
      {@required Map<String, dynamic> body, String token}) async {
    await checkInternetAvailable();

    var uri = Uri.parse('$url');
    var headers =
        await _apiResponseHandler.httpheaders(token, 'application/json');

    if (!kReleaseMode) {
      print(uri.toString());
      print(headers.toString());
      print(body != null ? json.encode(body) : body);
    }

    var res = await _http
        .patch(uri,
            body: body == null ? body : json.encode(body), headers: headers)
        .timeout(Duration(seconds: 80));
    MappedResponse processed = _apiResponseHandler.processResponse(res);
    return _returnResponse(processed);
  }

  Future<dynamic> delete(String url,
      {Map<String, dynamic> body, @required String token}) async {
    await checkInternetAvailable();

    var uri = Uri.parse('$url');
    var headers =
        await _apiResponseHandler.httpheaders(token, 'application/json');

    if (!kReleaseMode) {
      print(uri.toString());
      print(headers.toString());
      print(body != null ? json.encode(body) : body);
    }

    var res = await _http
        .delete(uri, headers: headers)
        .timeout(Duration(seconds: 80));
    MappedResponse processed = _apiResponseHandler.processResponse(res);
    return _returnResponse(processed);
  }

  Future<dynamic> postFormData(String url,
      {@required Map<String, dynamic> body, String token}) async {
    await checkInternetAvailable();

    var uri = Uri.parse('$url');
    var headers = await _apiResponseHandler.httpheaders(
        token, 'application/x-www-form-urlencoded');

    if (!kReleaseMode) {
      print(uri.toString());
      print(headers.toString());
      print(body);
    }
    var res = await _http
        .post(uri,
            body: body, encoding: Encoding.getByName('utf-8'), headers: headers)
        .timeout(Duration(seconds: 80));

    MappedResponse processed = _apiResponseHandler.processResponse(res);
    return _returnResponse(processed);
  }

  Future<dynamic> patchFormData(String url,
      {@required Map<String, dynamic> body, String token}) async {
    await checkInternetAvailable();

    var uri = Uri.parse('$url');
    var headers = await _apiResponseHandler.httpheaders(
        token, 'application/x-www-form-urlencoded');

    if (!kReleaseMode) {
      print(uri.toString());
      print(headers.toString());
      print(body);
    }
    var res = await _http
        .patch(uri,
            body: body, encoding: Encoding.getByName('utf-8'), headers: headers)
        .timeout(Duration(seconds: 80));
    MappedResponse processed = _apiResponseHandler.processResponse(res);
    return _returnResponse(processed);
  }

  Future<dynamic> multipart(String url,
      {@required Map<String, dynamic> body,
      String token,
      List<File> files}) async {
    await checkInternetAvailable();

    dio.options.headers =
        await _apiResponseHandler.httpheaders(token, 'multipart/form-data');
    if (isSSLEnabled) {
      var context = await _setTrustedCertificateContext();
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        HttpClient httpClient = new HttpClient(context: context);
        return httpClient;
      };
    }

    var formData = FormData.fromMap(body);

    if (files != null && files.length > 0) {
      for (var i = 0; i < files.length; i++) {
        var file = await MultipartFile.fromFile(files[i].path);
        formData.files.add(MapEntry('files', file));
      }
    }

    var response = await dio.post(url, data: formData);
    MappedResponse processed = _apiResponseHandler.processDioResponse(response);
    return _returnResponse(processed);
  }

  Future<dynamic> getHTML(String url, {String token}) async {
    await checkInternetAvailable();

    dio.options.headers =
        await _apiResponseHandler.httpheaders(token, 'text/html');
    if (isSSLEnabled) {
      var context = await _setTrustedCertificateContext();
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        HttpClient httpClient = new HttpClient(context: context);
        return httpClient;
      };
    }

    var response = await dio.get(url);
    return response;
  }

  String _buildQuery(Map<String, dynamic> queryParameters) {
    String query = '';
    queryParameters?.forEach((key, value) => query += '$key=$value&');

    return query.length > 0 ? query.substring(0, query.length - 1) : query;
  }

  _returnResponse(MappedResponse processed) {
    if (processed.success) {
      return processed.content;
    } else {
      throw HttpCustomException(
          code: processed.code,
          message: processed.message,
          apiCode: processed.errorCode);
    }
  }

  Map<String, String> _setDefaultHeaders(String token, dynamic body) {
    var headers = new Map<String, String>();

    headers[HttpHeaders.contentTypeHeader] = 'application/json';

    if (token != null)
      headers[HttpHeaders.authorizationHeader] = "Bearer $token";

    headers['Accept-Language'] = 'en';

    return headers;
  }

  Future<void> checkInternetAvailable() async {
    return;
    // var connectivityResult = await (Connectivity().checkConnectivity());
    // if (connectivityResult == ConnectivityResult.mobile ||
    //     connectivityResult == ConnectivityResult.wifi) {
    //   return;
    // } else {
    //   throw new HttpCustomException(
    //       code: 2000, message: "Please Check your internet connection.");
    // }
  }
}

class HttpCustomException implements IOException {
  int code;
  String message;
  String apiCode;

  HttpCustomException({this.code, this.message, this.apiCode = ''});

  @override
  String toString() {
    var b = new StringBuffer()..write(message);
    return b.toString();
  }
}

class BadRequestException extends HttpException {
  BadRequestException({String message = 'The request is invalid.'})
      : super(message);

  @override
  String toString() {
    var b = new StringBuffer()..write('BadRequestException: ')..write(message);
    return b.toString();
  }
}

class UnauthorizedAccessException extends HttpException {
  UnauthorizedAccessException(
      {String message = 'User not allowed to perform this operation'})
      : super(message);

  @override
  String toString() {
    var b = new StringBuffer()
      ..write('UnauthorizedAccessException: ')
      ..write(message);
    return b.toString();
  }
}

class ResourceNotFoundException extends HttpException {
  ResourceNotFoundException({String message = ''}) : super(message);

  @override
  String toString() {
    var b = new StringBuffer()
      ..write('ResourceNotFoundException: ')
      ..write(message);
    return b.toString();
  }
}
