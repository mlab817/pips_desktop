import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pips/common/domain/repository/repository.dart';
import 'package:pips/common/resources/font_manager.dart';
import 'package:pips/common/resources/sizes_manager.dart';
import 'package:pips/common/resources/strings_manager.dart';
import 'package:pips/features/authentication/domain/usecase/login_usecase.dart';
import 'package:pips/routing/routing.dart';

import '../../../../app/config.dart';
import '../../../../app/dep_injection.dart';
import '../../../../common/resources/assets_manager.dart';
import '../../data/requests/login_request/login_request.dart';

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

  String? _playerId;

  void _initializeOneSignal() {
    try {
      //Remove this method to stop OneSignal Debugging
      OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

      OneSignal.shared.setAppId(Config.oneSignalAppId);

      // if oneSignal is supported, retrieve playerId
      _retrievePlayerId();
    } on MissingPluginException catch (e) {
      debugPrint(e.message);
    }
  }

  Future<void> _retrievePlayerId() async {
    try {
      var deviceState = await OneSignal.shared.getDeviceState();

      if (deviceState == null || deviceState.userId == null) {
        return;
      }

      if (!mounted) {
        return;
      }

      setState(() {
        _playerId = deviceState.userId!;
      });
    } on MissingPluginException catch (e) {
      debugPrint(e.message);
    }
  }

  @override
  void initState() {
    super.initState();

    _initializeOneSignal();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return const EnableTouchIdView();

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
                  SizedBox(
                    height: AppSize.s60,
                    width: double.infinity,
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
    (await _loginUseCase.execute(
      LoginRequest(
        username: _usernameController.text,
        password: _passwordController.text,
        onesignalPlayerId: _playerId,
      ),
    ))
        .fold((failure) {
      Navigator.of(context).pop();
      _showSnackbar(failure.message);
    }, (response) {
      _repository.setIsUserLoggedIn();
      _repository.setLoggedInUser(response.user);
      _repository.setImageUrl(response.user.imageUrl ?? "");
      _repository.setBearerToken(response.accessToken);
      // save to one signal then to laravel app
      resetModules();
      // request permission for fcm
      Navigator.of(context).pop();
      _goToMainRoute();
    });
  }

  void _requestPermission() {
    //
    // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt.
    // We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });
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
