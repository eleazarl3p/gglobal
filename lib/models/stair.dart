import 'package:flutter/cupertino.dart';

import 'flight.dart';

class Stair extends ChangeNotifier {
  String _id = '';
  bool selected = false;
  List<Flight> _flights = [];

  Stair({id = ''}) {
    _id = id;
    _flights = flights;
  }

  get id => _id;
  set setId(String id) {
    _id = id;
  }

  get flights => [..._flights];

  void addFlight(Flight flight) {
    _flights.add(flight);
    notifyListeners();
  }

  void removeFlight(Flight flight) {
    _flights.remove(flight);
    notifyListeners();
  }

  void clear() {
    _flights.clear();
    notifyListeners();
  }

  factory Stair.copy(Stair obj) {
    Stair newStair = Stair(id: "${obj._id} copy");
    newStair._flights = [...obj.flights];
    return newStair;
  }

  Map toJson() {
    List myFlights = _flights.map((e) => e.toJson()).toList();
    return {"id": id, "flights": myFlights};
  }

  //Stair.fromJson(Map<String , dynamic> json) : _id = json['id'], _flights = json['flights'];
  factory Stair.fromJson(Map<String , dynamic> json) {

    final st = Stair(id:  json['id']);
    for (var fl in json['flights']) {
      st.addFlight(Flight.fromJson(fl));
    }

   
    return st;

  }
}
