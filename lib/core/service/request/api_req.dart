import 'package:dio/dio.dart';

import '../dio_settings/dio_env.dart';

class ApiReq {
  DioSettings dioSettings = DioSettings();

  Future<Response> login(Map<String, dynamic> data) async {
    return await dioSettings.dio.post('/api/login', data: data);
  }
  Future<Response> usersList(int page) async {
    return await dioSettings.dio.get('/api/users?page=$page');
  }
}
