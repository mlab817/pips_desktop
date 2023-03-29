import 'package:flutter/material.dart';

import '../../resources/sizes_manager.dart';

class EnableTouchIdView extends StatefulWidget {
  const EnableTouchIdView({Key? key}) : super(key: key);

  @override
  State<EnableTouchIdView> createState() => _EnableTouchIdViewState();
}

class _EnableTouchIdViewState extends State<EnableTouchIdView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Touch ID Setup'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.fingerprint,
                    size: AppSize.s80,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(AppSize.s20),
                    child: Text(
                      'Enable Touch ID on PIPS for a more convenient and secure login!',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.md),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Enable Touch ID'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.md),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {}, child: const Text('Maybe Later')),
            ),
          ),
        ],
      ),
    );
  }
}
