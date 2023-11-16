import 'package:dio/dio.dart';

class DioSettings {
  final Dio dio = Dio();
  static const String baseUrl = 'https://reqres.in';

  DioSettings() {
    _setupDio();
  }

  Future<void> _setupDio() async {
    dio.options = BaseOptions(
      contentType: 'application/json',
      baseUrl: baseUrl,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json'
      },
    );
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        return handler.next(options);
      },
      onError: _handleError,
    ));
  }

  Future<void> _handleError(
      DioException error, ErrorInterceptorHandler handler) async {
    if (error.response?.statusCode == 401) {
      try {
        return handler.resolve(await dio.request(
            error.response!.requestOptions.path,
            options: Options(headers: error.response!.requestOptions.headers)));
      } catch (err) {
        return handler.reject(DioException(
            requestOptions: error.response!.requestOptions, error: err));
      }
    } else {
      return handler.reject(error);
    }
  }
}
