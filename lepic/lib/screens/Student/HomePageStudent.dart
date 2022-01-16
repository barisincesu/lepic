import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lepic/screens/Student/CompleteText.dart';
import 'package:lepic/screens/Student/MyReportsStudent.dart';

String studentName = "Barış İncesu"; //  Bu iki veriyi loginden al
String studentClass = "10/A";

final List<String> incompleteTitle = <String>["Text 1", "Text 2"];
final List<String> incompleteTexts = <String>[
  "These are short, famous texts in English from classic sources like the Bible or Shakespeare. Some texts have word definitions and explanations to help you.",
  "Some of these texts are written in an old style of English. Try to understand them, because the English that we speak today is based on what our great, great, great, great grandparents spoke before!",
];

class HomePageStudent extends StatelessWidget {
  const HomePageStudent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context).settings.arguments; // ismi aldık.
    String class_name = "5A";
    if (todo == "cihan@test.com") {
      class_name = "6A";
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Student Page"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Person')
                  .where('userName', isEqualTo: todo)
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

                  class_name = snap.get('group');
                  break;
                }

                return Text("Your Class : " + class_name);
              },
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Sentence')
                  .where('group', isEqualTo: class_name)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<String> textsInClass = [];
                List<String> titleInClass = [];
                for (int i = 0; i < snapshot.data.docs.length; i++) {
                  DocumentSnapshot snap = snapshot.data.docs[i];
                  textsInClass.add(snap.get('content'));
                  titleInClass.add(snap.get('title'));
                }

                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: titleInClass.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(titleInClass[index]),
                        subtitle:
                            Text(textsInClass[index].substring(0, 20) + "..."),
                        trailing: const Icon(Icons.not_started),
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CompleteText(),
                                settings: RouteSettings(
                                  arguments: textsInClass[index],
                                ),
                              ))
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
                "See my all completed texts' reports",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyReportsStudent(),
                      settings: RouteSettings(
                        arguments: todo,
                      ),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
