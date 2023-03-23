import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:pips/app/routes.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/login_usecase.dart';
import 'package:pips/presentation/resources/font_manager.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';
import 'package:pips/presentation/resources/strings_manager.dart';
import 'package:universal_platform/universal_platform.dart';

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

  String? _deviceToken;

  bool _passwordIsObscured = true;

  Future<void> _loadDeviceToken() async {
    if (!UniversalPlatform.isAndroid) return;

    final FirebaseMessaging messaging = FirebaseMessaging.instance;

    // If not initialized, initialize the default Firebase app
    final fcmToken = await messaging.getToken().onError((error, stackTrace) {
      print(error.toString());
      return null;
    });

    debugPrint(fcmToken);

    if (!mounted) return;

    setState(() {
      _deviceToken = fcmToken;
    });
  }

  @override
  void initState() {
    super.initState();

    _loadDeviceToken();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    height: AppSize.s100,
                  ),
                  const SizedBox(
                    height: AppSize.s30,
                  ),
                  Text(
                    AppStrings.publicInvestmentProgramSystem,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontFamily: FontFamily.bebasNeue,
                          color: Theme.of(context).colorScheme.primary,
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
                        return AppStrings.usernameIsRequired;
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
                        return AppStrings.passwordIsRequired;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      // labelText: AppStrings.password,
                      prefixIcon: const Icon(Icons.key),
                      hintText: AppStrings.password,
                      suffixIcon: IconButton(
                        onPressed: _togglePasswordVisibility,
                        icon: Icon(_passwordIsObscured
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  // TODO: Reminder to change height of ElevatedButton to 36
                  SizedBox(
                    height: AppSize.s36,
                    width: AppSize.s100,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _login();
                        } else {
                          _showSnackbar(AppStrings.pleaseCheckYourInputs);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.login),
                          SizedBox(width: AppSize.md),
                          Text(
                            AppStrings.login,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s60,
                  ),
                  TextButton(
                    onPressed: _goToForgotPassword,
                    child: const Text(AppStrings.forgotPassword),
                  ),
                  Divider(
                    color: Theme.of(context).dividerColor,
                  ),
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
            // backgroundColor: Colors.transparent,
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
        .execute(
          LoginRequest(
            username: _usernameController.text,
            password: _passwordController.text,
            deviceToken: _deviceToken,
          ),
        )
        .then((Result<LoginResponse> value) => {
              if (value.success)
                {
                  _repository.setIsUserLoggedIn(),
                  _repository.setLoggedInUser(value.data?.user ?? "" as User),
                  _repository.setImageUrl(value.data?.user.imageUrl ?? ""),
                  _repository.setBearerToken(value.data?.accessToken ?? ""),
                  resetModules(),
                  // request permission for fcm
                  Navigator.of(context).pop(),
                  _goToMainRoute(),
                }
              else
                {
                  Navigator.of(context).pop(),
                  _showSnackbar(value.error ?? AppStrings.somethingWentWrong),
                }
            });
  }

  void _requestPermission() {
    //
  }

  void _goToForgotPassword() {
    Navigator.pushNamed(context, Routes.forgotPasswordRoute);
  }

  void _goToSignUp() {
    Navigator.pushNamed(context, Routes.signUpRoute);
  }

  void _goToMainRoute() {
    Navigator.pushReplacementNamed(
      context,
      Routes.mainRoute,
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _togglePasswordVisibility() {
    setState(() {
      _passwordIsObscured = !_passwordIsObscured;
    });
  }
}
