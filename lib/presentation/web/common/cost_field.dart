import 'package:flutter/material.dart';

class CostField extends StatelessWidget {
  const CostField({Key? key, required this.controller, this.enabled})
      : super(key: key);

  final TextEditingController controller;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: _getTextInputDecoration(),
      textAlign: TextAlign.right,
      textAlignVertical: TextAlignVertical.center,
      expands: false,
      enabled: enabled ?? true,
    );
  }

  InputDecoration _getTextInputDecoration() {
    return const InputDecoration(
      isCollapsed: true,
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      fillColor: Colors.transparent,
      hoverColor: Colors.transparent,
    );
  }
}
