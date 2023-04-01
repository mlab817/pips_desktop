import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:pips/data/requests/projects/get_projects_request.dart';
import 'package:pips/domain/models/project.dart';
import 'package:pips/domain/usecase/projects_usecase.dart';
import 'package:pips/presentation/common/project_item.dart';
import 'package:pips/presentation/main/home/filter_bottom_sheet.dart';
import 'package:pips/presentation/main/home/search_projects.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:skeletons/skeletons.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../../app/routes.dart';
import '../../resources/sizes_manager.dart';
import '../../resources/strings_manager.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  final ProjectsUseCase _projectsUseCase = instance<ProjectsUseCase>();
  late ScrollController _scrollController;

  final List<Project> _projects = [];
  int _currentPage = 1;
  int _lastPage = 1;
  bool _loading = true;
  String? _error;

  late GetProjectsRequest _getProjectsRequest;

  bool get _isLast {
    return _currentPage == _lastPage;
  }

  Future<void> _loadProjects() async {
    (await _projectsUseCase.execute(_getProjectsRequest)).fold((failure) {
      setState(() {
        _error = failure.message;
        _loading = false;
      });
    }, (response) {
      setState(() {
        _lastPage = response.meta.pagination.last;
        _currentPage += 1;
        _getProjectsRequest = _getProjectsRequest.copyWith(page: _currentPage);
        _projects.addAll(response.data);
        _loading = false;
      });
    });
  }

  void _scrollListener() {
    var nextPageTrigger = 0.8 * _scrollController.position.maxScrollExtent;

    if (_scrollController.position.pixels > nextPageTrigger) {
      if (_loading) {
        return;
      }

      if (_isLast) {
        return;
      }

      _loading = true;

      // if already in the last page, do not load next page
      _loadProjects();
    }
  }

  @override
  void initState() {
    super.initState();

    _getProjectsRequest = GetProjectsRequest();

    _loadProjects();

    _scrollController = ScrollController();

    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.removeListener(_scrollListener);

    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.home),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  useSafeArea: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return const FilterBottomSheet();
                  });
            },
            icon: const Icon(Icons.filter_list_alt),
          ),
          _buildSearchAction(),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    //

    // first time loading - show big loading indicator
    if (_projects.isEmpty) {
      if (_loading) {
        return _buildLoader();
      }

      if (_error != null) {
        return _buildError(); // TODO: Add retry button
      }

      return const Center(
        child: Text('No data'),
      );
    }
    // first time error - show big error with retry
    // succeeding loading - show loading as another list item
    // succeeding error - show error as another list item
    if (_projects.isNotEmpty) {
      return ListView.separated(
        controller: _scrollController,
        itemCount: _projects.length + 1,
        itemBuilder: (context, index) {
          if (index == _projects.length) {
            return _loading
                ? const SizedBox(
                    height: AppSize.s40,
                    child: Center(child: CircularProgressIndicator()))
                : (_error != null)
                    ? _buildError()
                    : Container();
          }

          final project = _projects[index];

          if (UniversalPlatform.isDesktopOrWeb) {
            return ProjectItem(project: project);
          }

          return ListTile(
            title: Text(
              "${project.office?.acronym} - ${project.title}",
              maxLines: 2,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            isThreeLine: true,
            subtitle: Text(project.pipolCode ?? ''),
            trailing: project.totalCost != null
                ? Text(
                    "${(project.totalCost! / pow(10, 6)).toStringAsFixed(2)} M")
                : null,
            onTap: () {
              Navigator.pushNamed(context, Routes.viewProjectRoute,
                  arguments: project.uuid);
            },
          );
        },
        separatorBuilder: (context, index) => Divider(
          color: Theme.of(context).dividerColor,
        ),
      );
    }

    return Container();
  }

  Widget _buildError() {
    return Center(
      child: Column(
        children: [
          Text(_error!),
          ElevatedButton(
            onPressed: _loadProjects,
            child: const Text(AppStrings.tryAgain),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAction() {
    return IconButton(
      onPressed: () {
        showSearch(
          context: context,
          delegate: SearchProjects(projects: _projects),
        );
      },
      icon: const Icon(Icons.search),
    );
  }

  Widget _buildList() {
    return ListView.separated(
      controller: _scrollController,
      itemCount: _projects.length,
      itemBuilder: (context, index) {
        final project = _projects[index];

        if (UniversalPlatform.isDesktopOrWeb) {
          return ProjectItem(project: project);
        }

        return ListTile(
          title: Text(
            project.title,
            maxLines: 2,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          isThreeLine: true,
          subtitle: Text(project.pipolCode ?? ''),
          trailing: project.totalCost != null
              ? Text("${(project.totalCost! / pow(10, 6)).toString()} M")
              : null,
          onTap: () {
            Navigator.pushNamed(context, Routes.viewProjectRoute,
                arguments: project.uuid);
          },
        );
      },
      separatorBuilder: (context, index) => Divider(
        color: Theme.of(context).dividerColor,
      ),
    );
  }

  Widget _buildLoader() {
    return SingleChildScrollView(
      child: SkeletonLoader(
        builder: ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(AppPadding.md),
              child: SkeletonListTile(hasSubtitle: true),
            );
          },
        ),
      ),
    );
  }

  void _showError() {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Failed to load options')));
  }

  @override
  bool get wantKeepAlive => true;
}
