import 'package:flutter/material.dart';

import '../../../app/routes.dart';
import '../../../domain/models/project.dart';

class SearchProjects extends SearchDelegate<String> {
  SearchProjects({
    required this.projects,
  });

  final List<Project> projects;

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop('');
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isNotEmpty
        ? projects
            .where((project) =>
                project.title.toLowerCase().contains(query.toLowerCase()))
            .toList()
        : [];

    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.pushNamed(context, Routes.viewProjectRoute,
                  arguments: suggestions[index].uuid);
            },
            title: Text(suggestions[index].title),
          );
        });
  }

  @override
  Future<void> showResults(BuildContext context) async {
    debugPrint("query: $query");

    final results = await Navigator.pushNamed(
      context,
      Routes.searchResultsPageRoute,
      arguments: query,
    );

    // showSearch(context: context, delegate: SearchProjects(), query: '');
  }
}
