/// Splash screen determines which route to show first. Show also status of retrieval of data.
/// First is onboarding screen but determine first if the user has disabled its viewing or not.
/// After onboarding, go to login page but if user is already logged in, proceed to main.
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:pips/common/domain/repository/repository.dart';
import 'package:pips/common/resources/assets_manager.dart';

import '../../common/resources/font_manager.dart';
import '../../common/resources/sizes_manager.dart';
import '../../common/resources/strings_manager.dart';
import '../../routing/routing.dart';
import '../authentication/data/providers/auth_provider.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  Timer? _timer;
  final Repository _repository = instance<Repository>();

  _startDelay() {
    _timer = Timer(Duration.zero, _goNext);
  }

  /// check if the user is currently logged in
  /// if yes, set it to [AuthState] and push to mainRoute
  /// else check if user has viewed onboarding screen, if not
  /// return onboardingScreen, else go to login directly
  Future<void> _goNext() async {
    // retrieve a notifier for auth state
    _repository.getLoggedInUser().then((loggedInUser) => {
          if (loggedInUser != null)
            {
              // if user is logged in, set it as current user
              ref.read(authState.notifier).setCurrentUser(loggedInUser),
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

  // build splash screen with logo and system name
  Widget _buildSplash() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ClipOval(
            child: Image(
              image: ResizeImage(
                AssetImage(AssetsManager.logo),
                height: 100,
                width: 100,
              ),
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
