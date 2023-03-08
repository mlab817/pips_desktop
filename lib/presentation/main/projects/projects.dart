import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:pips/data/requests/projects/get_projects_request.dart';
import 'package:pips/domain/models/project.dart';
import 'package:pips/domain/usecase/projects_usecase.dart';

import '../../../app/routes.dart';

class ProjectsView extends StatefulWidget {
  const ProjectsView({Key? key}) : super(key: key);

  @override
  State<ProjectsView> createState() => _ProjectsViewState();
}

class _ProjectsViewState extends State<ProjectsView>
    with AutomaticKeepAliveClientMixin {
  final ProjectsUseCase _projectsUseCase = instance<ProjectsUseCase>();
  late ScrollController _scrollController;

  final List<Project> _projects = [];
  String? _error;
  int _currentPage = 1;
  int _lastPage = 1;
  bool _loading = true;

  get _isLast {
    return _lastPage >= _currentPage;
  }

  Future<void> _loadProjects() async {
    setState(() {
      _loading = true;
    });

    final response =
        await _projectsUseCase.execute(GetProjectsRequest(page: _currentPage));

    setState(() {
      if (response.success) {
        _projects.addAll(response.data?.data ?? []);
        _lastPage = response.data?.meta.pagination.last ?? 1;
        _loading = false;
        _currentPage++;
      } else {
        _error = response.error;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    _loadProjects();
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      var nextPageTrigger = 0.8 * _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels > nextPageTrigger &&
          !_loading &&
          !_isLast) {
        debugPrint('next page called');
        _loadProjects();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: _projects.isNotEmpty
          ? ListView.separated(
              controller: _scrollController,
              itemCount: _projects!.length,
              itemBuilder: (context, index) {
                final project = _projects![index];

                return ListTile(
                  title: Text(
                    project.title,
                    maxLines: 2,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  isThreeLine: true,
                  subtitle: Text(project.pipolCode ?? ''),
                  trailing: Text(
                      "${(project.totalCost ?? 0 / pow(10, 6)).toString()} M"),
                  onTap: () {
                    Navigator.pushNamed(context, Routes.viewProjectRoute,
                        arguments: project.uuid);
                  },
                );
              },
              separatorBuilder: (context, index) => Divider(
                color: Theme.of(context).dividerColor,
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
