import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pips/data/requests/projects/get_projects_request.dart';
import 'package:pips/data/responses/projects/projects_response.dart';
import 'package:pips/domain/usecase/base_usecase.dart';
import 'package:pips/domain/usecase/projects_usecase.dart';

import '../../../app/dep_injection.dart';
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
              return Slidable(
                key: Key(index.toString()),
                endActionPane: const ActionPane(
                  motion: ScrollMotion(),
                  extentRatio: 0.08,
                  children: [
                    SizedBox(
                      width: AppSize.s80,
                      height: AppSize.s80,
                      child: CustomSlidableAction(
                        // An action can be bigger than the others.
                        onPressed: null,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        child: IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.delete,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(project?.title ?? "NA"),
                  trailing: Text(project?.totalCost.toStringAsFixed(2) ?? 'NA'),
                ),
              );
            },
          );
        });
  }
}
