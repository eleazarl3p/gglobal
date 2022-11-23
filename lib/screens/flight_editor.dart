import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/Utils/flight_data_input.dart';
import '/models/flight.dart';

import '../Utils/cuadro.dart';
import '../Utils/cuadro_on_dev.dart';
import '../Utils/flight_data_input_on_dev.dart';
import '../Utils/stair_painter.dart';
import '../models/flight_map.dart';

class FlightEditor extends StatelessWidget {
  FlightEditor(
      {Key? key,
      required this.pIndex,
      required this.sIndex,
      required this.fIndex})
      : super(key: key);

  int pIndex;
  int sIndex;
  int fIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // leading: IconButton(
          //   icon: const Icon(Icons.arrow_back),
          // onPressed: () => AlertDialog(
          //   title: const Text("Project's name"),
          //   actions: [
          //     TextButton.icon(
          //       onPressed: () {
          //         // if (projectNameController
          //         //     .text.length >
          //         //     1) {
          //         //   pjsProvider.addProject(Project(
          //         //       id: projectNameController
          //         //           .text, stairs: <Stair>[]));
          //         //   projectNameController.text = '';
          //
          //         //   Navigator.pop(context);
          //         // }
          //       },
          //       icon: const Icon(Icons.check),
          //       label: const Text("OK"),
          //     ),
          //     TextButton.icon(
          //       onPressed: () {
          //         Navigator.pop(context);
          //       },
          //       icon: const Icon(Icons.cancel),
          //       label: const Text("Cancel"),
          //     ),
          //   ],
          // ),
          //  ),
          // title: const Text("Sample"),
          // centerTitle: true,
          ),
      body:
          //MultiProvider(
          // providers: [
          //   ChangeNotifierProvider(create: (context)=> FlightMap())
          //   //ChangeNotifierProvider(create: (context)=> Flight(id: flightData.id, riser: flightData.riser, bevel: flightData.bevel, numberOfSteps: flightData.numberOfSteps, topCrotch: true, topCrotchDistance: 0.0, bottomCrotch: true, bottomCrotchDistance: 0.0, bottomCrotchPost: true, bottomPostList: [], rampPostList: [], topPostList: []))
          // ],
          // child:
          Row(children: [
        const Expanded(
          //flex: 2,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Cuadro(),
          ),
        ),
        SizedBox(
          width: 400.0,
          child: FlightDataInput(
            pIndex: pIndex,
            sIndex: sIndex,
            fIndex: fIndex,
          ),
        ),
      ]),
    );
    // );
  }
}
