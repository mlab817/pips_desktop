import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:pips/domain/usecase/project_usecase.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';

import '../../app/routes.dart';
import '../../domain/models/project.dart';

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
    final response = await _projectUseCase.execute(widget.uuid);

    setState(() {
      if (response.success) {
        _project = response.data?.project;
      } else {
        _error = response.error;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loadProject();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Program/Project Details"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.share))],
      ),
      body: _project != null
          ? _buildProject()
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _buildProject() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: const Text('Title'),
          subtitle: Text(_project?.title ?? 'no title'),
        ),
        ListTile(
          title: const Text('Description'),
          subtitle: Text(_project?.description ?? 'no description'),
        ),
        ListTile(
          title: const Text('Spatial Coverage'),
          subtitle:
              Text(_project?.spatialCoverage?.name ?? 'no spatial coverage'),
        ),
        ListTile(
          title: const Text('Total Cost'),
          subtitle: Text("PHP ${f.format(_project?.totalCost ?? 0)}"),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.xl),
            child: ElevatedButton(
              onPressed: () {
                //
                Navigator.pushNamed(context, Routes.viewPdfRoute,
                    arguments: widget.uuid);
              },
              child: const Text('View PDF'),
            ),
          ),
        )
      ],
    );
  }
}
