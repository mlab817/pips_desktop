import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pips/app/routes.dart';
import 'package:pips/data/requests/projects/get_projects_request.dart';
import 'package:pips/domain/usecase/projects_usecase.dart';

import '../../../app/dep_injection.dart';
import '../../../domain/models/project.dart';
import '../../resources/sizes_manager.dart';
import '../../resources/strings_manager.dart';

class FilterProjectsView extends StatefulWidget {
  const FilterProjectsView({Key? key, required this.request}) : super(key: key);

  final GetProjectsRequest request;

  @override
  State<FilterProjectsView> createState() => _FilterProjectsViewState();
}

class _FilterProjectsViewState extends State<FilterProjectsView> {
  final ProjectsUseCase _projectsUseCase = instance<ProjectsUseCase>();

  final List<Project> _projects = [];

  late ScrollController _scrollController;
  bool _isLoading = false;
  String? _error;
  int _page = 1;
  int _total = 0;

  Future<void> _loadMoreData() async {
    if (_isLoading) {
      return;
    }

    setState(() {
      _isLoading = true;
      _page++;
    });

    (await _projectsUseCase.execute(widget.request.copyWith(page: _page))).fold(
        (failure) {
      setState(() {
        _error = failure.message;
        _isLoading = false;
      });
    }, (response) {
      setState(() {
        _projects.addAll(response.data);
        _total = response.meta.pagination.total;
        _isLoading = false;
      });
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >
        0.8 * _scrollController.position.maxScrollExtent) {
      _loadMoreData();
    }
  }

  @override
  void initState() {
    super.initState();

    // reset page
    _page = 1;

    _loadMoreData();

    _scrollController = ScrollController();

    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.removeListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading && _projects.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      return Column(
        children: [
          Text(_error!),
          const SizedBox(height: AppSize.md),
          ElevatedButton(
            onPressed: _loadMoreData,
            child: Text(AppStrings.tryAgain.toUpperCase()),
          ),
        ],
      );
    }

    return _projects.isEmpty
        ? const Center(
            child: Text('No Items Found'),
          )
        : _buildList();
  }

  Widget _buildList() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppPadding.md),
          child: Text("$_total Items Found"),
        ),
        Expanded(
          child: ListView.separated(
              shrinkWrap: true,
              controller: _scrollController,
              itemCount: _projects.length + 1,
              separatorBuilder: (context, index) => Divider(
                    color: Theme.of(context).dividerColor,
                  ),
              itemBuilder: (context, index) {
                if (index == _projects.length) {
                  return Center(
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : const Text('End of List'),
                  );
                }

                final projects = _projects;

                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.viewProjectRoute,
                        arguments: projects[index].uuid);
                  },
                  title: Text(
                    projects[index].title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(projects[index].pipolCode ?? 'NO PIPOL CODE'),
                );
              }),
        ),
      ],
    );
  }
}
