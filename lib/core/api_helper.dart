import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:weather_app/core/api_constants.dart';
import 'package:weather_app/core/app_strings.dart';
import 'package:weather_app/core/my_logger.dart';
import 'package:weather_app/core/network_exception.dart';

class APIHelper {
  const APIHelper({
    required this.baseUrl,
    this.apiKey,
    this.timeout = ApiConstants.timeout,
  });

  final String baseUrl;
  final String? apiKey;
  final Duration timeout;

  Future<Map<String, dynamic>> get(
    String endUrl, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) async {
    try {
      final url = _getUrl(endUrl, queryParameters);
      MyLogger.printLog(LoggerType.info, url.toString(), 'Get => URL:');
      MyLogger.printLog(
        LoggerType.info,
        headers.toString(),
        'Get => Headers: ',
      );

      final rawResponse =
          await http.get(url, headers: headers).timeout(timeout);
      return validateAndParseResponse(rawResponse);
    } on SocketException {
      throw const FetchDataException(AppStrings.noInternet);
    }
  }

  Future<Map<String, dynamic>> post(
    String endPoint, {
    Map<dynamic, dynamic>? body,
    Map<String, String>? queryParameters,
  }) async {
    try {
      final url = _getUrl(endPoint, queryParameters);
      MyLogger.printLog(LoggerType.info, url.toString(), 'Post => URL: ');
      MyLogger.printLog(LoggerType.info, body.toString(), 'Post => Body: ');

      final rawResponse = await http.post(url, body: body).timeout(timeout);
      return validateAndParseResponse(rawResponse);
    } on SocketException {
      throw const FetchDataException(AppStrings.noInternet);
    }
  }

  Map<String, dynamic> validateAndParseResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 302:
        var res = response.body;
        MyLogger.printLog(LoggerType.info, res, 'Response => ');
        return jsonDecode(res);
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnauthorisedException(response.body.toString());
      case 403:
        throw ForbiddenException(response.body.toString());
      case 404:
        throw NotFoundException(response.body.toString());
      case 500:
        throw InternalServerError(response.body.toString());
      default:
        throw const FetchDataException(AppStrings.somethingWentWrong);
    }
  }

  Uri _getUrl(String endPoint, Map<String, String>? queryParameters) {
    final params = queryParameters ?? {};
    if (apiKey != null) {
      params.putIfAbsent('appid', () => apiKey!);
    }
    return Uri.https(baseUrl, endPoint, params);
  }
}
