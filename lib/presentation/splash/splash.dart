/// Splash screen determines which route to show first. Show also status of retrieval of data.
/// First is onboarding screen but determine first if the user has disabled its viewing or not.
/// After onboarding, go to login page but if user is already logged in, proceed to main.
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/presentation/resources/assets_manager.dart';
import 'package:pips/presentation/resources/font_manager.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';
import 'package:pips/presentation/resources/strings_manager.dart';

import '../../app/routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final Repository _repository = instance<Repository>();

  _startDelay() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  Future<void> _goNext() async {
    _repository.getIsUserLoggedIn().then((isUserLoggedIn) => {
          if (isUserLoggedIn)
            {
              // navigate to main screen
              Navigator.pushReplacementNamed(context, Routes.mainRoute)
            }
          else
            {
              _repository
                  .getIsOnboardingScreenViewed()
                  .then((isOnBoardingScreenViewed) => {
                        if (isOnBoardingScreenViewed)
                          {
                            Navigator.pushReplacementNamed(
                                context, Routes.loginRoute)
                          }
                        else
                          {
                            Navigator.pushReplacementNamed(
                                context, Routes.onboardingRoute)
                          }
                      })
            }
        });
  }

  @override
  void initState() {
    super.initState();

    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSplash(),
    );
  }

  Widget _buildSplash() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.asset(
              AssetsManager.logo,
              height: AppSize.s100,
            ),
          ),
          const SizedBox(
            height: AppSize.s36,
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.md),
            child: Text(
              AppStrings.publicInvestmentProgramSystem,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontFamily: FontFamily.bebasNeue,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
