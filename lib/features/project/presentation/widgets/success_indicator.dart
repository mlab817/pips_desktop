import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';

class SuccessIndicator extends StatelessWidget {
  const SuccessIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      BootstrapIcons.check_circle_fill,
      color: Colors.green,
    );
  }
}
