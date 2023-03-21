import 'package:flutter/material.dart';
import 'package:pips/data/requests/forgot_password/forgot_password_request.dart';
import 'package:pips/domain/usecase/forgot_password_usecase.dart';

import '../../app/dep_injection.dart';
import '../resources/sizes_manager.dart';
import '../resources/strings_manager.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ForgotPasswordUseCase _useCase = instance<ForgotPasswordUseCase>();

  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
  }

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
                      controller: _emailController,
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

  Future<void> _sendPasswordResetLink() async {
    final response = await _useCase
        .execute(ForgotPasswordRequest(email: _emailController.text));

    // 'Password reset link sent!'
    if (response.success) {
      _showSnackbar(response.data?.status ?? 'Success!');
    } else {
      _showSnackbar(response.error ?? 'Something went wrong');
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
