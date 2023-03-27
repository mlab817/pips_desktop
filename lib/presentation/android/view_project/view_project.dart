import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:pips/data/requests/filter_project/filter_project_request.dart';
import 'package:pips/domain/usecase/project_usecase.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';

import '../../../app/routes.dart';
import '../../../domain/models/project.dart';

class ViewProjectView extends StatefulWidget {
  const ViewProjectView({Key? key, required this.uuid}) : super(key: key);

  final String uuid;

  @override
  State<ViewProjectView> createState() => _ViewProjectViewState();
}

class _ViewProjectViewState extends State<ViewProjectView> {
  final ProjectUseCase _projectUseCase = instance<ProjectUseCase>();

  Project? _project;
  String? _error;

  final f = NumberFormat();

  // load project
  Future<void> _loadProject() async {
    (await _projectUseCase.execute(widget.uuid)).fold((failure) {
      setState(() {
        _error = failure.message;
      });
    }, (response) {
      setState(() {
        _project = response.project;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _loadProject();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Program/Project Details"),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return _buildDialog();
                  });
            },
            icon: const Icon(Icons.info_outline),
            tooltip: 'View Information',
          ),
        ],
      ),
      body: _project != null
          ? SingleChildScrollView(child: _buildProject())
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _buildProject() {
    return _project != null
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Title'),
                subtitle: Text(_project?.title ?? 'no title'),
              ),
              ListTile(
                title: const Text('Office'),
                subtitle: Text(_project?.office?.acronym ?? 'no office'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  if (_project?.office?.id != null) {
                    Navigator.pushNamed(context, Routes.filterByPropertyRoute,
                        arguments: FilterProjectRequest(
                            filter: 'office', value: _project!.office!.id));
                  }
                },
              ),
              ListTile(
                title: const Text('Description'),
                subtitle: Text(_project?.description ?? 'no description'),
              ),
              ListTile(
                title: const Text('Spatial Coverage'),
                subtitle: Text(
                    _project?.spatialCoverage?.name ?? 'no spatial coverage'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  if (_project?.office?.id != null) {
                    Navigator.pushNamed(context, Routes.filterByPropertyRoute,
                        arguments: FilterProjectRequest(
                            filter: 'spatial_coverage',
                            value: _project!.spatialCoverage!.id));
                  }
                },
              ),
              ListTile(
                title: const Text('Total Cost'),
                subtitle: Text("PHP ${f.format(_project?.totalCost ?? 0)}"),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.xl),
                  child: SizedBox(
                    height: AppSize.s36,
                    child: ElevatedButton(
                      onPressed: () {
                        //
                        Navigator.pushNamed(context, Routes.viewPdfRoute,
                            arguments: widget.uuid);
                      },
                      child: const Text('View PDF'),
                    ),
                  ),
                ),
              )
            ],
          )
        : const Center(child: Text('Failed to load project profile'));
  }

  Widget _buildDialog() {
    if (_project == null) {
      return Container();
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppSize.md,
        ),
      ),
      icon: const Icon(
        Icons.info_outline,
        size: AppSize.s36,
      ),
      contentPadding: const EdgeInsets.all(AppSize.sm),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            color: Theme.of(context).dividerColor,
          ),
          ListTile(
            title: const Text('Added by'),
            subtitle: Text(
              _project?.user?.fullname ?? 'Unknown User',
            ),
          ),
          ListTile(
            title: const Text('Last updated on'),
            subtitle: _project != null
                ? Text(DateFormat.yMMMd()
                    .add_jms()
                    .format(DateTime.parse(_project!.updatedAt)))
                : const Text('Unknown'),
          ),
        ],
      ),
    );
  }
}
