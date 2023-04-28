import 'package:flutter/material.dart';

class CostField extends StatelessWidget {
  const CostField({Key? key, required this.onChanged, this.enabled, this.value})
      : super(key: key);

  final Function(String value) onChanged;
  final bool? enabled;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // controller: controller,
      initialValue: value ?? '',
      decoration: _getTextInputDecoration(),
      textAlign: TextAlign.right,
      textAlignVertical: TextAlignVertical.center,
      expands: false,
      enabled: enabled ?? true,
      onChanged: onChanged,
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
