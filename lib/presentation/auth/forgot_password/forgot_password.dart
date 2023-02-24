import 'package:flutter/material.dart';

import '../../resources/sizes_manager.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.lg),
          child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: AppSize.s480),
              child: ListView(
                shrinkWrap: true,
                children: [
                  const Text(
                      'Forgot your password? No problem. Just let us know your email address and we will email you a password reset link that will allow you to choose a new one.'),
                  const SizedBox(height: AppSize.s20),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email address is required.';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Email address',
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSize.s20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _sendPasswordResetLink();
                      }
                    },
                    child: const Text('Send password reset link'),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  void _sendPasswordResetLink() {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset link sent!')));
  }
}
