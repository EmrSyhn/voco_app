// Riverpod ile giriş durumunu yöneten provider
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/enum/enum.dart';
import '../controller/auth/user_login.dart';

final authProvider = StateNotifierProvider<AuthProvider, AuthStatus>((ref) {
  return AuthProvider();
});
