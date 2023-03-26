import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:pips/data/requests/projects/get_projects_request.dart';
import 'package:pips/data/responses/projects/projects_response.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:skeletons/skeletons.dart';

import '../../../../app/dep_injection.dart';
import '../../../../app/routes.dart';
import '../../../../data/network/failure.dart';
import '../../../../domain/models/project.dart';
import '../../../../domain/usecase/projects_usecase.dart';

class SearchResultsPage extends StatelessWidget {
  SearchResultsPage({Key? key, required this.query}) : super(key: key);

  final String query;

  final ProjectsUseCase _projectsUseCase = instance<ProjectsUseCase>();

  Future<dartz.Either<Failure, ProjectsResponse>> _searchProjects(query) async {
    return await _projectsUseCase.execute(GetProjectsRequest(q: query));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: FutureBuilder(
          future: _searchProjects(query),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final data = snapshot.data;

                return data?.fold((failure) {
                      return Center(child: Text(failure.message));
                    }, (response) {
                      final list = response.data;

                      return _buildList(list);
                    }) ??
                    Container();
              }
            }
            return SkeletonLoader(
                builder: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                          color: Theme.of(context).dividerColor,
                        ),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(AppPadding.md),
                        child: SkeletonListTile(
                          hasLeading: false,
                          hasSubtitle: true,
                        ),
                      );
                    }));
          }),
    );
  }

  Widget _buildList(List<Project> data) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: Theme.of(context).dividerColor,
      ),
      itemBuilder: (context, index) => ListTile(
        title: Text(
          data[index].title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {
          //
          Navigator.of(context)
              .pushNamed(Routes.viewProjectRoute, arguments: data[index].uuid);
        },
      ),
      itemCount: data.length,
    );
    ;
  }
}
