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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Student Page"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return ListTile(
                    tileColor: Colors.grey,
                    textColor: Colors.white,
                    title: Text(studentName),
                    subtitle: Text(studentClass),
                  );
                }),
            const Padding(padding: EdgeInsets.only(top: 10.0)),
            const Text("Incompleted Texts"),
            ListView.builder(
                shrinkWrap: true,
                itemCount: incompleteTitle.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(incompleteTitle[index]),
                    subtitle:
                        Text(incompleteTexts[index].substring(0, 20) + "..."),
                    trailing: const Icon(Icons.not_started),
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CompleteText(),
                            settings: RouteSettings(
                              arguments: incompleteTexts[index],
                            ),
                          ))
                    },
                  );
                }),
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
                        arguments: studentName,
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
