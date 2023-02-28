import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:pips/app/app_preferences.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:pips/presentation/resources/assets_manager.dart';
import 'package:pips/presentation/resources/color_manager.dart';
import 'package:pips/presentation/resources/font_manager.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';
import 'package:pips/presentation/resources/strings_manager.dart';

import '../../app/routes.dart';

Stream<double> progressCounter() async* {
  int i = 0;

  while (true) {
    await Future.delayed(const Duration(milliseconds: 50));
    yield i++ / 100;
    if (i > 100) break;
  }
}

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final _streamController = StreamController<double>();

  void _startProgress() {
    progressCounter().pipe(_streamController.sink);

    _appPreferences.getIsUserLoggedIn().then((isUserLoggedIn) => {
          debugPrint("isUserLoggedIn: ${isUserLoggedIn.toString()}"),
          if (isUserLoggedIn)
            {
              // handle logged in
              Navigator.pushReplacementNamed(context, Routes.onboardingRoute),
            }
          else
            {
              // handle not logged in
              Navigator.pushReplacementNamed(context, Routes.loginRoute),
            }
        });
  }

  @override
  void initState() {
    super.initState();

    _startProgress();
  }

  @override
  void dispose() {
    super.dispose();

    _streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<double>(
          stream: _streamController.stream,
          // progressCounter(), // loadDataFromCsv(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Future.delayed(Duration.zero, () {
                Navigator.pushNamed(context, Routes.loginRoute);
              });

              // return Text(snapshot.data?.toString() ?? "");
            } else if (snapshot.hasData && snapshot.data != null) {
              return Center(
                child: SizedBox(
                  height: AppSize.s100,
                  width: AppSize.s100,
                  child: LiquidCircularProgressIndicator(
                    value: snapshot.data ?? 0,
                    backgroundColor: ColorManager.white,
                    direction: Axis.vertical,
                    center: Text(
                      '${(snapshot.data! * 100).toStringAsFixed(0)}%',
                      style: TextStyle(
                        color: ColorManager.gray,
                        fontSize: AppSize.s20,
                      ),
                    ),
                    valueColor: AlwaysStoppedAnimation(ColorManager.primary),
                  ),
                ),
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AssetsManager.svgLogoAsset,
                    height: AppSize.s100,
                  ),
                  const SizedBox(
                    height: AppSize.s36,
                  ),
                  Text(
                    AppStrings.publicInvestmentProgrammingSystem,
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                          color: ColorManager.primary,
                          fontFamily: FontFamily.bebasNeue,
                          fontSize: AppSize.s32,
                        ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
