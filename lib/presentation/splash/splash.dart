import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pips/app/routes.dart';
import 'package:pips/presentation/resources/assets_manager.dart';
import 'package:pips/presentation/resources/color_manager.dart';
import 'package:pips/presentation/resources/font_manager.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';
import 'package:pips/presentation/resources/strings_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  void _goNext() {
    _timer = Timer(const Duration(seconds: 2), () {
      Navigator.pushNamed(context, Routes.loginRoute);
    });
  }

  @override
  void initState() {
    super.initState();
    _goNext();
  }

  @override
  void dispose() {
    super.dispose();

    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.white,
      child: Center(
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
              AppStrings.publicInvestmentProgramSystem,
              style: Theme.of(context).textTheme.headline1?.copyWith(
                    color: ColorManager.primary,
                    fontFamily: FontFamily.bebasNeue,
                    fontSize: AppSize.s32,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
