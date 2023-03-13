import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pips/data/requests/projects/get_projects_request.dart';
import 'package:pips/presentation/resources/assets_manager.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:skeletons/skeletons.dart';

import '../../../app/dep_injection.dart';
import '../../../app/routes.dart';
import '../../../domain/models/project.dart';
import '../../../domain/usecase/projects_usecase.dart';

class SearchResultsPage extends StatelessWidget {
  SearchResultsPage({Key? key, required this.query}) : super(key: key);

  final String query;

  final ProjectsUseCase _projectsUseCase = instance<ProjectsUseCase>();

  Future<List<Project>?> _searchProjects(query) async {
    final response =
        await _projectsUseCase.execute(GetProjectsRequest(q: query));

    if (response.success) {
      return response.data?.data;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("query: $query");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: FutureBuilder(
          future: _searchProjects(query),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(AssetsManager.animEmptyJson),
                      const Text('Nothing found.'),
                    ],
                  ),
                );
              }
              return _buildList(snapshot);
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return SkeletonLoader(
                  builder: ListView.builder(
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
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Widget _buildList(snapshot) {
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: Text(snapshot.data![index].title),
        onTap: () {
          //
          Navigator.of(context).pushNamed(Routes.viewProjectRoute,
              arguments: snapshot.data![index].uuid);
        },
      ),
      itemCount: snapshot.data?.length,
    );
    ;
  }
}
