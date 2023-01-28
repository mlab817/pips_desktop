import 'package:flutter/material.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:pips/domain/usecase/project_usecase.dart';

import '../../domain/models/project.dart';

class ProjectView extends StatefulWidget {
  const ProjectView({super.key, required this.uuid});

  final String uuid;

  @override
  State<ProjectView> createState() => _ProjectViewState();
}

class _ProjectViewState extends State<ProjectView> {
  final ProjectUseCase _projectUseCase = instance<ProjectUseCase>();
  // load data
  Project? _project;

  Future<void> _getProject() async {
    final projectResponse = await _projectUseCase.execute(widget.uuid);

    if (projectResponse.success) {
      setState(() {
        _project = projectResponse.data?.project;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _getProject();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _project != null
            ? Text(_project?.title ?? "No project")
            : const Text('Loading'),
        centerTitle: false,
      ),
      body: _project != null
          ? Center(child: Text(_project.toString()))
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
