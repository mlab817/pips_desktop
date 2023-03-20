import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pips/app/routes.dart';

import '../resources/assets_manager.dart';
import '../resources/sizes_manager.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingPage> _screens = [
    OnboardingPage(
      title: 'Manage PAPs',
      description: '',
      lottieAnimation: AssetsManager.projects,
    ),
    OnboardingPage(
      title: 'Connect with other users',
      description: '',
      lottieAnimation: AssetsManager.chat,
    ),
    OnboardingPage(
      title: 'Manage notifications',
      description: '',
      lottieAnimation: AssetsManager.notifications,
    ),
    OnboardingPage(
      title: 'Manage Profile',
      description: '',
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
      body: SingleChildScrollView(
        child: Column(
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
            _buildBottomNavigation()
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
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
        _currentIndex < _screens.length - 1
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
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.mainRoute);
                },
                child: const Text('Proceed')),
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
          SizedBox(
              height: screenSize.height / 2,
              child: LottieBuilder.asset(screen.lottieAnimation)),
          const SizedBox(
            height: AppSize.s20,
          ),
          Text(
            screen.title!,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}

class OnboardingPage {
  String? title;

  String description;

  String lottieAnimation;

  OnboardingPage({
    this.title,
    required this.description,
    required this.lottieAnimation,
  });
}
