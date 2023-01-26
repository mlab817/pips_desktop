import 'package:flutter/material.dart';
import 'package:pips/domain/models/project.dart';
import 'package:pips/domain/usecase/projects_usecase.dart';

import '../../../app/dep_injection.dart';
import '../../../data/responses/projects/projects_response.dart';
import '../../../domain/usecase/base_usecase.dart';

class ProjectsView extends StatefulWidget {
  const ProjectsView({Key? key}) : super(key: key);

  @override
  State<ProjectsView> createState() => _ProjectsViewState();
}

class _ProjectsViewState extends State<ProjectsView> {
  final ProjectsUseCase _projectsUseCase = instance<ProjectsUseCase>();

  Future<Result<ProjectsResponse>> _getProjects() async {
    final resp = await _projectsUseCase.execute(null);

    debugPrint(resp.data.toString());

    return resp;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Result<ProjectsResponse>>(
        future: _getProjects(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = snapshot.data?.data?.data ?? <Project>[];

          return const Center(
            child: Text('Some stuff'),
          );
        });
  }
}
