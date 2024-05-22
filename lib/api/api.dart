// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../cache/prefs_constant.dart';
import '../cache/shared_preferences.dart';
import '../util/bot_toast/bot_toast_functions.dart';
import 'exception/api_exception.dart';
import 'exception/auth_exception.dart';
import 'exception/server_exception.dart';

/// This class is used to handle the http calls.
/// It will make the http call and return the response to response handler.
class ApiHelper {
  static const String _baseUrl =
      "https://kanlas-backend-assignment.onrender.com";
  static final _pref = Pref.instance.pref;

  static Future<Map<String, String>?> getHeader(
      {required Map<String, String> type}) async {
    // String? token = _pref.getString(PrefConstant.authToken);

    // if (token != null) {
    //   type.addAll({
    //     "Authorization": token,
    //   });
    // }

    return type;
  }

  /// Function to make get request to the [endpoint] with [queryParams].
  static Future<dynamic> get(
    String endpoint, {
    Map<String, String>? queryParams,
    Map<String, String>? type,
  }) async {
    var responseJson;

    try {
      Map<String, String>? header;
      header = await getHeader(
        type: type ?? {'Content-Type': 'application/json'},
      );
      final response = await http.get(
        Uri.parse('$_baseUrl$endpoint').replace(
          queryParameters: queryParams,
        ),
        headers: header,
      );

      responseJson = _returnResponse(response);
    } on SocketException {
      throw Exception('No Internet connection');
    }
    return responseJson;
  }

  /// Function to make post request to the [endpoint] with [data] and [queryParams].
  static Future<dynamic> post(
    String endpoint,
    dynamic data, {
    Map<String, String>? queryParams,
    Map<String, String>? type,
  }) async {
    var responseJson;
    try {
      Map<String, String>? header;
      header = await getHeader(
        type: type ?? {'Content-Type': 'application/json'},
      );

      final response = await http.post(
        Uri.parse('$_baseUrl$endpoint').replace(
          queryParameters: queryParams,
        ),
        body: data != null ? jsonEncode(data) : data,
        headers: header,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw Exception('No Internet connection');
    }
    return responseJson;
  }

  // image post call
  static Future<dynamic> postImage(String endpoint, Map<String, String> data,
      {required String? imageFile}) async {
    var responseJson;
    try {
      Map<String, String>? header;
      header = await getHeader(type: {
        "Content-Type":
            "multipart/form-data; boundary=<calculated when request is sent>",
        "Accept": "*/*"
      });

      var request =
          http.MultipartRequest('PATCH', Uri.parse('$_baseUrl$endpoint'));
      request.fields.addAll(data);

      if (imageFile != null) {
        request.files.add(await http.MultipartFile.fromPath('image', imageFile,
            filename: imageFile.split('/').last));
      }
      request.headers.addAll(header!);

      final res = await request.send();
      final response = await http.Response.fromStream(res);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw Exception('No Internet connection');
    }
    return responseJson;
  }

  /// Function to make challenge expiry check
  static Future<dynamic> checkChallengeExpiry(
    String endpoint, {
    Map<String, String>? queryParams,
    Map<String, String>? type,
  }) async {
    var responseJson;

    try {
      Map<String, String>? header;
      header = await getHeader(
        type: type ?? {'Content-Type': 'application/json'},
      );
      final response = await http.get(
        Uri.parse('$_baseUrl$endpoint').replace(
          queryParameters: queryParams,
        ),
        headers: header,
      );

      responseJson = jsonDecode(response.body);
    } on SocketException {
      throw Exception('No Internet connection');
    }
    return responseJson;
  }

  /// Function to make put request to the [endpoint] with [data] .
  static Future<dynamic> put(
    String endpoint,
    dynamic data,
  ) async {
    var responseJson;
    try {
      Map<String, String>? header;
      header = await getHeader(type: {'Content-Type': 'application/json'});
      final response = await http.put(
        Uri.parse('$_baseUrl$endpoint'),
        body: jsonEncode(data),
        headers: header,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw Exception('No Internet connection');
    }
    return responseJson;
  }

  /// Function to make patch request to the [endpoint] with [data] and [queryParams].
  static Future<dynamic> patch(String endpoint, dynamic data,
      {Map<String, String>? queryParams}) async {
    var responseJson;
    dynamic response;
    try {
      Map<String, String>? header;
      header = await getHeader(type: {'Content-Type': 'application/json'});

      response = await http.patch(
          Uri.parse('$_baseUrl$endpoint').replace(queryParameters: queryParams),
          body: jsonEncode(data),
          headers: header);

      responseJson = _returnResponse(response);
    } on SocketException {
      throw Exception('No Internet connection');
    }
    return responseJson;
  }

  /// Function to make delete request to the [endpoint] with [data] and [queryParams].
  static Future<dynamic> delete(String endpoint, dynamic data,
      {Map<String, String>? queryParams}) async {
    var responseJson;
    try {
      Map<String, String>? header;
      header = await getHeader(type: {'Content-Type': 'application/json'});
      final response = await http.delete(
        Uri.parse('$_baseUrl$endpoint').replace(
          queryParameters: queryParams,
        ),
        body: jsonEncode(data),
        headers: header,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw Exception('No Internet connection');
    }
    return responseJson;
  }

  /// Function to return the appropriate response according to the status code.
  static dynamic _returnResponse(dynamic response) async {
    try {
      switch (response.statusCode) {
        case 200:
        case 201:
          return jsonDecode(response.body);
        case 401:
          throw AuthException(code: "unauthorized-access");
        case 400:
          String code = jsonDecode(response.body)['message'];
          throw ApiException(code: code);
        case 422:
          String code = jsonDecode(response.body)['message'];
          throw ApiException(code: code);
        case 500 || 599:
          String code = jsonDecode(response.body)['message'];
          throw ApiException(code: code);
        default:
          throw ('Error occured while Communication with Server with StatusCode : ${response.statusCode}');
      }
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  static void _handleError(dynamic e) {
    if (e is AuthException) {
      showNotification(title: 'Unauthorized Access');
    } else if (e is ApiException) {
      showNotification(title: e.code);
    } else if (e is ServerException) {
      showNotification(title: 'Internal Server Error');
    } else {
      showNotification(title: 'Error occured while Communication with Server');
    }
  }
}
