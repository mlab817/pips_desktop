import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../resources/sizes_manager.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  late List<Widget> _screens;
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _screens = List.generate(3, (index) => _buildPage(index)).cast<Widget>();
  }

  @override
  void dispose() {
    super.dispose();

    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          itemCount: _screens.length,
          controller: _pageController,
          itemBuilder: (context, index) {
            return _screens[index];
      }, onPageChanged: (int index) {
            setState(() {
              _currentIndex = index;
            });
      },),
    );
  }

  Widget _buildPage(int index) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text("Page ${index.toString()}"),
          const SizedBox(height: AppSize.s20,),
          TextButton(onPressed: () {
            Navigator.pushNamed(context, Routes.mainRoute);
          }, child: const Text('Go to Main'))
        ],
      ),
    );
  }
}
