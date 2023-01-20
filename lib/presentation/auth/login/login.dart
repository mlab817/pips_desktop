import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pips/app/routes.dart';
import 'package:pips/presentation/resources/color_manager.dart';
import 'package:pips/presentation/resources/font_manager.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';
import 'package:pips/presentation/resources/strings_manager.dart';

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
                  textAlign: TextAlign.center,
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
                    labelText: AppStrings.username,
                    prefixIcon: Icon(Icons.person),
                    hintText: AppStrings.username,
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: AppStrings.password,
                    prefixIcon: Icon(Icons.key),
                    hintText: AppStrings.password,
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                SizedBox(
                  height: AppSize.s36,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.primary),
                    child: const Text(
                      AppStrings.login,
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s40,
                ),
                TextButton(
                  onPressed: _goToForgotPassword,
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
    // TODO: implement login flow
    Navigator.pushNamed(context, Routes.mainRoute);
  }

  void _goToForgotPassword() {
    Navigator.pushNamed(context, Routes.forgotPasswordRoute);
  }
}
