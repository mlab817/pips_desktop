import 'package:flutter/material.dart';

class Shortcuts extends ShortcutManager {
  KeyEventResult handleKeyPress(BuildContext context, RawKeyEvent event) {
    final KeyEventResult result = super.handleKeypress(context, event);

    if (result == KeyEventResult.handled) {
      print("Handled shortcut $event in $context");
    }

    return result;
  }
}