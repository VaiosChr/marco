import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MockApiService {
  MockApiService({Dio? client, String? baseUrl})
    : _dio =
          client ??
          Dio(
            BaseOptions(
              baseUrl: baseUrl ?? _defaultBaseUrl,
              contentType: Headers.jsonContentType,
              responseType: ResponseType.json,
            ),
          );

  static const String _defaultBaseUrl = 'http://localhost:3000/api';

  final Dio _dio;

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.get<dynamic>(
      path,
      queryParameters: queryParameters,
    );
    return _decode(response.data);
  }

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.post<dynamic>(
      path,
      data: body,
      queryParameters: queryParameters,
    );
    return _asMap(response.data);
  }

  Future<Map<String, dynamic>> patch(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.patch<dynamic>(
      path,
      data: body,
      queryParameters: queryParameters,
    );
    return _asMap(response.data);
  }

  Future<dynamic> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.delete<dynamic>(
      path,
      queryParameters: queryParameters,
    );
    return _decode(response.data);
  }

  dynamic _decode(dynamic data) {
    if (data is String) {
      return jsonDecode(data);
    }
    return data;
  }

  Map<String, dynamic> _asMap(dynamic data) {
    final decoded = _decode(data);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }
    if (decoded is Map) {
      return decoded.map((key, value) => MapEntry(key.toString(), value));
    }
    throw const FormatException('Expected a JSON object response.');
  }
}

final mockApiServiceProvider = Provider<MockApiService>((ref) {
  return MockApiService();
});
