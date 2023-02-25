import 'package:flutter/material.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/sizes_manager.dart';

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
    return Column(
      children: [
        AppBar(
          title: const Text('Update Password'),
          automaticallyImplyLeading: false,
          centerTitle: false,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.lg),
          child: Card(
            elevation: AppSize.s8,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppSize.s8),
                  child: TextField(
                    controller: _currentPasswordTextEditingController,
                    obscureText: _passwordIsObscured,
                    decoration: const InputDecoration(
                      hintText: 'Current Password',
                      prefixIcon: Icon(Icons.key),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSize.s8),
                  child: TextField(
                    controller: _newPasswordTextEditingController,
                    obscureText: _passwordIsObscured,
                    decoration: const InputDecoration(
                      hintText: 'New Password',
                      prefixIcon: Icon(Icons.key),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSize.s8),
                  child: TextField(
                    controller: _confirmPasswordTextEditingController,
                    obscureText: _passwordIsObscured,
                    decoration: const InputDecoration(
                      hintText: 'Re-type Password',
                      prefixIcon: Icon(Icons.key),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSize.s8),
                  child: CheckboxListTile(
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
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSize.s8),
                  child: SizedBox(
                    height: AppSize.s36,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Change Password'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
