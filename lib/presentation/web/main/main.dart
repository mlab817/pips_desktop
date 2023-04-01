import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pips/app/functions.dart';
import 'package:pips/data/requests/projects/get_projects_request.dart';
import 'package:pips/domain/usecase/options_usecase.dart';
import 'package:pips/domain/usecase/projects_usecase.dart';
import 'package:pips/presentation/resources/assets_manager.dart';

import '../../../app/dep_injection.dart';
import '../../../domain/models/options.dart';
import '../../../domain/models/pips_status.dart';
import '../../../domain/models/project.dart';
import '../../../domain/usecase/chatrooms_usecase.dart';
import '../../../domain/usecase/pipsstatuses_usecase.dart';
import '../../resources/sizes_manager.dart';
import '../../resources/strings_manager.dart';

class MainWebView extends StatefulWidget {
  const MainWebView({Key? key}) : super(key: key);

  @override
  State<MainWebView> createState() => _MainWebViewState();
}

class _MainWebViewState extends State<MainWebView> {
  late ScrollController _scrollController;
  final ProjectsUseCase _projectsUseCase = instance<ProjectsUseCase>();
  final PipsStatusesUseCase _pipsStatusesUseCase =
      instance<PipsStatusesUseCase>();
  late GetProjectsRequest _getProjectsRequest;

  int _currentIndex = 0;
  int _total = 0;
  int _start = 1;
  int _end = 1;
  bool _loading = false;
  String? _error;
  List<Project> _projects = [];
  int _currentPage = 1;
  final int _perPage = 50;
  String? _search = '';
  Options? _options;

  int _selectedStatus = 1;

  List<PipsStatus> _statuses = [];

  Future<void> _getStatuses() async {
    (await _pipsStatusesUseCase.execute(Void())).fold((failure) {
      debugPrint(failure.message);
    }, (response) {
      setState(() {
        _statuses = response.data;
      });
    });
  }

