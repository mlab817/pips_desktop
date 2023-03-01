import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../../resources/color_manager.dart';
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

  bool _passwordIsObscured = true;

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
      appBar: !UniversalPlatform.isDesktopOrWeb
          ? AppBar(
              title: const Text(AppStrings.updatePassword),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.only(top: AppPadding.lg),
        child: Column(
          children: [
            ListTile(
              minLeadingWidth: AppSize.s150,
              leading: UniversalPlatform.isDesktopOrWeb
                  ? const Text('Current Password: ')
                  : null,
              title: TextFormField(
                controller: _currentPasswordTextEditingController,
                obscureText: _passwordIsObscured,
                decoration: const InputDecoration(
                  hintText: 'Current Password',
                  prefixIcon: Icon(Icons.key),
                ),
              ),
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            ListTile(
              minLeadingWidth: AppSize.s150,
              leading: UniversalPlatform.isDesktopOrWeb
                  ? const Text('New Password')
                  : null,
              title: TextFormField(
                controller: _newPasswordTextEditingController,
                obscureText: _passwordIsObscured,
                decoration: const InputDecoration(
                  hintText: 'New Password',
                  prefixIcon: Icon(Icons.key),
                ),
              ),
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            ListTile(
              minLeadingWidth: AppSize.s150,
              leading: UniversalPlatform.isDesktopOrWeb
                  ? const Text('Re-type Password')
                  : null,
              title: TextFormField(
                controller: _confirmPasswordTextEditingController,
                obscureText: _passwordIsObscured,
                decoration: const InputDecoration(
                  hintText: 'Re-type Password',
                  prefixIcon: Icon(Icons.key),
                ),
              ),
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            CheckboxListTile(
              value: _passwordIsObscured,
              activeColor: ColorManager.primary,
              title: const Text('Show Password'),
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) {
                setState(() {
                  _passwordIsObscured = value ?? false;
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
                child: const Text('Change Password'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
