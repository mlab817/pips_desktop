import 'package:flutter/material.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../../resources/strings_manager.dart';

class ActivityLogView extends StatefulWidget {
  const ActivityLogView({Key? key}) : super(key: key);

  @override
  State<ActivityLogView> createState() => _ActivityLogViewState();
}

class _ActivityLogViewState extends State<ActivityLogView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !UniversalPlatform.isDesktopOrWeb,
        title: const Text(AppStrings.activityLogs),
      ),
      body: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.format_list_numbered),
              title: const Text('Test'),
              subtitle: const Text('Date&Time'),
              trailing: const Icon(Icons.more_horiz),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    // TODO: Add the details of the activity log
                    return AlertDialog(
                      title: const Text('Activity Log'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s2),
                      ),
                    );
                  },
                );
              },
            );
          }),
    );
  }
}
