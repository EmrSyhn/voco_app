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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: textFieldWidget(
                    controller: authStatus.emailController,
                    keyboardType: TextInputType.emailAddress,
                    icon: Icons.email,
                    labelText: 'E-mail',
                  ),
                ),
                const SizedBox(height: 8.0),
                Card(
                  child: textFieldWidget(
                    controller: authStatus.passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    icon: Icons.password,
                    labelText: 'Şifre',
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 8.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48.0),
                    elevation: 2, // Add elevation to the button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('Giriş Yap'),
                  onPressed: () async {
                    if (!authStatus.formKey.currentState!.validate()) {
                      return;
                    }

                    String? errorMessage = await authStatus.login(
                      authStatus.emailController.text,
                      authStatus.passwordController.text,
                    );

                    if (context.mounted) {
                      if (errorMessage != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
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

  TextFormField textFieldWidget({
    TextEditingController? controller,
    TextInputType? keyboardType,
    required IconData icon,
    String? labelText,
    bool obscureText = false,
  }) {
    return TextFormField(
        controller: controller,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
            icon: Icon(icon), labelText: labelText, border: InputBorder.none),
        obscureText: obscureText,
        validator: globalValidator);
  }

  String? globalValidator(String? value) {
    if (value!.isEmpty) {
      return 'Lütfen bu alanı doldurunuz';
    }
    return null;
  }
}
