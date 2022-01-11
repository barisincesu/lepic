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
  var selectedCurrency, selectedType;
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
                List<DropdownMenuItem> currencyItems = [];
                for (int i = 0; i < snapshot.data.docs.length; i++) {
                  DocumentSnapshot snap = snapshot.data.docs[i];
                  currencyItems.add(
                    DropdownMenuItem(
                      child: Text(
                        snap.get('name'),
                        style: TextStyle(color: Color(0xff11b719)),
                      ),
                      value: "${snap.get('name')}",
                    ),
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(width: 50.0),
                    DropdownButton(
                      items: currencyItems,
                      onChanged: (currencyValue) {
                        final snackBar = SnackBar(
                          content: Text(
                            'Selected Currency value is $currencyValue',
                            style: TextStyle(color: Color(0xff11b719)),
                          ),
                        );
                        Scaffold.of(context).showSnackBar(snackBar);
                        setState(() {
                          selectedCurrency = currencyValue;
                        });
                      },
                      value: selectedCurrency,
                      isExpanded: false,
                      hint: new Text(
                        "Choose a Class",
                        style: TextStyle(color: Color(0xff11b719)),
                      ),
                    ),
                  ],
                );
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(
                    40), // fromHeight use double.infinity as width and 40 is the height
              ),
              child: Text(
                "Add texts in $selectedCurrency",
                style: const TextStyle(color: Colors.white),
              ),
              onPressed: () {
                //debugPrint("Butona tıklandı");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddTextToClassTeacher(),
                      settings: RouteSettings(
                        arguments: selectedCurrency,
                      ),
                    ));
              },
            ),
            const Padding(padding: EdgeInsets.only(top: 10.0)),
            Text("Texts In $selectedCurrency"),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Sentence')
                  .where('group', isEqualTo: selectedCurrency)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<String> textsInClass = [];
                for (int i = 0; i < snapshot.data.docs.length; i++) {
                  DocumentSnapshot snap = snapshot.data.docs[i];
                  textsInClass.add(snap.get('title'));
                }

                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: textsInClass.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading:
                            const Icon(Icons.text_snippet, color: Colors.cyan),
                        title: Text(textsInClass[index]),
                        trailing: const Icon(
                          Icons.edit,
                          color: Colors.green,
                        ),
                      );
                    });
              },
            ),
            Text("Students In $selectedCurrency"),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Person')
                  .where('group', isEqualTo: selectedCurrency)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<String> studentsInClass = [];
                for (int i = 0; i < snapshot.data.docs.length; i++) {
                  DocumentSnapshot snap = snapshot.data.docs[i];
                  studentsInClass.add(snap.get('userName'));
                }

                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: studentsInClass.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.people_rounded,
                            color: Colors.teal),
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
                    });
              },
            ),
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
