import 'package:flutter/material.dart';

InputDecoration getTextInputDecoration({String? hintText}) {
  return InputDecoration(
    isCollapsed: true,
    border: InputBorder.none,
    focusedBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
    fillColor: Colors.transparent,
    hoverColor: Colors.transparent,
    hintText: hintText ?? '',
  );
}
