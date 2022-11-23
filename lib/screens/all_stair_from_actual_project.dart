import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:provider/provider.dart';
import '../DB/projectCollection.dart';
import '/screens/all_flight_on_actual_stair.dart';

import '../models/Projects.dart';
import '../models/stair.dart';

import 'package:intl/intl.dart';
class StairOnCurrentProject extends StatefulWidget {
  StairOnCurrentProject({Key? key, required this.pIndex,this.cloud = false}) : super(key: key);

  int pIndex;
  bool cloud;

  @override
  State<StairOnCurrentProject> createState() => _StairOnCurrentProjectState();
}

class _StairOnCurrentProjectState extends State<StairOnCurrentProject> {
  @override
  Widget build(BuildContext context) {
    final currentProject = context.watch<Projects>().projects[widget.pIndex];

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Project : ${currentProject.id}')),
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              backgroundBlendMode: BlendMode.colorBurn, color: Colors.white12),
          child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  thickness: 3.0,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: const EdgeInsets.all(15),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(width: 2.0, color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              const Center(
                                child: Text("Project > Stairs"),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(10.0),
                                  itemCount: currentProject.stairs.length,
                                  itemBuilder: ((context, index) {
                                    return Card(
                                      //color: Colors.brown.shade100,

                                      child: ListTile(
                                        leading: Checkbox(
                                            value: currentProject
                                                .stairs[index].selected,
                                            onChanged: (value) {
                                              setState(() {
                                                currentProject
                                                    .stairs[index].selected = !currentProject
                                                    .stairs[index].selected;
                                              });


                                            }),
                                        title: Container(
                                          // width: 200,
                                          // margin:
                                          //     const EdgeInsets.only(right: 150),
                                          child: TextField(
                                            autofocus: true,
                                            decoration: const InputDecoration(
                                              labelText: "New Stair",
                                              isDense: true,
                                              contentPadding: EdgeInsets.all(8),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1.0,
                                                    color: Colors.blueGrey),
                                              ),
                                            ),
                                            controller: TextEditingController(
                                                text: currentProject
                                                    .stairs[index].id),
                                            onChanged: (value) {
                                              currentProject
                                                  .stairs[index].setId = value;
                                            },
                                          ),
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextButton.icon(
                                              onPressed: () {
                                                Stair str_ = currentProject
                                                    .stairs[index];
                                                setState(() {
                                                  currentProject.addStair(
                                                    Stair.copy(str_),
                                                  );
                                                });
                                              },
                                              icon: const Icon(Icons.copy),
                                              label: const Text('Copy'),
                                            ),
                                            TextButton.icon(
                                                // style: ButtonStyle(
                                                //   backgroundColor:
                                                //   MaterialStateProperty.all(
                                                //       Colors.amber),
                                                //   foregroundColor:
                                                //   MaterialStateProperty.all(
                                                //       Colors.white),
                                                // ),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          FlightOnActualStair(
                                                        sIndex: index,
                                                        pIndex: widget.pIndex,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                icon: const Icon(Icons.edit),
                                                label: const Text('Edit')),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            TextButton.icon(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.red),
                                                foregroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.white),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  currentProject.removeStair(
                                                      currentProject
                                                          .stairs[index]);
                                                });
                                              },
                                              icon: const Icon(Icons.delete),
                                              label: const Text('Delete'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 200,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      currentProject.addStair(Stair(id: ''));
                                    });
                                  },
                                  icon: const Icon(Icons.stairs),
                                  label: const Text("Add Stair"),
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),

                              if (widget.cloud)...[
                                SizedBox(
                                  width: 200,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Future<void> createFile(
                                          Map content, String fileName) async {

                                        //   print("Creating file!");
                                        //   File file = File("${dir.path}/$fileName");
                                        //   file.createSync();
                                        //   //fileExists = true;
                                        //   file.writeAsStringSync(jsonEncode(content));
                                        // }
                                        //
                                        //
                                      }

                                      // for (Stair st in currentProject.stairs) {
                                      //   createFile(st.toJson(), st.id);
                                      // }


                                      //String fecha = DateFormat("yyyy-MM-dd").format(DateTime.now());
                                      FBDB.update(collection: 'projects', document: currentProject.id, data: {'data': currentProject.toJson()});

                                      FBDB.create('log', DateTime.now().toString(), {"user": 1, 'action': 'update', 'project': currentProject.id});
                                    },
                                    icon: const Icon(Icons.update),
                                    label: const Text("Update"),
                                  ),
                                )
                              ],


                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}

/////////////////////////////////////////

