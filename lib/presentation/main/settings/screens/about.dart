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
              'Developed by Mark Lester Bolotaolo \nfor the Investment Programming Division',
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
                'The IPD leads the conduct of the investment programming and prioritization activities for the DA. Considering the present state of the Philippine economy and the daunting task to modernize the sector, it is imperative to rationalize resource allocation and prioritize interventions with clear development strategies. The IPD finalized and institutionalized the Public Investment Programming (PIP) System and resource allocation scheme for the agriculture and fishery sector nationwide. The PIP system enables the DA to optimize the use of limited resources through a rational investment program. Further, the IPD leads the preparation of the sector’s investment plan in the medium term.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
