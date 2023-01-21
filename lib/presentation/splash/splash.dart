import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  final _streamController = StreamController<double>();

  void _startProgress() {
    progressCounter().pipe(_streamController.sink);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startProgress();
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
                Navigator.pushNamed(context, Routes.mainRoute);
              });

              // return Text(snapshot.data?.toString() ?? "");
            } else if (snapshot.hasData && snapshot.data != null) {
              return Center(
                child: SizedBox(
                  height: AppSize.s100,
                  width: AppSize.s100,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: AppSize.s100,
                        width: AppSize.s100,
                        child: CircularProgressIndicator(
                          value: snapshot.data,
                          color: ColorManager.primary,
                        ),
                      ),
                      Center(
                        child: Text(
                          '${(snapshot.data! * 100).toStringAsFixed(0)}%',
                          style: const TextStyle(
                            fontSize: AppSize.s20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
              // return Center(
              //   child: Text(snapshot.data.toString()),
              // );
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
                    AppStrings.publicInvestmentProgramSystem,
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
