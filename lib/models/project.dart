import 'dart:convert';

import 'package:flutter/cupertino.dart';
import '/models/stair.dart';

class Project extends ChangeNotifier {
  String _id = '';
  List<Stair> _stairs = [];

  Project({id = '', stairs = const <Stair>[]}) {
    _id = id;
    _stairs = stairs;
  }

  get id => _id;
  get stairs => _stairs;

  set setId(String id) {
    _id = id;
  }

  factory Project.copy(Project pj) {
    return Project(id: pj._id, stairs: pj._stairs);
  }

  void addStair(Stair stair) {
    _stairs.add(stair);
    notifyListeners();
  }

  void removeStair(Stair stair) {
    _stairs.remove(stair);
    notifyListeners();
  }

  Map toJson() {
    List myStairs = _stairs.map((e) => e.toJson()).toList();

    return {"id": id, "stairs": myStairs};
  }

  // Project.fromJson(Map<String , dynamic> json) : _id = json['id'], _stairs = json['stairs'];
  factory Project.fromJson(dynamic json) {
    var data = json;
    List<Stair> myStairs = [];

    for (var st in data['stairs']) {
      myStairs.add(Stair.fromJson(st));
    }
    return Project(id: data['id'], stairs: myStairs);
  }
}
