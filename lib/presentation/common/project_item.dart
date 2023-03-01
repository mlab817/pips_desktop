import 'dart:io';

import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_macos_webview/flutter_macos_webview.dart';
import 'package:intl/intl.dart';
import 'package:pips/domain/models/project.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../app/config.dart';
import '../../app/routes.dart';

class ProjectItem extends StatefulWidget {
  const ProjectItem({Key? key, required this.project, required this.onTap})
      : super(key: key);

  final Project project;
  final VoidCallback onTap;

  @override
  State<ProjectItem> createState() => _ProjectItemState();
}

class _ProjectItemState extends State<ProjectItem> {
  bool _isHovered = false;

  bool? _webViewAvailable;

  @override
  void initState() {
    super.initState();

    WebviewWindow.isWebviewAvailable().then((value) {
      setState(() {
        _webViewAvailable = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            _isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            _isHovered = false;
          });
        },
        child: ListTile(
          leading: Text(widget.project.pipolCode ?? 'PIPOL_CODE'),
          title: Text(widget.project.title),
          trailing: Container(
            width: AppSize.s150,
            alignment: Alignment.centerRight,
            child: _isHovered
                ? SizedBox(
                    width: AppSize.s150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            tooltip: 'View',
                            onPressed: () {
                              if (UniversalPlatform.isDesktop) {
                                _onOpenPressed(widget.project.uuid);
                              } else {
                                Navigator.pushNamed(
                                    context, Routes.viewProjectRoute,
                                    arguments: widget.project.uuid);
                              }
                            },
                            icon: const Icon(
                              Icons.visibility_outlined,
                              size: AppSize.s18,
                            )),
                        IconButton(
                            tooltip: 'Edit',
                            onPressed: () {},
                            icon: const Icon(
                              Icons.edit_outlined,
                              size: AppSize.s18,
                            )),
                        IconButton(
                          tooltip: 'Delete',
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SimpleDialog(
                                    title: const Text('Delete PAP'),
                                    titlePadding:
                                        const EdgeInsets.all(AppPadding.lg),
                                    insetPadding:
                                        const EdgeInsets.all(AppPadding.lg),
                                    contentPadding:
                                        const EdgeInsets.all(AppPadding.lg),
                                    children: [
                                      const Text(
                                          'Are you sure you want to delete this PAP?'),
                                      const SizedBox(
                                        height: AppSize.s20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          const SizedBox(
                                            width: AppSize.s10,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                });
                          },
                          icon: Icon(
                            Icons.delete_outline,
                            size: AppSize.s18,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSize.s12),
                    child: Text(DateFormat.yMMMd()
                        .format(DateTime.parse(widget.project.updatedAt))),
                  ),
          ),
        ),
      ),
    );
  }

  Future<void> _onOpenPressed(String uuid) async {
    // final webview = FlutterMacOSWebView(
    //   onOpen: () => print('Opened'),
    //   onClose: () => print('Closed'),
    //   onPageStarted: (url) => print('Page started: $url'),
    //   onPageFinished: (url) => print('Page finished: $url'),
    //   onWebResourceError: (err) {
    //     print(
    //       'Error: ${err.errorCode}, ${err.errorType}, ${err.domain}, ${err.description}',
    //     );
    //   },
    // );

    final webview = await WebviewWindow.create(
      configuration: CreateConfiguration(
        windowHeight: 720,
        windowWidth: 1080,
        title: 'View',
        titleBarTopPadding: Platform.isMacOS ? 20 : 0,
      ),
    );

    webview.launch(
      "${Config.baseUrl}/generate-pdf/$uuid?access_key=something+nice",
    );

    // await Future.delayed(Duration(seconds: 5));
    // await webview.close();
  }
}
