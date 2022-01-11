import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lepic/screens/Teacher/AddTextToClass.dart';
import 'package:lepic/screens/Teacher/AllReport.dart';
import 'package:lepic/screens/Teacher/ReportIndivucial.dart';

void main() {
  runApp(const HomePageTeacher());
}

class HomePageTeacher extends StatelessWidget {
  const HomePageTeacher({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teacher Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TeacherHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TeacherHomePage extends StatefulWidget {
  const TeacherHomePage({Key key}) : super(key: key);
  @override
  _TeacherHomePage createState() => _TeacherHomePage();
}

String currentName = "";

class _TeacherHomePage extends State<TeacherHomePage> {
  final String _name = "Vefa Lisesi"; // Veritabanından çek !
  String _currentClass = '10/A'; // Comboda aktif olanı seç

  final classes = ["10/A", "11/B", "12/C", "12/A"];

  final List<String> studentsInClass = <String>[
    "Bariş İncesu",
    "Muhammed Furkan Demir"
  ];
  final List<String> textsInClass = <String>[
    "Text 1",
    "Text 2",
  ];
  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Teacher Page $todo"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20.0),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('products')
                  .where('teacherName', isEqualTo: todo)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView(
                  shrinkWrap: true,
                  children: snapshot.data.docs.map((document) {
                    return Container(
                      child: Center(child: Text(document['name'])),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Information"),
    content: (currentName != "")
        ? Text("$currentName is selected.")
        : const Text("Select a student first."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
