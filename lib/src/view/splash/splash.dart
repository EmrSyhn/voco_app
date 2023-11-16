import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/enum/enum.dart';
import '../../proivder/all_prod.dart';
import '../auth/login.dart';
import '../home/home_page.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStatus = ref.watch(authProvider);
    log('authStatus: $authStatus');
    switch (authStatus) {
      case AuthStatus.loading:
        return const CircularProgressIndicator();
      case AuthStatus.authenticated:
        return const HomePage();
      case AuthStatus.error:
        return const Text('Giriş hatası');
      default:
        return const LoginForm();
    }
  }
}
