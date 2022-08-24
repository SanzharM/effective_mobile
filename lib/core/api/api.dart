import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'api_response.dart';

enum Method { get, post, put, delete }

class Api {
  static const _headers = {'Content-type': 'application/json'};

  static Future<bool> _checkInternetConnection() async {
    final result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.ethernet || result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  Future<ApiResponse> request({
    required Uri route,
    required Method method,
    Map<String, dynamic>? params,
    Duration timeout = const Duration(seconds: 15),
  }) async {
    final hasConnection = await _checkInternetConnection();
    if (!hasConnection) {
      return const ApiResponse(statusCode: -1, error: 'No internet connection');
    }

    http.Response? response;

    try {
      switch (method) {
        case Method.get:
          response = await http.get(route, headers: _headers).timeout(timeout);
          break;
        case Method.post:
          response = await http.post(route, headers: _headers, body: params).timeout(timeout);
          break;
        case Method.put:
          response = await http.put(route, headers: _headers, body: params).timeout(timeout);
          break;
        case Method.delete:
          response = await http.delete(route, headers: _headers, body: params).timeout(timeout);
          break;
      }
    } on TimeoutException catch (_) {
      debugPrint('Timeout Exception: ${_.message} : $route');
      return const ApiResponse(statusCode: -1, error: 'Request timed out');
    } on SocketException catch (_) {
      debugPrint('Socket Exception: ${_.message} : $route');
      return const ApiResponse(statusCode: -1, error: 'Connection closed');
    } catch (_) {
      debugPrint('Unknown Exception: $_ : $route');
      return const ApiResponse(statusCode: -1, error: 'Something went wrong');
    }

    logResponse(response, params: params);

    final isSuccess = response.statusCode >= 200 && response.statusCode <= 299;
    return ApiResponse(
      statusCode: response.statusCode,
      isSuccess: isSuccess,
      response: response,
      error: isSuccess ? null : await compute(_parseError, response),
    );
  }

  static String? _parseError(http.Response? response) {
    try {
      if (response?.statusCode != null) {
        return _getErrorFromStatusCode(response!.statusCode);
      }
      return jsonDecode(response!.body);
    } catch (e) {
      debugPrint('Unable to parse error: $e');
    }
    return null;
  }

  static String _getErrorFromStatusCode(int statusCode) {
    switch (statusCode) {
      case 500:
        return 'Internal Server Error';
      case 404:
        return 'Page not found';
      case 403:
        return 'Unauthorized'; // Access Denied
      case 401:
        return 'Unauthorized';

      default:
        return 'Something went wrong. Please, try again later';
    }
  }

  static void logResponse(http.Response response, {dynamic params}) {
    debugPrint('\nURL: ${response.request?.url}');
    debugPrint('Headers: ${response.headers}');
    debugPrint('Method: ${response.request?.method}');
    debugPrint('Status Code: ${response.statusCode}');
    if (params != null) debugPrint('Params: $params');
    debugPrint('Body: ${response.body}');
    debugPrint('------------\n');
  }
}
