import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pp/models/Projects.dart';
import 'package:pp/screens/cloud_display.dart';

import '/mail/email.dart';
import '/screens/all_projects.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Utils/flight_data_colector_on_dev.dart';
import 'flight_editor.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tempProjects = Projects();
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Home')),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CloudProjects(tempProjects: tempProjects)));
                    // String? encodeQueryParameters(Map<String, String> params) {
                    //   return params.entries
                    //       .map((MapEntry<String, String> e) =>
                    //   '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                    //       .join('&');
                    // }
                    //
                    // final Uri emailLaunchUri = Uri(
                    //   scheme: 'egenestel3p@gmail.com',
                    //   path: 'egenestel3p@gmail.com',
                    //   query: encodeQueryParameters(<String, String>{
                    //     'subject': 'Example Subject & Symbols are allowed!',
                    //   }),
                    // );
                    //
                    // launchUrl(emailLaunchUri);
                    // final Uri _url = Uri.parse('https://flutter.dev');
                    // Future<void> _launchUrl() async {
                    //   if (!await launchUrl(_url)) {
                    //     throw 'Could not launch $_url';
                    //   }
                    // }
                    // _launchUrl();
                    // String tto = "egenestel3p@gmail.com";
                    // String ssub = 'Test';
                    // //Uri url = 'mailto:$tto?subject=${Uri.encodeFull(ssub)}&body=${Uri.encodeFull(ssub)}';
                    //
                    // Uri ulr_ = Uri(scheme: tto,
                    //
                    //     path: 'egenestel3p@gmail.com',
                    //     queryParameters: {'subject': 'Example'});
                    // print('sent');
                    // if (await canLaunchUrl(ulr_)) {
                    //   await launchUrl(ulr_);
                    // }
                  },
                  child: const Text('Cloud')),
            ),
            const SizedBox(
              width: 200,
            ),
            SizedBox(
              height: 100,
              width: 100,
              child: ElevatedButton(
                  onPressed: () {
                    print(tempProjects.projects);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProjectsPage(tempProjects: tempProjects)));
                  },
                  child: const Text('Project')),
            ),
          ],
        ),
      ),
    );
  }
}
