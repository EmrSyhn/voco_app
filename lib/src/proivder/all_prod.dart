// Riverpod ile giriş durumunu yöneten provider

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/enum/enum.dart';
import '../controller/auth/user_login.dart';
import '../controller/home/home_controller.dart';

final authProvider = StateNotifierProvider<AuthProvider, AuthStatus>((ref) {
  return AuthProvider();
});

final homeProvivder = Provider<HomeController>((ref) => HomeController());
