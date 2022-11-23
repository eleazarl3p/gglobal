import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../DB/projectCollection.dart';
import '../models/Projects.dart';
import '../models/project.dart';
import '../models/stair.dart';
import 'all_stair_from_actual_project.dart';

//import '../Utils/dbConn.dart';

class ProjectsPage extends StatefulWidget {
  ProjectsPage({Key? key, required this.tempProjects}) : super(key: key);

  Projects tempProjects;
  bool load = true;

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  TextEditingController projectNameController = TextEditingController();

  FocusNode miFocus = FocusNode();

  bool _error = false;

  @override
  void dispose() {
    projectNameController.dispose();
    miFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pjsProvider = context.watch<Projects>();
    if (widget.load) {
      widget.load = false;
      pjsProvider.resetProject();
      for (Project pj in widget.tempProjects.projects) {
        pjsProvider.massiveUpdate(pj);
      }
    }
    //final pjProvider = Provider.of<Project>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Locally Saved Projects'),
      ),
      body: Center(
        child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: const EdgeInsets.all(15),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(width: 2.0, color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            const Center(
                              child: Text("Projects"),
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: pjsProvider.projects
                                      .length, //context.select((Projects pj) => pj.projects.length),
                                  itemBuilder: (context, index) {
                                    return Card(
                                      //color: Colors.brown.shade100,
                                      child: ListTile(
                                        leading: Checkbox(
                                          //activeColor: Colors.blueGrey,
                                          fillColor: MaterialStateProperty.all(
                                              Colors.blueGrey),
                                          checkColor: Colors.white,
                                          value: true,
                                          onChanged: (value) {
                                            setState(() {
                                              //tempProjects[index].toggle();
                                            });
                                          },
                                        ),
                                        title: Text(
                                          pjsProvider.projects[index].id,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0,
                                              color: Colors.blueGrey),
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextButton.icon(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        StairOnCurrentProject(
                                                            pIndex: index),
                                                  ),
                                                );
                                              },
                                              icon:
                                                  const Icon(Icons.open_in_new),
                                              label: const Text('Open'),
                                            ),
                                            TextButton.icon(
                                              onPressed: () {
                                                // setState(() {
                                                //   Project p = Project.copy(pjsProvider.projects[index]);
                                                //   pjsProvider.addProject(p);
                                                // });

                                                //Navigator.pop(context);
                                              },
                                              icon: const Icon(Icons.copy),
                                              label: const Text('Copy'),
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
                                                  pjsProvider.removeProject(
                                                      pjsProvider
                                                          .projects[index]);
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
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Project's name"),
                                        content: Focus(
                                          child: TextFormField(
                                            controller: projectNameController,
                                            focusNode: miFocus,
                                            autofocus: true,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            autocorrect: true,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                _error = true;
                                                return '';
                                              }
                                              _error = false;
                                              return null;
                                            },
                                          ),
                                          onFocusChange: (value) {
                                            if (!value) {
                                              if (_error) {
                                                miFocus.requestFocus();
                                              }
                                            } else {
                                              projectNameController.selection =
                                                  TextSelection(
                                                      baseOffset: 0,
                                                      extentOffset:
                                                          projectNameController
                                                              .value
                                                              .text
                                                              .length);
                                            }
                                          },
                                        ),
                                        actions: [
                                          TextButton.icon(
                                            onPressed: () {
                                              if (projectNameController
                                                      .text.length >
                                                  1) {
                                                pjsProvider.addProject(Project(
                                                    id: projectNameController
                                                        .text,
                                                    stairs: <Stair>[]));
                                                projectNameController.text = '';

                                                Navigator.pop(context);
                                              }
                                            },
                                            icon: const Icon(Icons.check),
                                            label: const Text("OK"),
                                          ),
                                          TextButton.icon(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(Icons.cancel),
                                            label: const Text("Cancel"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(Icons.new_label),
                                label: const Text("New"),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            // SizedBox(
                            //   width: 200,
                            //   child: ElevatedButton.icon(
                            //     onPressed: () {
                            //       // final tempProjects =
                            //       // Provider.of<TemporaryProjectsProvider>(context,
                            //       //     listen: false);
                            //       // final curentProject = Provider.of<ProjectProvider>(
                            //       //     context,
                            //       //     listen: false);
                            //       // Proyecto newProject =
                            //       // Proyecto(name: curentProject.name);
                            //       // newProject.stairsList = [
                            //       //   ...currentProject.stairsList
                            //       // ];
                            //       // tempProjects.addProject(newProject);
                            //       // Navigator.pop(context);
                            //       //   ProjectProvider proj = Provider.of<ProjectProvider>(
                            //       //       context,
                            //       //       listen: false);
                            //       //
                            //       //
                            //       //   var jsonData = proj.toJson();
                            //       //   DB.create('projects', proj.name, {'data': jsonData});
                            //     },
                            //     icon: const Icon(Icons.save),
                            //     label: const Text('Save'),
                            //   ),
                            // ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            SizedBox(
                              width: 200,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // final tempProjects =
                                  // Provider.of<TemporaryProjectsProvider>(context,
                                  //     listen: false);
                                  // final curentProject = Provider.of<ProjectProvider>(
                                  //     context,
                                  //     listen: false);
                                  // Proyecto newProject =
                                  // Proyecto(name: curentProject.name);
                                  // newProject.stairsList = [
                                  //   ...currentProject.stairsList
                                  // ];
                                  // tempProjects.addProject(newProject);
                                  // Navigator.pop(context);
                                  // ProjectProvider proj =
                                  // Provider.of<ProjectProvider>(context,
                                  //     listen: false);

                                  for (var element in pjsProvider.projects) {
                                    FBDB.create('projects', element.id,
                                        {'data': element.toJson()});
                                    print({'data': element.toJson()});
                                  }

                                  // var jsonData = proj.toJson();
                                  // DB.create('projects', proj.name, {'data': jsonData});
                                },
                                icon: const Icon(Icons.upload),
                                label: const Text('Upload'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
