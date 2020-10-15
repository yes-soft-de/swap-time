import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/utils/logger/logger.dart';

@provide
class ApiClient {
  String token;
  final Logger _logger;
  final String tag = 'ApiClient';

  ApiClient(this._logger);

  void setToken(String token) {
    this.token;
  }

  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, String> queryParams,
    Map<String, String> headers,
  }) async {
    Dio client = new Dio(BaseOptions(headers: headers));
    try {
      _logger.info(tag, 'Requesting GET to: ' + url);
      var response = await client.get(
        url,
        queryParameters: queryParams,
      );
      return _processResponse(response);
    } catch (e) {
      _logger.error(tag, e.toString() + url);
      return null;
    }
  }

  Future<Map<String, dynamic>> post(
    String url,
    Map<String, dynamic> payLoad, {
    Map<String, String> queryParams,
    Map<String, String> headers,
  }) async {
    Dio client = new Dio(BaseOptions(headers: headers));
    try {
      _logger.info(tag, 'Requesting Post to: ' + url);
      _logger.info(tag, 'POST: ' + jsonEncode(payLoad));
      _logger.info(tag, 'Headers: ' + jsonEncode(headers));
      var response = await client.post(
        url,
        queryParameters: queryParams,
        data: json.encode(payLoad),
      );
      return _processResponse(response);
    } catch (e) {
      _logger.error(tag, e.toString() + url);
      return null;
    }
  }

  Future<Map<String, dynamic>> put(
    String url,
    Map<String, dynamic> payLoad, {
    Map<String, String> queryParams,
    Map<String, String> headers,
  }) async {
    Dio client = new Dio(BaseOptions(headers: headers));
    try {
      _logger.info(tag, 'Requesting PUT to: ' + url);
      _logger.info(tag, 'PUT: ' + jsonEncode(payLoad));
      var response = await client.put(
        url,
        queryParameters: queryParams,
        data: json.encode(payLoad),
      );
      return _processResponse(response);
    } catch (e) {
      _logger.error(tag, e.toString() + url);
      return null;
    }
  }

  Map<String, dynamic> _processResponse(Response response) {
    if (response.statusCode >= 200 && response.statusCode < 400) {
      _logger.info(tag, response.data.toString());
      return response.data;
    } else {
      _logger.error(tag, response.statusCode.toString());
      return null;
    }
  }
}