  final List<NavigationRailDestination> _destinations = [
    const NavigationRailDestination(
      icon: Icon(Icons.home),
      label: Text('Home'),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.chat),
      label: Text('Chat'),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.notifications),
      label: Text('Notifs'),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.settings),
      label: Text('Settings'),
    ),
  ];

  Future<void> _loadProjects() async {
    // if the state is currently loading, do not load
    if (_loading) return;

    setState(() {
      _loading = true;
    });

    (await _projectsUseCase.execute(_getProjectsRequest)).fold((failure) {
      debugPrint(failure.message);
      setState(() {
        _error = failure.message;
        _loading = false;
      });
    }, (response) {
      setState(() {
        _projects = response.data;
        _total = response.meta.pagination.total;
        _start = (_currentPage - 1) * _perPage + 1;
        _end = (_currentPage * _perPage) > _total
            ? _total
            : _currentPage * _perPage;
        _loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _getStatuses();

    _scrollController = ScrollController();

    _getProjectsRequest = GetProjectsRequest(
      page: _currentPage,
      perPage: _perPage,
      q: _search,
    );

    _loadProjects();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _buildNavigationRail(),
          const VerticalDivider(
            width: AppSize.s1,
            thickness: AppSize.s1,
          ),
          _buildMainBody(),
        ],
      ),
    );
  }

  Widget _buildMainBody() {
    return Expanded(
      child: Column(
        children: [
          Row(children: [
            _buildTitle(),
            ..._buildTopMenu(),
          ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSidePanel(),
              // Main Body
              Expanded(child: _buildList()),
              const SizedBox(
                width: AppSize.md,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return SizedBox(
      width: AppSize.s240,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.md),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.md),
              child: Image.asset(
                AssetsManager.logo,
                height: AppSize.s40,
              ),
            ),
            const SizedBox(
              width: AppSize.s8,
            ),
            Text(
              AppStrings.pips,
              style: GoogleFonts.bebasNeue(
                fontWeight: FontWeight.w500,
                fontSize: AppSize.s36,
                color: Theme.of(context).primaryColor,
                letterSpacing: AppSize.s4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTopMenu() {
    return [
      Flexible(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: AppSize.s400,
            maxWidth: AppSize.s500,
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: AppPadding.md),
            child: Autocomplete<String>(
              fieldViewBuilder:
                  (context, textEditingController, focusNode, callback) {
                //
                return TextField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: InkWell(
                      borderRadius: BorderRadius.circular(AppSize.s50),
                      onTap: () {
                        //
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: FilterDialog(
                                    getProjectsRequest: _getProjectsRequest,
                                    onDismiss: () {
                                      Navigator.pop(context);
                                    },
                                    onSubmit: (newValue) {
                                      setState(() {
                                        _getProjectsRequest = newValue;
                                      });

                                      Navigator.pop(context);

                                      debugPrint(
                                          jsonEncode(_getProjectsRequest));

                                      // reload projects
                                      _loadProjects();
                                    }),
                              );
                            });
                      },
                      child: const Icon(Icons.tune),
                    ),
                    isCollapsed: false,
                  ),
                );
              },
              onSelected: (String selected) {
                // handle search
                setState(() {
                  _search = selected;
                  _currentPage = 1;
                });

                _loadProjects();
              },
              optionsBuilder: (
                TextEditingValue textEditingValue,
              ) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<String>.empty();
                }
                return _projects
                    .where((element) => element.title
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase()))
                    .map((e) => e.title);
              },
              optionsViewBuilder: (
                BuildContext context,
                AutocompleteOnSelected<String> onSelected,
                Iterable<String> options,
              ) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 4.0,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 200,
                        maxWidth: 490,
                      ),
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: options.length,
                          itemBuilder: (BuildContext context, int index) {
                            final String option = options.elementAt(index);
                            return InkWell(
                              onTap: () {
                                onSelected(option);
                              },
                              child: Container(
                                color: Colors.white,
                                padding: const EdgeInsets.all(16.0),
                                child: Text(option),
                              ),
                            );
                          }),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      const Spacer(),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              //
            },
            icon: const Icon(Icons.settings_outlined),
          ),
          IconButton(
            onPressed: () {
              //
            },
            icon: const Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
    ];
  }

  Widget _buildSidePanel() {
    return SizedBox(
      width: AppSize.s240,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: AppSize.s48,
              child: ElevatedButton(
                  onPressed: () {
                    //
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.mode_edit_outline_outlined),
                      SizedBox(
                        width: AppSize.s10,
                      ),
                      Text('New'),
                    ],
                  )),
            ),
            const SizedBox(
              height: AppSize.md,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _statuses.length,
              itemBuilder: (context, index) {
                return ListTile(
                  selectedTileColor: Theme.of(context).focusColor,
                  selected: _selectedStatus == index,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppSize.xxl,
                    ),
                  ),
                  title: Row(
                    children: [
                      const Icon(
                        Icons.label_important_outline,
                        size: FontSize.xxxl,
                      ),
                      const SizedBox(width: AppSize.md),
                      Text(
                        _statuses[index].name,
                        style: _selectedStatus == index
                            ? const TextStyle(
                                // fontSize: AppSize.s10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              )
                            : const TextStyle(
                                // fontSize: AppSize.s10,
                                fontWeight: FontWeight.normal,
                                letterSpacing: 0.5,
                              ),
                      ),
                    ],
                  ),
                  trailing: Text(
                    _statuses[index].projectsCount.toString(),
                    style: _selectedStatus == index
                        ? const TextStyle(fontWeight: FontWeight.bold)
                        : const TextStyle(fontWeight: FontWeight.normal),
                  ),
                  dense: true,
                  visualDensity: VisualDensity.compact,
                  onTap: () {
                    //
                    setState(() {
                      _selectedStatus = index;
                    });
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(AppPadding.md),
              child: Text(
                'PIPOL Status',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                ListTile(
                  title: const Text('DRAFT'),
                  onTap: () {},
                  dense: true,
                ),
                ListTile(
                  title: const Text('ENDORSED'),
                  onTap: () {},
                  dense: true,
                ),
                ListTile(
                  title: const Text('VALIDATED'),
                  onTap: () {},
                  dense: true,
                ),
                ListTile(
                  title: const Text('UNCATEGORIZED'),
                  onTap: () {},
                  dense: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListNavigator() {
    return Container(
      height: AppSize.s50,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSize.s20),
          topRight: Radius.circular(AppSize.s20),
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.md,
          vertical: AppSize.s4,
        ),
        child: Row(
          children: [
            const SizedBox(
              width: AppSize.s4,
            ),
            Checkbox(
              value: false,
              onChanged: (bool? value) {
                //
              },
            ),
            const SizedBox(
              width: AppSize.s14,
            ),
            IconButton(
              onPressed: () {
                // reload current page
                _loadProjects();
              },
              icon: const Icon(Icons.refresh),
            ),
            Expanded(child: Container()),
            Text(
              '$_start-$_end of $_total',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(
              width: AppSize.s4,
            ),
            IconButton(
              onPressed: _loading || _currentPage == 1
                  ? null
                  : () {
                      setState(() {
                        _currentPage--;
                        _getProjectsRequest =
                            _getProjectsRequest.copyWith(page: _currentPage);
                      });
                      _loadProjects();
                    },
              splashRadius: AppSize.s22,
              icon: const Icon(
                Icons.chevron_left,
                size: FontSize.xxxl,
              ),
            ),
            const SizedBox(
              width: AppSize.s4,
            ),
            IconButton(
              onPressed: _loading
                  ? null
                  : () {
                      setState(() {
                        _currentPage++;
                        _getProjectsRequest =
                            _getProjectsRequest.copyWith(page: _currentPage);
                      });
                      _loadProjects();
                    },
              splashRadius: AppSize.s22,
              icon: const Icon(
                Icons.chevron_right,
                size: FontSize.xxxl,
              ),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Column(
                          children: const <Widget>[
                            Text('Help'),
                            Expanded(child: Center(child: Placeholder())),
                          ],
                        ),
                      );
                    });
              },
              icon: const Icon(Icons.help_outline),
              tooltip: 'Help',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    var windowHeight = MediaQuery.of(context).size.height;

    return _error != null
        ? Center(child: Text(_error!))
        : Column(
            children: [
              _buildListNavigator(),
              if (_loading) const LinearProgressIndicator(),
              SizedBox(
                height: windowHeight - AppSize.s130,
                child: Scrollbar(
                    radius: Radius.zero,
                    thickness: AppSize.s12,
                    controller: _scrollController,
                    thumbVisibility: true,
                    child: ScrollConfiguration(
                      // hide the default listview separated scrollbar
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: Padding(
                        padding: const EdgeInsets.only(right: AppSize.s20),
                        child: ListView.separated(
                          controller: _scrollController,
                          physics: const ClampingScrollPhysics(),
                          // no bounce scroll
                          shrinkWrap: true,
                          itemCount: _projects.length,
                          separatorBuilder: (context, index) {
                            return Divider(
                              color: Theme.of(context).dividerColor,
                              height: AppSize.s0,
                            );
                          },
                          itemBuilder: (context, index) {
                            return ProjectListTile(
                              project: _projects[index],
                            );
                          },
                        ),
                      ),
                    )),
              ),
            ],
          );
  }

  Widget _buildNavigationRail() {
    return NavigationRail(
      destinations: _destinations,
      elevation: AppSize.s2,
      labelType: NavigationRailLabelType.none,
      onDestinationSelected: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
      selectedIndex: _currentIndex,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          // todo: implement show/hide sidepanel
        },
      ),
      trailing: Expanded(
        child: Column(
          children: [
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                // TODO: implement logout
              },
            ),
          ],
        ),
      ),
      selectedLabelTextStyle: Theme.of(context).textTheme.bodySmall,
      unselectedLabelTextStyle: Theme.of(context).textTheme.bodySmall,
    );
  }
}

