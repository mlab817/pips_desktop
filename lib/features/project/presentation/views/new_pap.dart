import 'package:flutter/material.dart';

import '../../domain/models/presets.dart';
import '../widgets/new_pap_form.dart';

class NewPapView extends StatefulWidget {
  const NewPapView({Key? key, this.preset}) : super(key: key);

  final Preset? preset;

  @override
  State<NewPapView> createState() => _NewPapViewState();
}

class _NewPapViewState extends State<NewPapView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NewPap(preset: widget.preset),
    );
  }
}
