import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pips/app/routes.dart';
import 'package:pips/data/requests/login/login_request.dart';
import 'package:pips/data/responses/login/login_response.dart';
import 'package:pips/domain/models/user.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';
import 'package:pips/domain/usecase/login_usecase.dart';
import 'package:pips/presentation/resources/color_manager.dart';
import 'package:pips/presentation/resources/font_manager.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';
import 'package:pips/presentation/resources/strings_manager.dart';

import '../../../app/dep_injection.dart';
import '../../resources/assets_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final Repository _repository = instance<Repository>();
  final LoginUseCase _loginUseCase = instance<LoginUseCase>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _passwordIsObscured = true;

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Card(
          color: ColorManager.white,
          child: Padding(
            padding: const EdgeInsets.all(AppSize.s10),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppSize.s400,
                maxHeight: AppSize.s360,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AssetsManager.svgLogoAsset,
                    height: AppSize.s60,
                  ),
                  const SizedBox(
                    height: AppSize.s12,
                  ),
                  Text(
                    AppStrings.publicInvestmentProgramSystem,
                    style: TextStyle(
                      fontSize: AppSize.s20,
                      color: ColorManager.primary,
                      fontFamily: FontFamily.bebasNeue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: AppSize.s12,
                  ),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      // labelText: AppStrings.username,
                      prefixIcon: Icon(Icons.person),
                      hintText: AppStrings.username,
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s12,
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: _passwordIsObscured,
                    decoration: InputDecoration(
                      // labelText: AppStrings.password,
                      prefixIcon: const Icon(Icons.key),
                      hintText: AppStrings.password,
                      suffixIcon: _passwordIsObscured
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s12,
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
                    height: AppSize.s20,
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
      ),
    );
  }

  void _login() async {
    _loginUseCase
        .execute(LoginRequest(
            username: _usernameController.text,
            password: _passwordController.text))
        .then((Result<LoginResponse> value) => {
              if (value.success)
                {
                  Navigator.pushNamed(context, Routes.mainRoute),
                  _repository.setIsUserLoggedIn(),
                  _repository
                      .setLoggedInUser(value.data?.user ?? "" as UserModel),
                  _repository.setBearerToken(value.data?.accessToken ?? ""),
                  resetModules(),
                }
            });
  }

  void _goToForgotPassword() {
    Navigator.pushNamed(context, Routes.forgotPasswordRoute);
  }

  void _togglePasswordVisibility() {
    setState(() {
      _passwordIsObscured = !_passwordIsObscured;
    });
  }
}
