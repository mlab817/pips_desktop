import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pips/common/widgets/web_layout.dart';
import 'package:pips/data/requests/projects/get_projects_request.dart';
import 'package:pips/features/dashboard/domain/usecase/projects_usecase.dart';
import 'package:pips/features/dashboard/presentation/widgets/project_listtile.dart';

import '../../../../app/dep_injection.dart';
import '../../../../common/resources/sizes_manager.dart';
import '../../../../common/widgets/responsive.dart';
import '../../../../constants/constants.dart';
import '../../../project/domain/models/pips_status.dart';
import '../../../project/domain/models/presets.dart';
import '../../../project/domain/usecase/presets_usecase.dart';
import '../../domain/models/project.dart';
import '../../domain/usecase/pipsstatuses_usecase.dart';
import '../widgets/new_pap_button.dart';
import '../widgets/project_content.dart';

class MainWebView extends ConsumerStatefulWidget {
  const MainWebView({Key? key}) : super(key: key);

  @override
  ConsumerState<MainWebView> createState() => _MainWebViewState();
}

class _MainWebViewState extends ConsumerState<MainWebView> {
  final GlobalKey<PopupMenuButtonState> _popupMenuButtonState =
      GlobalKey<PopupMenuButtonState>();

  late ScrollController _scrollController;
  final ProjectsUseCase _projectsUseCase = instance<ProjectsUseCase>();
  final PipsStatusesUseCase _pipsStatusesUseCase =
      instance<PipsStatusesUseCase>();
  final PresetsUseCase _presetsUseCase = instance<PresetsUseCase>();
  late GetProjectsRequest _getProjectsRequest;

  int _total = 0;
  int _start = 1;
  int _end = 1;
  bool _loading = false;
  String? _error;
  List<Project> _projects = [];
  int _currentPage = 1;
  final int _perPage = 50;
  String? _search;
  int _selectedStatus = 1;
  List<PipsStatus> _statuses = [];
  final List<Preset> _presets = [];
  Project? _selectedProject;

  Future<void> _getStatuses() async {
    (await _pipsStatusesUseCase.execute(Void())).fold((failure) {
      setState(() {
        _error = failure.message;
      });
    }, (response) {
      setState(() {
        _statuses = response.data;
      });
    });
  }

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
      pipsStatuses: [_selectedStatus],
    );

    _loadProjects();
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebLayout(child: _buildMainBody());
  }

  Widget _buildMainBody() {
    return Expanded(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (ResponsiveWidget.isLargeScreen(context)) _buildSidePanel(),
              // Main Body
              const SizedBox(
                width: AppSize.md,
              ),
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

  Widget _buildSidePanel() {
    final windowHeight = MediaQuery.of(context).size.height - 86;

    return SizedBox(
      height: windowHeight,
      width: AppSize.s240,
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppPadding.md,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: double.infinity,
                height: AppSize.s48,
                child: NewPapButton(),
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
                    selected: _selectedStatus == _statuses[index].id,
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
                          style: _selectedStatus == _statuses[index].id
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
                      style: _selectedStatus == _statuses[index].id
                          ? const TextStyle(fontWeight: FontWeight.bold)
                          : const TextStyle(fontWeight: FontWeight.normal),
                    ),
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    onTap: () {
                      //
                      setState(() {
                        _selectedStatus = _statuses[index].id;

                        // reset page to 1
                        _currentPage = 1;

                        // add statuses
                        _getProjectsRequest = _getProjectsRequest
                            .copyWith(pipsStatuses: [_statuses[index].id]);
                      });

                      _loadProjects();
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
      ),
    );
  }

  Widget _buildListNavigator() {
    return AppBar(
      scrolledUnderElevation: 0.0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      toolbarHeight: AppSize.s48,
      shadowColor: Colors.grey,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '$_start-$_end of $_total',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      actions: [
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
            // reload current page
            _loadProjects();
          },
          icon: const Icon(Icons.refresh),
          tooltip: 'Reload',
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
    );
  }

  // can be replaced with project content when a project is selected
  Widget _buildList() {
    final windowHeight = MediaQuery.of(context).size.height;

    if (_selectedProject != null) {
      return ProjectContentView(
        project: _selectedProject!,
        onBack: () {
          setState(() {
            _selectedProject = null;
          });
        },
      );
    }

    return _error != null
        ? Center(child: Text(_error!))
        : Card(
            color: Colors.white,
            borderOnForeground: true,
            elevation: AppSize.s2,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSize.lg),
                topRight: Radius.circular(AppSize.lg),
                bottomLeft: Radius.circular(AppSize.lg),
              ),
            ),
            child: Column(
              children: [
                _buildListNavigator(),
                if (_loading) const LinearProgressIndicator(),
                SizedBox(
                  height: windowHeight - AppSize.s140,
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
                                  onTap: () {
                                    setState(() {
                                      _selectedProject = _projects[index];
                                    });
                                  });
                            },
                          ),
                        ),
                      )),
                ),
              ],
            ),
          );
  }
}
