import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import '/models/project.dart';

//import 'package:json_annotation/json_annotation.dart';




class Projects extends ChangeNotifier {
  List<Project> _projects = [];

  void addProject(Project project) {
    _projects.add(project);
    notifyListeners();
  }

  void removeProject(Project project) {
    _projects.remove(project);
    notifyListeners();
  }

  void resetProject() {
    _projects.clear();
    //notifyListeners();
  }

  void massiveUpdate(Project project){
    _projects.add(project);
  }

  get projects {
    return [..._projects];
  }


}