class ProjectListTile extends StatefulWidget {
  const ProjectListTile({Key? key, required this.project}) : super(key: key);

  final Project project;

  @override
  State<ProjectListTile> createState() => _ProjectListTileState();
}

class _ProjectListTileState extends State<ProjectListTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          _hovered = true;
        });
      },
      onExit: (event) {
        setState(() {
          _hovered = false;
        });
      },
      onHover: (event) {
        setState(() {
          _hovered = true;
        });
      },
      child: Material(
        elevation: _hovered ? 2 : 0,
        child: ListTile(
          shape: _hovered
              ? RoundedRectangleBorder(
                  side: BorderSide(
                      width: AppSize.s0_5,
                      color: Theme.of(context).dividerColor),
                  borderRadius: BorderRadius.zero,
                )
              : null,
          hoverColor: Colors.transparent,
          leading: Checkbox(
            value: false,
            onChanged: (bool? value) {},
          ),
          // hoverColor: Colors.transparent,
          // tileColor: Theme.of(context).colorScheme.secondaryContainer,
          // title: Text(_hovered ? 'hovered' : 'unhovered'),
          title: Row(
            children: <Widget>[
              SizedBox(
                width: AppSize.s150,
                child: Text(
                  widget.project.user?.fullname ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: AppSize.s10),
              SizedBox(
                width: AppSize.s80,
                child: Text(
                  widget.project.office?.acronym ?? 'N/A',
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const SizedBox(width: AppSize.s10),
              Flexible(
                child: RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(children: [
                    TextSpan(
                      text: widget.project.title,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const TextSpan(text: ' - '),
                    TextSpan(
                      text: widget.project.description ?? 'No description',
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.grey,
                        fontSize: FontSize.md,
                      ),
                    ),
                  ]),
                ),
              ),
              const SizedBox(width: AppSize.s20),
            ],
          ),
          trailing: _hovered
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        //
                      },
                      icon: const Icon(
                        Icons.download_outlined,
                        size: FontSize.xxl,
                      ),
                      tooltip: AppStrings.download,
                      visualDensity: VisualDensity.compact,
                      splashRadius: 20,
                    ),
                    IconButton(
                      onPressed: () {
                        //
                      },
                      icon: const Icon(
                        Icons.mode_edit_outline_outlined,
                        size: FontSize.xxl,
                      ),
                      tooltip: AppStrings.edit,
                      visualDensity: VisualDensity.compact,
                      splashRadius: 20,
                    ),
                    IconButton(
                      onPressed: () {
                        //
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        size: FontSize.xxl,
                      ),
                      tooltip: AppStrings.delete,
                      visualDensity: VisualDensity.compact,
                      splashRadius: 20,
                    ),
                  ],
                )
              : Text(
                  formatDate(widget.project.updatedAt),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
          onTap: () {
            // TODO: implement view project
          },
          dense: true,
        ),
      ),
    );
  }
}

