import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/enum/enum.dart';

class AuthProvider extends StateNotifier<AuthStatus> {
  AuthProvider() : super(AuthStatus.authenticated);

  Future<void> login(String username, String password) async {
    try {
      // Giriş isteği burada yapılabilir (HTTP isteği gibi)
      // Başarılı giriş durumunda state'i güncelle
      state = AuthStatus.authenticated;
    } catch (e) {
      // Hata durumunda state'i güncelle
      state = AuthStatus.error;
    }
  }

  void logout() {
    // Çıkış işlemi
    state = AuthStatus.unauthenticated;
  }
}
