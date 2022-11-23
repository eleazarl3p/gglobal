import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pp/models/Projects.dart';
import 'package:pp/screens/all_stair_from_actual_project.dart';
import 'package:provider/provider.dart';

import '../models/project.dart';
import '../models/stair.dart';

class CloudProjects extends StatelessWidget {
  CloudProjects({Key? key, required this.tempProjects}) : super(key: key);

  Projects tempProjects;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Locally Saved Projects'),
      ),
      body: Center(
        child: Container(
          child: ProjectsInformation(tempProjects: tempProjects),
        ),
      ),
    );
  }
}

class ProjectsInformation extends StatelessWidget {
  ProjectsInformation({super.key, required this.tempProjects});

  final Projects tempProjects;
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('projects').snapshots();

  @override
  Widget build(BuildContext context) {
    // print(DB.readCollection('projects'));

    final pjsProvider = context.watch<Projects>();

    // save temporal projects
    tempProjects.resetProject();
    for (Project pj in pjsProvider.projects) {
      tempProjects.massiveUpdate(pj);
    }

    pjsProvider.resetProject();

    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        // return ListView(
        //   children: snapshot.data!.docs.map((DocumentSnapshot document) {
        //     Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        //     print(document.id);
        //     print(data);
        //     return ListTile(
        //       leading: Text(document.id),
        //     );
        //   }).toList(),
        // );

        List projects = snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

          return Project.fromJson(data['data']);
        }).toList();

        // snapshot.data!.docs.map((DocumentSnapshot document) {
        //   Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        //
        //   var newProject = Project.fromJson(data['data']);
        //   pjsProvider.massiveUpdate(newProject);
        //
        //
        //
        // });

        for (Project pj in projects) {
          pjsProvider.massiveUpdate(pj);
        }

        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
                backgroundBlendMode: BlendMode.colorBurn,
                color: Colors.white12),
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
                          child: Container(
                            margin: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 2.0, color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                      itemCount: pjsProvider.projects.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          //color: Colors.brown.shade100,
                                          child: ListTile(
                                            // leading: Checkbox(
                                            //   //activeColor: Colors.blueGrey,
                                            //   fillColor: MaterialStateProperty.all(
                                            //       Colors.blueGrey),
                                            //   checkColor: Colors.white,
                                            //   value: true,
                                            //   onChanged: (value) {
                                            //
                                            //   },
                                            // ),
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
                                                          pIndex: index,
                                                          cloud: true,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  icon: const Icon(
                                                      Icons.open_in_new),
                                                  label: const Text('Open'),
                                                ),
                                                TextButton.icon(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.red),
                                                    foregroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.white),
                                                  ),
                                                  onPressed: () {},
                                                  icon:
                                                      const Icon(Icons.delete),
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
                      ],
                    ),
                  ),
                ]),
          ),
        );
      },
    );
  }
}
