import 'package:flutter/material.dart';
import 'package:pips/features/settings/domain/usecase/updatepassword_usecase.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../../app/dep_injection.dart';
import '../../../common/resources/sizes_manager.dart';
import '../../../common/resources/strings_manager.dart';
import '../../../common/widgets/loading_overlay.dart';
import '../data/requests/updatepassword_request/updatepassword_request.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({Key? key}) : super(key: key);

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordTextEditingController =
      TextEditingController();
  final TextEditingController _newPasswordTextEditingController =
      TextEditingController();
  final TextEditingController _confirmPasswordTextEditingController =
      TextEditingController();
  final UpdatePasswordUseCase _updatePasswordUseCase =
      instance<UpdatePasswordUseCase>();

  bool _passwordIsShown = false;

  @override
  void dispose() {
    _currentPasswordTextEditingController.dispose();
    _newPasswordTextEditingController.dispose();
    _confirmPasswordTextEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !UniversalPlatform.isDesktopOrWeb,
        title: const Text(AppStrings.updatePassword),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.md),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _currentPasswordTextEditingController,
                  obscureText: !_passwordIsShown,
                  decoration: const InputDecoration(
                    labelText: AppStrings.currentPassword,
                    // prefixIcon: Icon(Icons.key),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.thisFieldIsRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                TextFormField(
                  controller: _newPasswordTextEditingController,
                  obscureText: !_passwordIsShown,
                  decoration: const InputDecoration(
                    labelText: AppStrings.newPassword,
                    // prefixIcon: Icon(Icons.key),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.thisFieldIsRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                TextFormField(
                  controller: _confirmPasswordTextEditingController,
                  obscureText: !_passwordIsShown,
                  decoration: const InputDecoration(
                    labelText: AppStrings.retypePassword,
                    // prefixIcon: Icon(Icons.key),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.thisFieldIsRequired;
                    }
                    if (value != _newPasswordTextEditingController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                CheckboxListTile(
                  value: _passwordIsShown,
                  title: const Text(AppStrings.showPassword),
                  onChanged: (value) {
                    setState(() {
                      _passwordIsShown = value ?? false;
                    });
                  },
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                SizedBox(
                  height: AppSize.s36,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _updatePassword();

                        return;
                      }

                      _showSnackbar(AppStrings.pleaseCheckYourInputs);
                    },
                    child: const Text(AppStrings.submit),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updatePassword() async {
    showDialog(
        context: context,
        builder: (context) {
          return const LoadingOverlay();
        });

    (await _updatePasswordUseCase.execute(UpdatePasswordRequest(
      currentPassword: _currentPasswordTextEditingController.text,
      password: _newPasswordTextEditingController.text,
      passwordConfirmation: _confirmPasswordTextEditingController.text,
    )))
        .fold((failure) {
      _showSnackbar(failure.message);
      _popContext();
    }, (response) {
      _showSnackbar(response.message);
      _popContext();
      _clearInputs();
    });
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _popContext() {
    Navigator.pop(context);
  }

  void _clearInputs() {
    _currentPasswordTextEditingController.clear();
    _newPasswordTextEditingController.clear();
    _confirmPasswordTextEditingController.clear();
  }
}
