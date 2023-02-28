import 'package:flutter/material.dart';

class DeveloperNotice extends StatefulWidget {
  const DeveloperNotice({Key? key}) : super(key: key);

  @override
  State<DeveloperNotice> createState() => _DeveloperNoticeState();
}

class _DeveloperNoticeState extends State<DeveloperNotice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer Notice'),
      ),
      body: const Center(
        child: Text('For any ...'),
      ),
    );
  }
}
