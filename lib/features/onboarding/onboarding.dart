import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pips/routing/routing.dart';
import 'package:pips/common/resources/sizes_manager.dart';
import 'package:pips/common/domain/repository/repository.dart';

import '../../app/dep_injection.dart';
import '../../common/resources/assets_manager.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  final Repository _repository = instance<Repository>();
  int _currentIndex = 0;

  bool _viewOnboardingScreen = false;

  final List<OnboardingPage> _screens = [
    OnboardingPage(
      title: 'Manage PAPs',
      description: 'View and Download PAPs',
      lottieAnimation: AssetsManager.projects,
    ),
    OnboardingPage(
      title: 'Connect with other users',
      description: 'Chat other users in real-time',
      lottieAnimation: AssetsManager.chat,
    ),
    OnboardingPage(
      title: 'Manage notifications',
      description: 'Never miss anything again',
      lottieAnimation: AssetsManager.notifications,
    ),
    OnboardingPage(
      title: 'Manage Profile',
      description: 'Manage your profile and password here',
      lottieAnimation: AssetsManager.profile,
    ),
  ];

  @override
  void dispose() {
    super.dispose();

    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: _screens.length,
              controller: _pageController,
              itemBuilder: (context, index) {
                return _buildPage(index);
              },
              onPageChanged: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _viewOnboardingScreen = !_viewOnboardingScreen;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Checkbox(
                  value: _viewOnboardingScreen,
                  onChanged: (bool? value) {
                    setState(() {
                      _viewOnboardingScreen = value ?? false;
                    });
                  },
                ),
                const Text('Don\'t show this again'),
                const SizedBox(
                  width: AppSize.md,
                ),
              ],
            ),
          ),
          _buildBottomNavigation()
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: AppSize.s80,
          child: IconButton(
            onPressed: _currentIndex > 0
                ? () {
                    if (_currentIndex == 0) {
                      return;
                    }
                    setState(() {
                      --_currentIndex;
                    });
                    _pageController.jumpToPage(_currentIndex);
                  }
                : null,
            icon: const Icon(Icons.chevron_left),
          ),
        ),
        Flexible(
            child: Row(
          mainAxisSize: MainAxisSize.min,
          children: _screens.asMap().entries.map((e) {
            return Padding(
              padding: const EdgeInsets.all(AppPadding.md),
              child: Icon(
                _currentIndex == e.key
                    ? Icons.circle_rounded
                    : Icons.circle_outlined,
                size: AppSize.lg,
              ),
            );
          }).toList(),
        )),
        SizedBox(
          width: AppSize.s80,
          child: _currentIndex < _screens.length - 1
              ? IconButton(
                  onPressed: () {
                    if (_currentIndex == _screens.length - 1) {
                      return;
                    }
                    setState(() {
                      _currentIndex++;
                    });
                    _pageController.jumpToPage(_currentIndex);
                  },
                  icon: const Icon(Icons.chevron_right),
                )
              : TextButton(
                  onPressed: () async {
                    await _repository
                        .setIsOnboardingScreenViewed(_viewOnboardingScreen);

                    _goToLoginRoute();
                  },
                  child: const Text('START')),
        ),
      ],
    );
  }

  Widget _buildPage(int index) {
    var screenSize = MediaQuery.of(context).size;

    final screen = _screens[index];

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            screen.title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          SizedBox(
              height: screenSize.height / 3,
              child: LottieBuilder.asset(screen.lottieAnimation)),
          const SizedBox(
            height: AppSize.s20,
          ),
          Padding(
            padding: const EdgeInsets.all(AppSize.md),
            child: Text(
              screen.description,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  void _goToLoginRoute() {
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }
}

class OnboardingPage {
  String title;

  String description;

  String lottieAnimation;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.lottieAnimation,
  });
}
