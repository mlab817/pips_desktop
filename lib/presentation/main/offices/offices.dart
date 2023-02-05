import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_macos_webview/flutter_macos_webview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:pips/app/config.dart';
import 'package:pips/data/requests/offices/get_offices_request.dart';
import 'package:pips/domain/models/project.dart';
import 'package:pips/presentation/resources/assets_manager.dart';
import 'package:pips/presentation/resources/color_manager.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';

import '../../../app/dep_injection.dart';
import '../../../app/routes.dart';
import '../../../domain/models/office.dart';
import '../../../domain/usecase/office_usecase.dart';
import '../../../domain/usecase/offices_usecase.dart';

class OfficesView extends StatefulWidget {
  const OfficesView({Key? key}) : super(key: key);

  @override
  State<OfficesView> createState() => _OfficesViewState();
}

class _OfficesViewState extends State<OfficesView> {
  final OfficesUseCase _officesUseCase = instance<OfficesUseCase>();
  final OfficeUseCase _officeUseCase = instance<OfficeUseCase>();

  late ScrollController _scrollController;

  Office? _selectedOffice;

  final List<Office> _offices = <Office>[];

  List<Project>? _projects;

  bool _loading = false;

  int _currentPage = 1;

  int _lastPage = 1;

  Future<void> _getOffices() async {
    // set loading to true so that this won't trigger when a request is already happening
    _loading = true;

    // remove projects
    _projects = null;

    final officesResponse =
        await _officesUseCase.execute(GetOfficesRequest(page: _currentPage));

    if (officesResponse.success) {
      if (mounted) {
        setState(() {
          // set offices to the data
          _offices.addAll(officesResponse.data?.data ?? <Office>[]);

          // set the last page so we can check if we already reached the end
          _lastPage = officesResponse.data?.meta.pagination.last ?? 1;

          // increment current page so the next call would include the next page
          _currentPage++;

          // lastly, stop loading
          _loading = false;
        });
      }
    }
  }

  Future<void> _getOffice() async {
    // remove projects
    _projects = null;

    // await office use cases
    debugPrint("_getOffice triggered");

    final officeResponse =
        await _officeUseCase.execute(_selectedOffice?.uuid ?? "");
    if (officeResponse.success) {
      if (mounted) {
        setState(() {
          _projects = officeResponse.data?.data.projects ?? <Project>[];
        });
      }
    } else {
      debugPrint(officeResponse.error);
    }
    // load selected office info
  }

  Future<void> _onOpenPressed(String uuid) async {
    final webview = FlutterMacOSWebView(
      onOpen: () => print('Opened'),
      onClose: () => print('Closed'),
      onPageStarted: (url) => print('Page started: $url'),
      onPageFinished: (url) => print('Page finished: $url'),
      onWebResourceError: (err) {
        print(
          'Error: ${err.errorCode}, ${err.errorType}, ${err.domain}, ${err.description}',
        );
      },
    );

    await webview.open(
      url: "${Config.baseUrl}/generate-pdf/$uuid",
      presentationStyle: PresentationStyle.sheet,
      // size: Size(400.0, 400.0),
      userAgent:
          'Mozilla/5.0 (iPhone; CPU iPhone OS 14_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0 Mobile/15E148 Safari/604.1',
    );

    // await Future.delayed(Duration(seconds: 5));
    // await webview.close();
  }

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    _getOffices();
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // add listener to scrollController to load next page
    _scrollController.addListener(() {
      // set the next page trigger to 80% of the list size based on maxScrollExtent
      var nextPageTrigger = 0.8 * _scrollController.position.maxScrollExtent;

      // if the position of scroll controller exceeds nextPageTrigger, load next page
      if (_scrollController.position.pixels > nextPageTrigger) {
        // if we are not yet on the last page, load the next one
        if (!_loading && _currentPage < _lastPage) {
          _getOffices();
        }
      }
    });

    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: ColorManager.darkGray,
                ),
              ),
            ),
            child: Column(
              children: [
                AppBar(
                  title: const Text('Offices'),
                  centerTitle: false,
                  automaticallyImplyLeading: false,
                ),
                Expanded(
                  child: _offices.isNotEmpty
                      ? ListView.builder(
                          controller: _scrollController,
                          itemCount: _offices.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            final office = _offices[index];
                            return Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom:
                                      BorderSide(color: ColorManager.darkGray),
                                ),
                              ),
                              child: ListTile(
                                title: Text(office.acronym),
                                trailing: const Icon(Icons.chevron_right),
                                onTap: () {
                                  setState(() {
                                    _selectedOffice = office;
                                  });
                                  _getOffice();
                                },
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text('No items to show'),
                        ),
                ),
              ],
            ),
          ),
        ),
        _getProjectsWidget()
      ],
    );
  }

  Widget _getProjectsWidget() {
    return Expanded(
      flex: 3,
      child: _selectedOffice != null
          ? Center(
              child: Column(
                children: [
                  Column(
                    children: [
                      // office card
                      Padding(
                        padding: const EdgeInsets.all(AppSize.s8),
                        child: Card(
                          elevation: AppSize.s4,
                          child: Container(
                            padding: const EdgeInsets.all(
                              AppSize.s20,
                            ),
                            decoration: BoxDecoration(
                              color: ColorManager.darkWhite,
                              borderRadius: BorderRadius.circular(AppSize.s8),
                            ),
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  AssetsManager.svgLogoAsset,
                                  height: AppSize.s80,
                                ),
                                const SizedBox(
                                  height: AppSize.s20,
                                ),
                                SelectableText(
                                  _selectedOffice?.name ?? "",
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                const SizedBox(
                                  height: AppSize.s20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.email,
                                      color: ColorManager.black,
                                    ),
                                    Text(_selectedOffice?.email ?? ""),
                                    const SizedBox(
                                      width: AppSize.s10,
                                    ),
                                    Icon(
                                      Icons.phone,
                                      color: ColorManager.black,
                                    ),
                                    Text(_selectedOffice?.phoneNumber ?? ""),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // const Divider(),
                  _projects != null
                      ? _getProjectsList()
                      : const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                ],
              ),
            )
          : const Center(
              child: Text('No office selected.'),
            ),
    );
  }

  Widget _getProjectsList() {
    final projects = _projects ?? <Project>[];

    return projects.isNotEmpty
        ? Expanded(
            child: ListView.builder(
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];

                return ListTile(
                  title: Text(project.title),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    if (Platform.isMacOS) {
                      _onOpenPressed(project.uuid);
                    } else {
                      Navigator.pushNamed(context, Routes.viewProjectRoute,
                          arguments: project.uuid);
                    }
                    // navigate to project vie
                  },
                );
              },
            ),
          )
        : Expanded(
            child: Center(
              child: Lottie.asset(
                AssetsManager.animEmptyJson,
              ),
            ),
          );
  }
}
