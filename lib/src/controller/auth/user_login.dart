import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/enum/enum.dart';
import '../../../core/router/route.dart';
import '../../../core/service/request/api_req.dart';
import '../shared/shared_pref.dart';

class AuthProvider extends StateNotifier<AuthStatus> {
  AuthProvider() : super(AuthStatus.unauthenticated);

  ApiReq apiReq = ApiReq();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<String?> login(String email, String password) async {
    try {
      final value = await apiReq.login({'email': email, 'password': password});

      if (value.statusCode == 200) {
        setAuthStatus(AuthStatus.loading);
        log(value.data.toString());
        SharedPreferencesHelper.setToken(value.data['token']);
        log('token: ${value.data['token']}');
        // Giriş isteği burada yapılabilir (HTTP isteği gibi)
        // Başarılı giriş durumunda state'i güncelle
        setAuthStatus(AuthStatus.authenticated);
        router.go('/home');
        emailController.clear();
        passwordController.clear();
        return null; // No error, successful login
      } else if (value.statusCode == 400) {
        log(value.data.toString());
        return 'Invalid email or password'; // Error message for invalid credentials
      } else {
        log(value.data.toString());
        return 'An error occurred during login'; // Generic error message
      }
    } on DioException catch (e) {
      return e.response!.data['error']
          .toString(); // Specific error message from the server
    } catch (e) {
      // Hata durumunda state'i güncelle
      log(e.toString());
      setAuthStatus(AuthStatus.error);
      return 'An unexpected error occurred';
    }
  }

  void logout() {
    // Çıkış işlemi
    SharedPreferencesHelper.removeToken();
    router.go('/login');
    setAuthStatus(AuthStatus.unauthenticated);
  }

  // Function to set the authentication status
  void setAuthStatus(AuthStatus status) {
    state = status;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
