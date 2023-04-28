import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/options.dart';

class OptionsState extends StateNotifier<Options> {
  OptionsState() : super(Options());

  void setState(Options options) {
    state = options;
  }
}

final optionsState =
    StateNotifierProvider<OptionsState, Options>((ref) => OptionsState());
