import 'package:flutter/material.dart';

import '../../../data/responses/presets/presets.dart';
import 'newpapform.dart';

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
