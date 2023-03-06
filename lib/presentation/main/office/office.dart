import 'package:flutter/material.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:pips/domain/models/project.dart';
import 'package:pips/domain/usecase/office_usecase.dart';
import 'package:pips/presentation/common/project_item.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../../domain/models/office.dart';

class OfficeView extends StatefulWidget {
  const OfficeView({Key? key, required this.officeId}) : super(key: key);

  final String officeId;

  @override
  State<OfficeView> createState() => _OfficeViewState();
}

class _OfficeViewState extends State<OfficeView> {
  final OfficeUseCase _officeUseCase = instance<OfficeUseCase>();

  Office? _office;

  List<Project>? _projects;

  bool _loading = false;

  // handle fetch of office data

  Future<void> _getOffice() async {
    setState(() {
      _office = null;
      _loading = true;
      _projects = null;
    });

    final officeResponse = await _officeUseCase.execute(widget.officeId);
    if (officeResponse.success) {
      if (mounted) {
        setState(() {
          _office = officeResponse.data?.data;
          _projects = officeResponse.data?.data.projects ?? <Project>[];
          _loading = false;
        });
      }
    } else {
      debugPrint(officeResponse.error);
      setState(() {
        _loading = false;
      });
    }
    // load selected office info
  }

  void _showSearch(context) {
    showSearch(context: context, delegate: _SearchProjectDelegate(_projects));
  }

  @override
  void initState() {
    super.initState();

    _getOffice();
  }

  @override
  void didUpdateWidget(covariant OfficeView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.officeId != widget.officeId) {
      _getOffice();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        foregroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          _office?.acronym ?? 'Loading...',
        ),
        automaticallyImplyLeading: !UniversalPlatform.isDesktopOrWeb,
        elevation: AppSize.s0_5,
        actions: [
          IconButton(
            onPressed: () {
              _showSearch(context);
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (BuildContext context, int index) {
                      final project = _projects![index];

                      return ProjectItem(
                        project: project,
                      );
                    },
                    itemCount: _projects?.length ?? 0,
                  ),
                ),
              ],
            ),
    );
  }

  void _onTap() {}
}

class _SearchProjectDelegate extends SearchDelegate<String> {
  final List<Project> _projects;

  _SearchProjectDelegate(List<Project>? projects)
      : _projects = projects ?? [],
        super();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    debugPrint("query: $query");
    final results = _projects
        .where((project) =>
            project.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        itemCount: results.length,
        itemBuilder: (BuildContext context, int index) {
          final project = results[index];

          return ListTile(
            title: Text(project.title ?? ''),
            onTap: () {
              debugPrint('tapped result');
            },
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = _projects
        .where((project) =>
            project.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(suggestions[index].title),
            onTap: () {
              query = suggestions[index].title;
            },
          );
        });
  }
}
