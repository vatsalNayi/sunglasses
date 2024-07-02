import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:http/http.dart' as http;

class InstaMojoApiClient extends GetxService {
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;
  static final String noInternetMessage = 'connection_to_api_server_failed'.tr;
  final int timeoutInSeconds = 30;

  Map<String, String>? _mainHeaders;

  InstaMojoApiClient(
      {required this.appBaseUrl, required this.sharedPreferences});

  void updateHeader({required String apiKey, required String authToken}) {
    _mainHeaders = {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      'X-Api-Key': apiKey,
      'X-Auth-Token': authToken,
    };
  }

  Future<Response> getData(
    String uri, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    try {
      if (foundation.kDebugMode) {
        log('====> INSTAMOJO API Call: $uri\nHeader: $_mainHeaders');
      }
      log("===Url===>${getINSTAMOJOUri(uri)}");
      http.Response _response = await http
          .get(
            getINSTAMOJOUri(uri),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      log('------------${e.toString()}');
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postData(
    String uri,
    dynamic body, {
    Map<String, String>? headers,
  }) async {
    try {
      if (foundation.kDebugMode) {
        log('====> API Call: $uri\nHeader: $_mainHeaders');
        log('====> API Body: $body');
      }
      log('$uri');
      log('Get Uri is: ${getINSTAMOJOUri(uri)}');

      http.Response _response = await http
          .post(
            getINSTAMOJOUri(uri),
            body: jsonEncode(body),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e, stackTrace) {
      log("Error: ", error: e, stackTrace: stackTrace);
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(http.Response response, String uri) {
    dynamic _body;
    try {
      _body = jsonDecode(response.body);
    } catch (e) {}
    Response _response = Response(
      body: _body != null ? _body : response.body,
      bodyString: response.body.toString(),
      request: Request(
          headers: response.request!.headers,
          method: response.request!.method,
          url: response.request!.url),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
    if (_response.statusCode != 200 &&
        _response.body != null &&
        _response.body is! String) {
      if (_response.body.toString().startsWith('{code:')) {
        // ErrorModel _errorResponse = ErrorModel.fromJson(_response.body);
        _response = Response(
          statusCode: _response.statusCode,
          body: _response.body,
        );
      } else if (_response.body.toString().startsWith('{message') ||
          _response.body.toString().startsWith('{success')) {
        try {
          _response = Response(
              statusCode: _response.statusCode,
              body: _response.body,
              statusText: _response.body['message']);
        } catch (e) {
          log("INSTAMOJO Handle Response Error: ", error: e);
        }
      }
    } else if (_response.statusCode != 200 && _response.body == null) {
      _response = Response(statusCode: 0, statusText: noInternetMessage);
    }
    if (foundation.kDebugMode) {
      log('====> API Response: [${_response.statusCode}] $uri\n${_response.body}');
    }
    return _response;
  }

  Uri getINSTAMOJOUri(String uri) {
    return Uri.parse('$appBaseUrl$uri');
  }
}

class MultipartBody {
  String key;
  XFile? file;

  MultipartBody(this.key, this.file);
}
