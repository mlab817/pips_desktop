import 'package:flutter/material.dart';

import '../../resources/sizes_manager.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.md),
          child: Column(
            children: [
              const SizedBox(
                height: AppSize.s20,
              ),
              SizedBox(
                height: AppSize.s150,
                child: Row(
                  children: List.generate(
                      4,
                      (index) => (const Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(AppPadding.md),
                              child: Placeholder(),
                            ),
                          ))).toList(),
                ),
              ),
              Flex(
                direction: Axis.horizontal,
                children: const [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.all(AppPadding.md),
                      child: Placeholder(),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(AppPadding.md),
                      child: Placeholder(),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: AppSize.s100,
                child: Padding(
                  padding: EdgeInsets.all(AppPadding.md),
                  child: Placeholder(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
