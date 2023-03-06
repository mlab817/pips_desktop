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
  final TextEditingController _currentPasswordTextEditingController =
      TextEditingController();
  final TextEditingController _newPasswordTextEditingController =
      TextEditingController();
  final TextEditingController _confirmPasswordTextEditingController =
      TextEditingController();

  bool _passwordIsShown = true;

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
      body: Padding(
        padding: const EdgeInsets.only(top: AppPadding.lg),
        child: Column(
          children: [
            ListTile(
              title: TextFormField(
                controller: _currentPasswordTextEditingController,
                obscureText: !_passwordIsShown,
                decoration: const InputDecoration(
                  hintText: AppStrings.currentPassword,
                  labelText: AppStrings.currentPassword,
                  prefixIcon: Icon(Icons.key),
                ),
              ),
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            ListTile(
              title: TextFormField(
                controller: _newPasswordTextEditingController,
                obscureText: !_passwordIsShown,
                decoration: const InputDecoration(
                  hintText: AppStrings.newPassword,
                  labelText: AppStrings.newPassword,
                  prefixIcon: Icon(Icons.key),
                ),
              ),
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            ListTile(
              title: TextFormField(
                controller: _confirmPasswordTextEditingController,
                obscureText: !_passwordIsShown,
                decoration: const InputDecoration(
                  hintText: AppStrings.retypePassword,
                  labelText: AppStrings.retypePassword,
                  prefixIcon: Icon(Icons.key),
                ),
              ),
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
                onPressed: () {},
                child: const Text(AppStrings.submit),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
