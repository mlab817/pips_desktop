import 'package:flutter/material.dart';

class ViewProjectView extends StatefulWidget {
  const ViewProjectView({Key? key, required this.uuid}) : super(key: key);

  final String uuid;

  @override
  State<ViewProjectView> createState() => _ViewProjectViewState();
}

class _ViewProjectViewState extends State<ViewProjectView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Official InAppWebView website"),
      ),
    );
  }
}
