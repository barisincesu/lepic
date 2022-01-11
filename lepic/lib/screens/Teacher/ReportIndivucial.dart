import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lepic/screens/Teacher/StudentTextDetail.dart';

// ignore: must_be_immutable
class ReportIndivucialTeacher extends StatelessWidget {
  const ReportIndivucialTeacher({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context).settings.arguments;
    var clicked = 0;
    //final complatedText = ["Text 1", "Text 2", "Text 3", "Text 4"];
    //final complatedTextZCNO = ["0.65", "0.85", "0.75", "0.65"];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Completed Texts"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(padding: EdgeInsets.only(top: 10.0)),
            Text('$todo Completed Texts'),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Grade')
                  .where('studentName', isEqualTo: todo)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<String> complatedText = [];
                List<double> complatedTextZCNO = [];
                for (int i = 0; i < snapshot.data.docs.length; i++) {
                  DocumentSnapshot snap = snapshot.data.docs[i];
                  complatedText.add(snap.get('sentenceTitle'));
                  complatedTextZCNO.add(snap.get('grade')[4]);
                }
                List<String> gonderielcek = [];
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: complatedText.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(complatedText[index]),
                        subtitle: Text(complatedTextZCNO[index].toString()),
                        trailing: const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.blueAccent,
                        ),
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StudentTextDetail(),
                                settings: RouteSettings(
                                    //ExtractArgumentsScreen.routeName,
                                    arguments: (todo.toString() +
                                            "*" +
                                            complatedText[index])
                                        .toString()),
                              ))
                        },
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
