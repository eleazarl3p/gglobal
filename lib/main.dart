import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pp/screens/all_projects.dart';
import 'package:pp/screens/all_stair_from_actual_project.dart';
import 'package:provider/provider.dart';
import '/screens/Home.dart';

import 'models/Projects.dart';
import 'models/flight_map.dart';
import 'models/project.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBUPr58KjlZm04hz0SM7uroLllTCYAIKvk",
        //authDomain: "toma-data.firebaseapp.com",
        projectId: "toma-data",
        storageBucket: "toma-data.appspot.com",
        messagingSenderId: "938862760432",
        appId: "1:938862760432:web:7f877cb7dff3970a090d35"
  ));
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => Projects()),
      ChangeNotifierProvider(create: (context) => Project()),
      ChangeNotifierProvider(create: (context)=> FlightMap())
    ],
    child:  MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(


        primarySwatch: Colors.blueGrey,
      ),
      // initialRoute: '/',
      // routes: {
      //   '/' : (context) => const Home(),
      //   '/projects' : (context) => const ProjectsPage(),
      //   '/project' : (context) => StairOnCurrentProject()
      // },
      home: const Home(),
    );
  }
}

