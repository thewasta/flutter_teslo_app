import 'package:dio/dio.dart';
import 'package:teslo_app/src/shared/infrastructure/exception/infrastructure_exception.dart';

class ApiConfig {
  final String baseUrl;
  final Duration connectionTimeout;
  final Duration receiveTimeout;
  final bool enableLogs;

  const ApiConfig({
    required this.baseUrl,
    this.connectionTimeout = const Duration(seconds: 10),
    this.receiveTimeout = const Duration(seconds: 20),
    this.enableLogs = true,
  });
}

abstract class HttpClient {
  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  });

  Future<Map<String, dynamic>> post(
    String path,
    Object? body, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  });
}

class DioHttpClient implements HttpClient {
  final Dio _dio;

  DioHttpClient({required ApiConfig config})
    : _dio = Dio(
        BaseOptions(
          baseUrl: config.baseUrl,
          connectTimeout: config.connectionTimeout,
          receiveTimeout: config.receiveTimeout,
          responseType: ResponseType.json,
          contentType: Headers.jsonContentType,
        ),
      ) {
    if (config.enableLogs) {
      _dio.interceptors.add(
        LogInterceptor(
          request: true,
          requestHeader: false,
          requestBody: true,
          error: true,
        ),
      );
    }
  }

  @override
  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final res = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: query,
        options: Options(headers: headers),
      );
      if (res.data is Map<String, dynamic>) {
        return res.data as Map<String, dynamic>;
      }
      throw Exception();
    } on DioException catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<Map<String, dynamic>> post(
    String path,
    Object? body, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final res = await _dio.post<Map<String, dynamic>>(
        path,
        data: body,
        options: Options(headers: headers),
      );
      if (res.data is Map<String, dynamic>) {
        return res.data as Map<String, dynamic>;
      }
      throw Exception();
    } on DioException catch (e) {
      if(e.response?.statusCode == 401) {
        throw InfrastructureException(e.response?.data['message'] ?? 'Credenciales incorrectas');
      }
      if(e.type == DioExceptionType.connectionTimeout) {
        throw InfrastructureException('Asegurate de tener una conexión estable.');
      }
      throw Exception(e.message);
    }
  }
}
