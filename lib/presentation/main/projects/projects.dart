import 'package:flutter/material.dart';
import 'package:pips/data/requests/projects/get_projects_request.dart';
import 'package:pips/data/responses/projects/projects_response.dart';
import 'package:pips/domain/usecase/base_usecase.dart';
import 'package:pips/domain/usecase/projects_usecase.dart';

import '../../../app/dep_injection.dart';
import '../../../domain/models/project.dart';
import '../../resources/sizes_manager.dart';

class ProjectsView extends StatefulWidget {
  const ProjectsView({Key? key}) : super(key: key);

  @override
  State<ProjectsView> createState() => _ProjectsViewState();
}

class _ProjectsViewState extends State<ProjectsView> {
  final ProjectsUseCase _projectsUseCase = instance<ProjectsUseCase>();

  Future<Result<ProjectsResponse>> _getProjects() async {
    return await _projectsUseCase
        .execute(GetProjectsRequest(perPage: 25, page: 1));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getProjects(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data?.data?.data?.length ?? 0,
            itemBuilder: (context, index) {
              final project = snapshot.data?.data?.data?[index];
              return ProjectItem(
                project: project!,
                onTap: () {},
              );
            },
          );
        });
  }
}

class ProjectItem extends StatefulWidget {
  const ProjectItem({Key? key, required this.project, required this.onTap})
      : super(key: key);

  final Project project;
  final VoidCallback onTap;

  @override
  State<ProjectItem> createState() => _ProjectItemState();
}

class _ProjectItemState extends State<ProjectItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;

    return GestureDetector(
      child: MouseRegion(
        onEnter: (_) => setState(() {
          _isHovered = true;
        }),
        onExit: (_) => setState(() {
          _isHovered = false;
        }),
        child: ListTile(
          onTap: widget.onTap,
          title: Text(project.title),
          trailing: _isHovered
              ? SizedBox(
                  width: AppSize.s150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.visibility)),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.delete)),
                    ],
                  ),
                )
              : Text(project.updatedAt.toString()),
        ),
      ),
    );
  }
}