//
// // Single project, list all stair in project
// class ProjectPage extends StatelessWidget {
//   const ProjectPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final currentProject = context.watch<Projects>().projects[];
//     final stairsList = currentProject.stairsList;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(child: Text('Project : ${currentProject.name}')),
//       ),
//       body: Center(
//         child: Container(
//           decoration: const BoxDecoration(
//               backgroundBlendMode: BlendMode.colorBurn, color: Colors.white12),
//           child: Column(
//             //crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Divider(
//                   thickness: 3.0,
//                 ),
//                 Expanded(
//                   child: Row(
//                     children: [
//                       Expanded(
//                         flex: 2,
//                         child: Container(
//                           margin: const EdgeInsets.all(15),
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.grey[200],
//                             border: Border.all(width: 2.0, color: Colors.black),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Column(
//                             children: [
//                               const Center(
//                                 child: Text("Project > Stairs"),
//                               ),
//                               Expanded(
//                                 child: ListView.builder(
//                                   padding: const EdgeInsets.all(10.0),
//                                   itemCount: stairsList.length,
//                                   itemBuilder: ((context, index) {
//                                     return Card(
//                                       //color: Colors.brown.shade100,
//
//                                       child: ListTile(
//                                         leading: Container(
//                                           width: 200,
//                                           child: TextField(
//                                             autofocus: true,
//                                             decoration: const InputDecoration(
//                                               labelText: "Stair Id",
//                                               isDense: true,
//                                               contentPadding: EdgeInsets.all(8),
//                                               border: OutlineInputBorder(
//                                                 borderSide: BorderSide(
//                                                     width: 1.0,
//                                                     color: Colors.blueGrey),
//                                               ),
//                                             ),
//                                             controller: TextEditingController(
//                                                 text: currentProject
//                                                     .stairsList[index]
//                                                     .identifier),
//                                             onChanged: (value) {
//                                               currentProject.stairsList[index]
//                                                   .setIdentifier = value;
//                                             },
//                                           ),
//                                         ),
//                                         trailing: Row(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             TextButton.icon(
//                                               onPressed: () {
//                                                 var escalera = currentProject
//                                                     .stairsList[index];
//
//                                                 currentProject.addStair(
//                                                   Escalera.copy(escalera),
//                                                 );
//                                               },
//                                               icon: const Icon(Icons.copy),
//                                               label: const Text('Copy'),
//                                             ),
//                                             TextButton.icon(
//                                               // style: ButtonStyle(
//                                               //   backgroundColor:
//                                               //   MaterialStateProperty.all(
//                                               //       Colors.amber),
//                                               //   foregroundColor:
//                                               //   MaterialStateProperty.all(
//                                               //       Colors.white),
//                                               // ),
//                                                 onPressed: () {
//                                                   Navigator.push(
//                                                     context,
//                                                     MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           StairPage(
//                                                             index: index,
//                                                           ),
//                                                     ),
//                                                   );
//                                                 },
//                                                 icon: const Icon(Icons.edit),
//                                                 label: const Text('Edit')),
//                                             const SizedBox(width: 10,),
//                                             TextButton.icon(
//                                               style: ButtonStyle(
//                                                 backgroundColor:
//                                                 MaterialStateProperty.all(
//                                                     Colors.red),
//                                                 foregroundColor:
//                                                 MaterialStateProperty.all(
//                                                     Colors.white),
//                                               ),
//                                               onPressed: () {
//                                                 currentProject.removeStair(
//                                                     currentProject
//                                                         .stairsList[index]);
//                                               },
//                                               icon: const Icon(Icons.delete),
//                                               label: const Text('Delete'),
//                                             ),
//                                             // TextButton.icon(
//                                             //     onPressed: () {},
//                                             //     icon: const Icon(Icons.save),
//                                             //     label: const Text('Save')),
//                                           ],
//                                         ),
//                                       ),
//
//                                       // child: ListTile(
//                                       //   leading:
//                                       //   title: Container(
//                                       //     //width: 30,
//                                       //     padding:
//                                       //     const EdgeInsets.only(bottom: 10.0),
//                                       //     child: ,
//                                       //   trailing: ,
//                                       // ),
//                                     );
//                                   }),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 1,
//                         child: Card(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               SizedBox(
//                                 width: 200,
//                                 child: ElevatedButton.icon(
//                                   onPressed: () {
//                                     //setState(() {
//                                     currentProject
//                                         .addStair(Escalera(identifier: ''));
//                                     //});
//                                   },
//                                   icon: const Icon(Icons.stairs_outlined),
//                                   label: const Text("Add Stair"),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 20.0,
//                               ),
//                               SizedBox(
//                                 width: 200,
//                                 child: ElevatedButton.icon(
//                                     onPressed: () {
//                                       // final tempProjects =
//                                       // Provider.of<TemporaryProjectsProvider>(context,
//                                       //     listen: false);
//                                       // final curentProject = Provider.of<ProjectProvider>(
//                                       //     context,
//                                       //     listen: false);
//                                       // Proyecto newProject =
//                                       // Proyecto(name: curentProject.name);
//                                       // newProject.stairsList = [
//                                       //   ...currentProject.stairsList
//                                       // ];
//                                       // tempProjects.addProject(newProject);
//                                       // Navigator.pop(context);
//                                       //   ProjectProvider proj = Provider.of<ProjectProvider>(
//                                       //       context,
//                                       //       listen: false);
//                                       //
//                                       //
//                                       //   var jsonData = proj.toJson();
//                                       //   DB.create('projects', proj.name, {'data': jsonData});
//                                     },
//                                     icon: const Icon(Icons.save),
//                                     label: const Text('Save *')),
//                               ),
//                               const SizedBox(
//                                 height: 20.0,
//                               ),
//                               SizedBox(
//                                 width: 200,
//                                 child: ElevatedButton.icon(
//                                     onPressed: () {
//                                       // final tempProjects =
//                                       // Provider.of<TemporaryProjectsProvider>(context,
//                                       //     listen: false);
//                                       // final curentProject = Provider.of<ProjectProvider>(
//                                       //     context,
//                                       //     listen: false);
//                                       // Proyecto newProject =
//                                       // Proyecto(name: curentProject.name);
//                                       // newProject.stairsList = [
//                                       //   ...currentProject.stairsList
//                                       // ];
//                                       // tempProjects.addProject(newProject);
//                                       // Navigator.pop(context);
//                                       // ProjectProvider proj =
//                                       // Provider.of<ProjectProvider>(context,
//                                       //     listen: false);
//                                       //
//                                       // for (var element in tempProjects) {
//                                       //   DB.create('projects', element.name,
//                                       //       {'data': element.toJson()});
//                                       // }
//
//                                       // var jsonData = proj.toJson();
//                                       // DB.create('projects', proj.name, {'data': jsonData});
//                                     },
//                                     icon: const Icon(Icons.send),
//                                     label: const Text('Export  *')),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ]),
//         ),
//       ),
//     );
//   }
// }
