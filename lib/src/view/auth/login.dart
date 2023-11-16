import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../proivder/all_prod.dart';

class LoginForm extends ConsumerWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStatus = ref.watch(authProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giriş Yap', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: SafeArea(
        child: Form(
          key: authStatus.formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: authStatus.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      labelText: 'E-mail', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Lütfen e-mail adresinizi giriniz';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: authStatus.passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                      labelText: 'Şifre', border: OutlineInputBorder()),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Lütfen şifrenizi giriniz';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48.0),
                  ),
                  child: const Text('Giriş Yap'),
                  onPressed: () async {
                    if (!authStatus.formKey.currentState!.validate()) {
                      return;
                    }

                    // Capture the context outside the async function

                    String? errorMessage = await authStatus.login(
                      authStatus.emailController.text,
                      authStatus.passwordController.text,
                    );
                    final scaffoldContext = context;

                    if (context.mounted) {
                      if (errorMessage != null) {
                        ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                          SnackBar(
                            content: Text(errorMessage),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
