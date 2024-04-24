import 'package:chatroom/core/network/network_client_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

/// A wrapper around [Dio] for network requests, such as
/// `GET`, etc.
///
/// For every method, a [NetworkClientException] is thrown when
/// a request fails.
class NetworkClient {
  NetworkClient({
    required Dio dio,
  }) : _dio = dio {
    _configureDio();
    _setupInterceptors();
  }

  final Dio _dio;

  Future<Response<Map<String, dynamic>>> get(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.get(
        path,
        data: body,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw NetworkClientException(_handledDioException(e));
    }
  }

  String _handledDioException(DioException e) {
    late final String message;
    switch (e.type) {
      case DioExceptionType.connectionError:
        message = 'An error occurred connecting to the server';
      case DioExceptionType.connectionTimeout:
        message = 'The connection timed out.';
      case DioExceptionType.cancel:
        message = 'The request was cancelled.';
      case DioExceptionType.badResponse:
        message = 'Bad response';
      case DioExceptionType.badCertificate:
        message = 'Invalid certificate.';
      case DioExceptionType.sendTimeout:
        message = 'The request took longer than the server was prepared to wait.';
      case DioExceptionType.receiveTimeout:
        message = 'The request took longer than the '
            'server was prepared to wait to receive data.';
      case DioExceptionType.unknown:
        message = 'An unknown error occurred.';
    }
    return message;
  }

  void _configureDio() {
    _dio.options.baseUrl = const String.fromEnvironment('BASE_URL');
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
  }

  void _setupInterceptors() {
    if (kDebugMode) {
      _dio.interceptors.add(
        TalkerDioLogger(
          settings: const TalkerDioLoggerSettings(
            printRequestHeaders: true,
          ),
        ),
      );
    }
  }
}
