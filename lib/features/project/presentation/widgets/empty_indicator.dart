import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';

class EmptyIndicator extends StatelessWidget {
  const EmptyIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      BootstrapIcons.check_circle,
      color: Colors.redAccent,
    );
  }
}
