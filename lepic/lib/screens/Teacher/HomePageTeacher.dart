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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Teacher Page"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(padding: EdgeInsets.only(top: 10.0)),
            Text(
              'School Name : $_name',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButton(
              value: _currentClass,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: classes.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String newValue) {
                setState(() {
                  _currentClass = newValue;
                });
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(
                    40), // fromHeight use double.infinity as width and 40 is the height
              ),
              child: Text(
                "Add texts in $_currentClass",
                style: const TextStyle(color: Colors.white),
              ),
              onPressed: () {
                //debugPrint("Butona tıklandı");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddTextToClassTeacher(),
                      settings: RouteSettings(
                        arguments: _currentClass,
                      ),
                    ));
              },
            ),
            const Padding(padding: EdgeInsets.only(top: 10.0)),
            Text("Texts In $_currentClass"),
            ListView.builder(
                shrinkWrap: true,
                itemCount: textsInClass.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.text_snippet, color: Colors.cyan),
                    title: Text(textsInClass[index]),
                    trailing: const Icon(
                      Icons.edit,
                      color: Colors.green,
                    ),
                  );
                }),
            Text("Students In $_currentClass"),
            ListView.builder(
                shrinkWrap: true,
                itemCount: studentsInClass.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading:
                        const Icon(Icons.people_rounded, color: Colors.teal),
                    title: Text(studentsInClass[index]),
                    trailing: const Icon(
                      Icons.select_all_sharp,
                      color: Colors.black,
                    ),
                    onTap: () => {
                      currentName = studentsInClass[index],
                      showAlertDialog(context)
                    },
                  );
                }),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(
                    40), // fromHeight use double.infinity as width and 40 is the height
              ),
              child: const Text(
                "See the selected student report",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (currentName == "") {
                  showAlertDialog(context);
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReportIndivucialTeacher(),
                        settings: RouteSettings(
                          arguments: currentName,
                        ),
                      ));
                }
              },
            ),
            const Padding(padding: EdgeInsets.only(top: 10.0)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(
                    40), // fromHeight use double.infinity as width and 40 is the height
              ),
              child: const Text(
                "See all students reports",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AllReportTeacher()));
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
