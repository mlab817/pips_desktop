import 'package:flutter/material.dart';
import 'package:pips/domain/models/full_project.dart';

class ProjectProvider with ChangeNotifier {
  late FullProject project;

  void initProject() {
    project = FullProject();

    notifyListeners();
  }
}