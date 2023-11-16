import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voco_app/core/router/route.dart';
import '../../../core/enum/enum.dart';
import '../../controller/shared/shared_pref.dart';
import '../../proivder/all_prod.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
        future: SharedPreferencesHelper.getToken(),
        builder: (context, snapshot) {
          Future.delayed(const Duration(seconds: 2), () {
            final token = snapshot.data;
            if (token != null) {
              ref
                  .read(authProvider.notifier)
                  .setAuthStatus(AuthStatus.authenticated);

              router.go('/home');
            } else {
              router.go('/login');
            }
          });
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Image.asset('assets/voco_mobile_app_cover.png',
                  fit: BoxFit.cover),
            ),
          );
        });
  }
}
