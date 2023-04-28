import 'dart:io';

import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:pips/features/dashboard/domain/models/project.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../../../app/config.dart';
import '../../../../routing/routing.dart';
import '../../../../common/resources/sizes_manager.dart';
import '../../../../common/resources/strings_manager.dart';

class ProjectItem extends StatefulWidget {
  const ProjectItem({Key? key, required this.project}) : super(key: key);

  final Project project;

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
    return UniversalPlatform.isDesktopOrWeb
        ? GestureDetector(
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
                leading: UniversalPlatform.isDesktopOrWeb
                    ? Text(widget.project.pipolCode ?? 'PIPOL_CODE')
                    : null,
                title: Text(widget.project.title),
                subtitle: !UniversalPlatform.isDesktopOrWeb
                    ? Text(widget.project.pipolCode ?? 'PIPOL_CODE')
                    : null,
                trailing: UniversalPlatform.isDesktopOrWeb
                    ? Container(
                        width: AppSize.s150,
                        alignment: Alignment.centerRight,
                        child: _isHovered
                            ? SizedBox(
                                width: AppSize.s150,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        tooltip: AppStrings.view,
                                        onPressed: () {
                                          if (UniversalPlatform
                                              .isDesktopOrWeb) {
                                            _onOpenPressed(widget.project.uuid);
                                          } else {
                                            Navigator.pushNamed(context,
                                                Routes.viewProjectRoute,
                                                arguments: widget.project.uuid);
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.visibility_outlined,
                                          size: AppSize.s18,
                                        )),
                                    IconButton(
                                        tooltip: AppStrings.edit,
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.edit_outlined,
                                          size: AppSize.s18,
                                        )),
                                    IconButton(
                                      tooltip: AppStrings.delete,
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return SimpleDialog(
                                                title: const Text(
                                                    AppStrings.deletePap),
                                                titlePadding:
                                                    const EdgeInsets.all(
                                                        AppPadding.lg),
                                                insetPadding:
                                                    const EdgeInsets.all(
                                                        AppPadding.lg),
                                                contentPadding:
                                                    const EdgeInsets.all(
                                                        AppPadding.lg),
                                                children: [
                                                  const Text(AppStrings
                                                      .areYouSureYouWantToDeleteThisPap),
                                                  const SizedBox(
                                                    height: AppSize.s20,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text(
                                                            AppStrings.cancel),
                                                      ),
                                                      const SizedBox(
                                                        width: AppSize.s10,
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {},
                                                        child: const Text(
                                                            AppStrings.ok),
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
                                        color:
                                            Theme.of(context).colorScheme.error,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppPadding.md),
                                child: Text(
                                  DateFormat.yMMMd().add_jms().format(
                                      DateTime.parse(widget.project.updatedAt)),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                      )
                    : null,
              ),
            ),
          )
        : _getSlidableActions();
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

    final Webview webview = await WebviewWindow.create(
      configuration: CreateConfiguration(
        windowHeight: AppSize.s720.toInt(),
        windowWidth: AppSize.s1080.toInt(),
        title: AppStrings.view,
        titleBarTopPadding: Platform.isMacOS ? 20 : 0,
      ),
    );

    String generatePdf = 'generate-pdf';

    webview.launch(
      "${Config.baseUrl}/$generatePdf/$uuid",
    );

    // await Future.delayed(Duration(seconds: 5));
    // await webview.close();
  }

  Widget _getSlidableActions() {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              //
              Navigator.pushNamed(context, Routes.viewProjectRoute,
                  arguments: widget.project.uuid);
            },
            icon: Icons.visibility_outlined,
          ),
          SlidableAction(
            onPressed: (context) {
              //
            },
            icon: Icons.edit_outlined,
          ),
          SlidableAction(
            onPressed: (context) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(AppStrings.confirmDelete),
                      content: const Text(
                          AppStrings.areYouSureYouWantToDeleteThisPap),
                      actions: [
                        TextButton(
                          onPressed: () {
                            //
                            Navigator.of(context).pop();
                          },
                          child: const Text(AppStrings.cancel),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // TODO: handle deletion via API
                          },
                          child: const Text(AppStrings.confirm),
                        ),
                      ],
                    );
                  });
            },
            icon: Icons.delete,
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        ],
      ),
      child: ListTile(
        title: Text(widget.project.title),
      ),
    );
  }
}
