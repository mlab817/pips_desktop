import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_macos_webview/flutter_macos_webview.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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

  final TextEditingController _searchTextEditingController =
      TextEditingController();

  final TextEditingController _searchOfficeController = TextEditingController();

  Office? _selectedOffice;

  final List<Office> _offices = <Office>[];

  List<Office> _filteredOffices = <Office>[];

  List<Project>? _projects;

  bool _loadingOffice = false;

  int _currentPage = 1;

  int _lastPage = 1;

  void _filterList() {
    setState(() {
      if (_searchOfficeController.text.isNotEmpty) {
        _filteredOffices = _offices
            .where((item) => item.acronym
                .toLowerCase()
                .contains(_searchOfficeController.text.toLowerCase()))
            .toList();
      } else {
        _filteredOffices = _offices;
      }
    });
  }

  Future<void> _getOffices() async {
    // set loading to true so that this won't trigger when a request is already happening
    _loadingOffice = true;

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
          _loadingOffice = false;
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
      url: "${Config.baseUrl}/generate-pdf/$uuid?access_key=something+nice",
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

    _searchOfficeController.addListener(_filterList);

    _filteredOffices = _offices;
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();

    _searchTextEditingController.dispose();

    _searchOfficeController.dispose();
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
        if (!_loadingOffice && _currentPage < _lastPage) {
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
                Padding(
                  padding: const EdgeInsets.all(AppSize.s8),
                  child: TextField(
                    controller: _searchOfficeController,
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: _filteredOffices.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(
                            AppSize.s8,
                          ),
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount: _filteredOffices.length,
                            itemBuilder: (BuildContext context, int index) {
                              final office = _filteredOffices[index];

                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedOffice = office;
                                  });
                                  _getOffice();
                                },
                                borderRadius: BorderRadius.circular(AppSize.s8),
                                child: ListTile(
                                  dense: true,
                                  title: Text(office.acronym),
                                  selected: _selectedOffice == office,
                                  selectedTileColor: ColorManager.blue,
                                  selectedColor: ColorManager.white,
                                ),
                              );
                            },
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
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
                              // TODO: update this ugly thing
                              gradient: LinearGradient(
                                colors: [
                                  ColorManager.veryLightGray,
                                  ColorManager.darkWhite,
                                  ColorManager.white,
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              ),
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
                                      color: ColorManager.darkGray,
                                    ),
                                    const SizedBox(
                                      width: AppSize.s2,
                                    ),
                                    Text(_selectedOffice?.email ?? ""),
                                    const SizedBox(
                                      width: AppSize.s10,
                                    ),
                                    Icon(
                                      Icons.phone,
                                      color: ColorManager.darkGray,
                                    ),
                                    const SizedBox(
                                      width: AppSize.s2,
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
              child: Text('Select office from the left panel to begin.'),
            ),
    );
  }

  Widget _getProjectsList() {
    final projects = _projects ?? <Project>[];

    return projects.isNotEmpty
        ? Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSize.s8),
              child: Column(
                children: [
                  TextField(
                    controller: _searchTextEditingController,
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s8,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: projects.length,
                      itemBuilder: (context, index) {
                        final project = projects[index];

                        return ClipRect(
                          child: Slidable(
                            key: Key(index.toString()),
                            startActionPane: ActionPane(
                              motion: const BehindMotion(),
                              extentRatio: 0.08,
                              children: [
                                SlidableAction(
                                  onPressed: (context) async {
                                    String urlToShare =
                                        "${Config.baseUrl}/generate-pdf/${project.uuid}";
                                    // generate url
                                    await Clipboard.setData(
                                        ClipboardData(text: urlToShare));

                                    _showSuccessSnackbar();
                                  },
                                  backgroundColor: const Color(0xFF0000FF),
                                  foregroundColor: Colors.white,
                                  icon: Icons.share,
                                  label: 'Share',
                                ),
                              ],
                            ),
                            endActionPane: ActionPane(
                              extentRatio: 0.2,
                              // A motion is a widget used to control how the pane animates.
                              motion: const BehindMotion(),

                              // A pane can dismiss the Slidable.
                              // dismissible: DismissiblePane(onDismissed: () {}),

                              // All actions are defined in the children parameter.
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    // do nothing
                                  },
                                  backgroundColor: const Color(0xFF00FF00),
                                  foregroundColor: Colors.white,
                                  icon: Icons.visibility,
                                  label: 'View',
                                ),
                                SlidableAction(
                                  onPressed: (context) {
                                    // do nothing
                                  },
                                  backgroundColor: const Color(0xFF21B7CA),
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit,
                                  label: 'Edit',
                                ),
                                // A SlidableAction can have an icon and/or a label.
                                SlidableAction(
                                  onPressed: (context) {
                                    // do nothing
                                  },
                                  backgroundColor: const Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ],
                            ),
                            child: ListTile(
                              title: Text(project.title),
                              trailing: Text(
                                  "Php ${(project.totalCost / 1000000).toStringAsFixed(2)} M"),
                              onTap: () {
                                if (Platform.isMacOS) {
                                  _onOpenPressed(project.uuid);
                                } else {
                                  Navigator.pushNamed(
                                      context, Routes.viewProjectRoute,
                                      arguments: project.uuid);
                                }
                                // navigate to project vie
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
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

  void _showSuccessSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully copied to clipboard.')));
  }
}
