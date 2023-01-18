import 'package:flutter/cupertino.dart';
import 'package:pips_desktop/app/routes.dart';
import 'package:pips_desktop/presentation/home/home.dart';
import 'package:pips_desktop/presentation/resources/strings_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      onGenerateRoute: RouteGenerator.onGenerateRoute,
      home: HomeView(),
    );
  }
}
