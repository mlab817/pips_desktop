import 'package:flutter/material.dart';

import '../../resources/sizes_manager.dart';
import '../../resources/strings_manager.dart';

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
        title: const Text(AppStrings.forgotPassword),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.lg),
          child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: AppSize.s480),
              child: ListView(
                shrinkWrap: true,
                children: [
                  const Text(AppStrings.forgotPasswordMesssage),
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
                    child: const Text(AppStrings.sendPasswordResetLink),
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
