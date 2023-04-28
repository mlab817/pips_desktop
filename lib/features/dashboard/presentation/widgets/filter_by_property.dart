import 'package:flutter/material.dart';
import 'package:pips/common/resources/sizes_manager.dart';
import 'package:pips/common/resources/strings_manager.dart';
import 'package:pips/features/dashboard/data/network/requests/filter_project/filterproject_request.dart';
import 'package:pips/features/dashboard/domain/models/project.dart';

import '../../../../app/dep_injection.dart';
import '../../../../routing/routing.dart';
import '../../../project/domain/models/options.dart';
import '../../domain/usecase/filterproject_usecase.dart';

class FilterByPropertyView extends StatefulWidget {
  const FilterByPropertyView({Key? key, required this.request})
      : super(key: key);

  final FilterProjectRequest request;

  @override
  State<FilterByPropertyView> createState() => _FilterByPropertyViewState();
}

class _FilterByPropertyViewState extends State<FilterByPropertyView> {
  final FilterProjectUseCase _filterProjectUseCase =
      instance<FilterProjectUseCase>();

  late ScrollController _scrollController;

  Option? _model;
  List<Project> _projects = [];
  int? _total;
  String? _error;
  bool _loading = true;
  int _currentPage = 1;
  int _last = 1;

  Future<void> _filterProjects() async {
    final request = widget.request.copyWith(page: _currentPage);

    (await _filterProjectUseCase.execute(request)).fold((failure) {
      setState(() {
        _error = failure.message;
        _loading = false;
      });
    }, (response) {
      setState(() {
        _projects.addAll(response.data);
        _model = response.model;
        _total = response.total;
        _last = response.last;
        _currentPage++;
        _loading = false;
      });
    });
  }

  void _scrollListener() {
    // if the currentPage is already the last, do not proceed to load next page
    if (_currentPage > _last) {
      return;
    }

    // if the current status is loading, do not call next page
    if (_loading) {
      return;
    }

    // when the scroll position is at 80%
    var nextPageTrigger = _scrollController.position.maxScrollExtent * 0.8;

    if (_scrollController.position.pixels > nextPageTrigger) {
      setState(() {
        _loading = true;
        _filterProjects();
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _filterProjects();

    _scrollController = ScrollController();

    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _scrollController.dispose();

    _scrollController.removeListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    if (_projects.isEmpty) {
      if (_loading) {
        return const Material(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (_error != null) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
          ),
          body: Column(children: [
            Text(_error!),
            const SizedBox(height: AppSize.s20),
            ElevatedButton(
              onPressed: () {
                _filterProjects();
              },
              child: const Text(AppStrings.tryAgain),
            ),
          ]),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _model!.label.toUpperCase(),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      body: _projects.isEmpty
          ? _buildEmpty()
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppPadding.md),
                  child: Text("$_total items found"),
                ),
                Expanded(child: _buildList())
              ],
            ),
    );
  }

  Widget _buildEmpty() {
    return Container();
  }

  Widget _buildList() {
    return ListView.separated(
      controller: _scrollController,
      itemCount: _projects.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == _projects.length) {
          return Center(
            child: _loading
                ? const CircularProgressIndicator()
                : const Text('End of List'),
          );
        }

        final project = _projects[index];

        return ListTile(
          title: Text("${project.office?.acronym ?? 'N/A'} - ${project.title}"),
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
}
