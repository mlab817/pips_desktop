import 'package:flutter/material.dart';
import 'package:pips/common/resources/strings_manager.dart';
import 'package:universal_platform/universal_platform.dart';

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
        automaticallyImplyLeading: !UniversalPlatform.isDesktopOrWeb,
        title: const Text(AppStrings.developerNotice),
      ),
      body: const Center(
        child: Text('For any ...'),
      ),
    );
  }
}
