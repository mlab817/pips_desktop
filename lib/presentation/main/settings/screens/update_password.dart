import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../../resources/sizes_manager.dart';
import '../../../resources/strings_manager.dart';

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

  bool _passwordIsShown = false;

  @override
  void dispose() {
    super.dispose();

    _currentPasswordTextEditingController.dispose();
    _newPasswordTextEditingController.dispose();
    _confirmPasswordTextEditingController.dispose();
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
                    prefixIcon: Icon(Icons.key),
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
                    prefixIcon: Icon(Icons.key),
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
                    prefixIcon: Icon(Icons.key),
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
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Validated!')));
                      }
                      return;
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
}
