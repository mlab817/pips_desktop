import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pips_desktop/presentation/resources/color_manager.dart';
import 'package:pips_desktop/presentation/resources/font_manager.dart';
import 'package:pips_desktop/presentation/resources/sizes_manager.dart';
import 'package:pips_desktop/presentation/resources/strings_manager.dart';

import '../../resources/assets_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SizedBox(
            width: screenSize.width / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AssetsManager.svgLogoAsset,
                  height: AppSize.s80,
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Text(
                  AppStrings.publicInvestmentProgramSystem,
                  style: TextStyle(
                    fontSize: AppSize.s32,
                    color: ColorManager.primary,
                    fontFamily: FontFamily.bebasNeue,
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                const Text(
                  AppStrings.loginToYourAccount,
                  style: TextStyle(
                    fontSize: AppSize.s18,
                  ),
                ),
                const SizedBox(
                  height: AppSize.s40,
                ),
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: AppStrings.username,
                  ),
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.key),
                    hintText: AppStrings.password,
                  ),
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                SizedBox(
                  height: AppSize.s36,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.primary),
                    child: const Text(
                      AppStrings.submit,
                      style: TextStyle(fontSize: AppSize.s14),
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s40,
                ),
                TextButton(
                  onPressed: () {
                    // debugPrint('forgot password');
                  },
                  child: const Text(AppStrings.forgotPassword),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() {
    debugPrint('login clicked');
  }
}
