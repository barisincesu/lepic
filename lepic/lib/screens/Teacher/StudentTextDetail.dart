import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class StudentTextDetail extends StatelessWidget {
  const StudentTextDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context).settings.arguments;
    final titles = [
      "Total Reading Time",
      "Number of Words Read Per Minute",
      "Number of Words Read First Minute",
      "Total Number Words Incorrectly Read",
      "Z Score"
    ];
    //final scoreText = ["02:59", "240", "250", "242", "8", "0.9"];

    final info = todo.toString().split("*");
    String _sn = info[0];
    String _tn = info[1];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Detail of $_tn"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Grade')
                  .where('studentName', isEqualTo: _sn)
                  .where('sentenceTitle', isEqualTo: _tn)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<String> grades = [];
                for (int i = 0; i < snapshot.data.docs.length; i++) {
                  DocumentSnapshot snap = snapshot.data.docs[i];
<<<<<<< Updated upstream
                  for (var j = 0; j <= 4; j++) {
=======
                  for (var j = 0; j < 4; j++) {
>>>>>>> Stashed changes
                    grades.add(snap.get('grade')[j].toString());
                  }
                }
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: titles.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(
                          Icons.check_circle_outline_sharp,
                          color: Colors.green,
                        ),
                        title: Text(titles[index]),
                        subtitle: Text(grades[index]),
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
