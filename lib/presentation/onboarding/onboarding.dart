import 'package:flutter/material.dart';

import '../../app/routes.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {

  @override
  void initState() {
    super.initState();

    // handle routing if onboarded already
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: const Text('Go to Main'),
          onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.mainRoute);
          },
        ),
      ),
    );
  }
}
