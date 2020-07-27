import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_book/notes/Notes.dart';
import 'package:flutter_book/tasks/Tasks.dart';
import 'package:path_provider/path_provider.dart';
import 'appointments/Appointments.dart';
import 'utils.dart' as utils;

void main() {
  startMeUp() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    utils.docsDir = documentsDirectory;
    runApp(FlutterBook());
  }

  startMeUp();
}

class FlutterBook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text("FlutterBook"),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.date_range),
                  text: "Appointments",
                ),
                Tab(
                  icon: Icon(Icons.contacts),
                  text: "Contacts",
                ),
                Tab(
                  icon: Icon(Icons.note),
                  text: "Notes",
                ),
                Tab(
                  icon: Icon(Icons.assignment_turned_in),
                  text: "Tasks",
                )
              ],
            ),
          ),
          body: TabBarView(
              children: [Appointments(),Notes(), Tasks()]),
        ),
      ),
    );
  }
}