class FilterDialog extends StatefulWidget {
  const FilterDialog(
      {Key? key,
      required this.onDismiss,
      required this.getProjectsRequest,
      required this.onSubmit})
      : super(key: key);

  final Function onDismiss;
  final GetProjectsRequest getProjectsRequest;
  final Function onSubmit;

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  final OptionsUseCase _optionsUseCase = instance<OptionsUseCase>();

  late GetProjectsRequest _getProjectsRequest;

  Options? _options;
  String? _error;
  bool _loading = false;

  Future<void> _loadOptions() async {
    setState(() {
      _loading = true;
    });

    (await _optionsUseCase.execute(Void())).fold((failure) {
      setState(() {
        _error = failure.message;
        _loading = false;
      });
    }, (response) {
      setState(() {
        _options = response.data;
        _loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _loadOptions();

    _getProjectsRequest = widget.getProjectsRequest;
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(
        child: CircleAvatar(
          radius: AppSize.s24,
          child: Padding(
            padding: EdgeInsets.all(AppPadding.md),
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return Column(
      children: [
        AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Icon(Icons.tune),
              SizedBox(width: AppSize.md),
              Text('Filters'),
            ],
          ),
          centerTitle: false,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  widget.onDismiss();
                },
                icon: const Icon(Icons.close)),
          ],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppSize.xxxl),
            ),
          ),
        ),
        Expanded(
          child: _options != null
              ? SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _getFilterHeader('TYPE'),
                      ...?_getTypes(),
                      _getFilterHeader('SPATIAL COVERAGE'),
                      ...?_getSpatialCoverages(),
                      // _getFilterHeader('PDP CHAPTER'),
                      // ...?_getPdpChapters(),
                      _getFilterHeader('CATEGORY'),
                      ...?_getCategories(),
                      _getFilterHeader('PROJECT STATUS'),
                      ...?_getProjectStatuses(),
                      _getFilterHeader('FUNDING SOURCE'),
                      ...?_getFundingSources(),
                      _getFilterHeader('PIPS STATUS'),
                      ...?_getPipsStatuses(),
                      _getFilterHeader('PIPOL STATUS'),
                      ...?_getPipolStatuses(),
                    ],
                  ),
                )
              : const Center(
                  child: Text('Failed to Load Options'),
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              const SizedBox(
                width: AppSize.md,
              ),
              ElevatedButton(
                onPressed: () {
                  widget.onSubmit(_getProjectsRequest);
                },
                child: const Text('Apply'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getFilterHeader(String header) {
    return ListTile(
      title: Text(
        header.toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }

  List<Widget>? _getTypes() {
    return _options!.types?.map((e) {
      return CheckboxListTile(
        dense: true,
        value: _getProjectsRequest.types?.contains(e.value) ?? false,
        onChanged: (bool? value) {
          List<int>? selectedTypes = _getProjectsRequest.types?.toList();

          if (value ?? false) {
            if (selectedTypes != null) {
              selectedTypes.add(e.value);
            } else {
              selectedTypes = [e.value];
            }
          } else {
            selectedTypes?.remove(e.value);
          }

          debugPrint(selectedTypes.toString());

          setState(() {
            _getProjectsRequest =
                _getProjectsRequest.copyWith(types: selectedTypes);
          });
        },
        title: Text(e.label),
      );
    }).toList();
  }

  List<Widget>? _getSpatialCoverages() {
    return _options!.spatialCoverages?.map((e) {
      return CheckboxListTile(
        dense: true,
        value: _getProjectsRequest.spatialCoverages?.contains(e.value) ?? false,
        onChanged: (bool? value) {
          List<int>? selectedItems =
              _getProjectsRequest.spatialCoverages?.toList();

          if (value ?? false) {
            if (selectedItems != null) {
              selectedItems.add(e.value);
            } else {
              selectedItems = [e.value];
            }
          } else {
            selectedItems?.remove(e.value);
          }

          debugPrint(selectedItems.toString());

          setState(() {
            _getProjectsRequest =
                _getProjectsRequest.copyWith(spatialCoverages: selectedItems);
          });
        },
        title: Text(e.label),
      );
    }).toList();
  }

  List<Widget>? _getPdpChapters() {
    return _options!.pdpChapters?.map((e) {
      return CheckboxListTile(
        dense: true,
        value: _getProjectsRequest.pdpChapters?.contains(e.value) ?? false,
        onChanged: (bool? value) {
          List<int>? selectedItems = _getProjectsRequest.pdpChapters?.toList();

          if (value ?? false) {
            if (selectedItems != null) {
              selectedItems.add(e.value);
            } else {
              selectedItems = [e.value];
            }
          } else {
            selectedItems?.remove(e.value);
          }

          debugPrint(selectedItems.toString());

          setState(() {
            _getProjectsRequest =
                _getProjectsRequest.copyWith(pdpChapters: selectedItems);
          });
        },
        title: Text(e.label),
      );
    }).toList();
  }

  List<Widget>? _getCategories() {
    return _options!.categories?.map((e) {
      return CheckboxListTile(
        dense: true,
        value: _getProjectsRequest.categories?.contains(e.value) ?? false,
        onChanged: (bool? value) {
          List<int>? selectedItems = _getProjectsRequest.categories?.toList();

          if (value ?? false) {
            if (selectedItems != null) {
              selectedItems.add(e.value);
            } else {
              selectedItems = [e.value];
            }
          } else {
            selectedItems?.remove(e.value);
          }

          debugPrint(selectedItems.toString());

          setState(() {
            _getProjectsRequest =
                _getProjectsRequest.copyWith(categories: selectedItems);
          });
        },
        title: Text(e.label),
      );
    }).toList();
  }

  List<Widget>? _getProjectStatuses() {
    return _options!.projectStatuses?.map((e) {
      return CheckboxListTile(
        dense: true,
        value: _getProjectsRequest.projectStatuses?.contains(e.value) ?? false,
        onChanged: (bool? value) {
          List<int>? selectedItems =
              _getProjectsRequest.projectStatuses?.toList();

          if (value ?? false) {
            if (selectedItems != null) {
              selectedItems.add(e.value);
            } else {
              selectedItems = [e.value];
            }
          } else {
            selectedItems?.remove(e.value);
          }

          debugPrint(selectedItems.toString());

          setState(() {
            _getProjectsRequest =
                _getProjectsRequest.copyWith(projectStatuses: selectedItems);
          });
        },
        title: Text(e.label),
      );
    }).toList();
  }

  List<Widget>? _getFundingSources() {
    return _options!.fundingSources?.map((e) {
      return CheckboxListTile(
        dense: true,
        value: _getProjectsRequest.fundingSources?.contains(e.value) ?? false,
        onChanged: (bool? value) {
          List<int>? selectedItems =
              _getProjectsRequest.fundingSources?.toList();

          if (value ?? false) {
            if (selectedItems != null) {
              selectedItems.add(e.value);
            } else {
              selectedItems = [e.value];
            }
          } else {
            selectedItems?.remove(e.value);
          }

          debugPrint(selectedItems.toString());

          setState(() {
            _getProjectsRequest =
                _getProjectsRequest.copyWith(fundingSources: selectedItems);
          });
        },
        title: Text(e.label),
      );
    }).toList();
  }

  List<Widget>? _getPipsStatuses() {
    return _options!.pipsStatuses?.map((e) {
      return CheckboxListTile(
        dense: true,
        value: _getProjectsRequest.pipsStatuses?.contains(e.value) ?? false,
        onChanged: (bool? value) {
          List<int>? selectedItems = _getProjectsRequest.pipsStatuses?.toList();

          if (value ?? false) {
            if (selectedItems != null) {
              selectedItems.add(e.value);
            } else {
              selectedItems = [e.value];
            }
          } else {
            selectedItems?.remove(e.value);
          }

          debugPrint(selectedItems.toString());

          setState(() {
            _getProjectsRequest =
                _getProjectsRequest.copyWith(pipsStatuses: selectedItems);
          });
        },
        title: Text(e.label),
      );
    }).toList();
  }

  List<Widget>? _getPipolStatuses() {
    return _options!.pipolStatuses?.map((e) {
      return CheckboxListTile(
        dense: true,
        value: _getProjectsRequest.pipolStatuses?.contains(e.value) ?? false,
        onChanged: (bool? value) {
          List<int>? selectedItems =
              _getProjectsRequest.pipolStatuses?.toList();

          if (value ?? false) {
            if (selectedItems != null) {
              selectedItems.add(e.value);
            } else {
              selectedItems = [e.value];
            }
          } else {
            selectedItems?.remove(e.value);
          }

          debugPrint(selectedItems.toString());

          setState(() {
            _getProjectsRequest =
                _getProjectsRequest.copyWith(pipolStatuses: selectedItems);
          });
        },
        title: Text(e.label),
      );
    }).toList();
  }
}
