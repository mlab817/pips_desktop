import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pips/presentation/resources/assets_manager.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../../resources/strings_manager.dart';

class AboutView extends StatefulWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !UniversalPlatform.isDesktopOrWeb,
        title: const Text(AppStrings.about),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: AppSize.s20,
            ),
            SvgPicture.asset(
              AssetsManager.svgLogoAsset,
              height: AppSize.s100,
            ),
            const SizedBox(height: AppSize.s20),
            Text(
              AppStrings.publicInvestmentProgramSystem,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSize.s20),
            const Text(
              AppStrings.aboutTheIpd,
              textAlign: TextAlign.start,
              style:
                  TextStyle(fontSize: FontSize.xl, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSize.s20),
            const Padding(
              padding: EdgeInsets.all(AppPadding.md),
              child: Text(
                AppStrings.ipdMandate,
              ),
            ),
            const SizedBox(height: AppSize.s20),
            const Text(
              'Developed by Mark Lester Bolotaolo',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
