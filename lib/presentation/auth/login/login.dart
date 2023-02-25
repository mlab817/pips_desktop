import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:pips/app/routes.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/login_usecase.dart';
import 'package:pips/presentation/resources/font_manager.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';
import 'package:pips/presentation/resources/strings_manager.dart';

import '../../../app/dep_injection.dart';
import '../../../data/requests/login/login_request.dart';
import '../../../data/responses/login/login_response.dart';
import '../../../domain/models/user.dart';
import '../../../domain/usecase/base_usecase.dart';
import '../../resources/assets_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final Repository _repository = instance<Repository>();
  final LoginUseCase _loginUseCase = instance<LoginUseCase>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        child: Padding(
          padding: const EdgeInsets.all(AppSize.s10),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppSize.s400,
            ),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  SvgPicture.asset(
                    AssetsManager.svgLogoAsset,
                    height: AppSize.s50,
                  ),
                  const SizedBox(
                    height: AppSize.s12,
                  ),
                  const Text(
                    AppStrings.publicInvestmentProgrammingSystem,
                    style: TextStyle(
                      fontSize: AppSize.s20,
                      fontFamily: FontFamily.bebasNeue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: AppSize.s40,
                  ),
                  TextFormField(
                    controller: _usernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username is required';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      // labelText: AppStrings.username,
                      prefixIcon: Icon(Icons.alternate_email),
                      hintText: AppStrings.username,
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _passwordIsObscured,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      // labelText: AppStrings.password,
                      prefixIcon: const Icon(Icons.key),
                      hintText: AppStrings.password,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _passwordIsObscured = !_passwordIsObscured;
                          });
                        },
                        icon: Icon(_passwordIsObscured
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
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
                          _login();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please check your inputs!')));
                        }
                      },
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
                  const Divider(),
                  TextButton(
                    onPressed: _goToSignUp,
                    child: const Text(AppStrings.signUp),
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
    showDialog(
        barrierColor: Colors.transparent,
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            clipBehavior: Clip.hardEdge,
            elevation: AppSize.s0,
            insetPadding: EdgeInsets.zero,
            child: Center(
              child: Lottie.asset(
                AssetsManager.fingerprintJson,
                width: AppSize.s100,
                height: AppSize.s100,
                repeat: false,
              ),
            ),
          );
        });
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
                  Navigator.of(context).pop(),
                }
              else
                {debugPrint('Failed')}
            });
  }

  void _goToForgotPassword() {
    Navigator.pushNamed(context, Routes.forgotPasswordRoute);
  }

  void _goToSignUp() {
    Navigator.pushNamed(context, Routes.signUpRoute);
  }

  void _togglePasswordVisibility() {
    setState(() {
      _passwordIsObscured = !_passwordIsObscured;
    });
  }
}
