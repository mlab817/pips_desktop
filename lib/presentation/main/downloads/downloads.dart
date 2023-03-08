import 'package:flutter/material.dart';

class DownloadsView extends StatefulWidget {
  const DownloadsView({Key? key}) : super(key: key);

  @override
  State<DownloadsView> createState() => _DownloadsViewState();
}

class _DownloadsViewState extends State<DownloadsView> {
  // TODO: Retrieve list of downloadables
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Downloads'),
        automaticallyImplyLeading: false,
      ),
    );
  }
}
