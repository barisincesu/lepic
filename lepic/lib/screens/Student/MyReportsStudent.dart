import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
    content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        //position
        mainAxisSize: MainAxisSize.min,
        // wrap content in flutter
        children: <Widget>[
          Text(
              "Now, Student only see the zcno score. In the future, student acceess all detailed datas."),
          /*
          Text("N.Words Read Per Minute     : " + scoreText[1].toString()),
          Text("N.Words Read First Minute   : " + scoreText[2].toString()),
          Text("T.N Words Incorrectly Read  : " + scoreText[3].toString()),
          Text("Z Score                                     : " +
              scoreText[4].toString()),*/
        ]),
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

class MyReportsStudent extends StatelessWidget {
  const MyReportsStudent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todo =
        ModalRoute.of(context).settings.arguments; // email var studentName
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("My Reports " + todo),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                List<String> textsInGrades = [];
                List<String> zcnoInGrades = [];
                for (int i = 0; i < snapshot.data.docs.length; i++) {
                  DocumentSnapshot snap = snapshot.data.docs[i];
                  textsInGrades.add(snap.get('sentenceTitle'));
                  zcnoInGrades.add(snap.get('grade')[4].toString());
                }

                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: textsInGrades.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.school_rounded),
                        title: Text(textsInGrades[index]),
                        subtitle: Text(zcnoInGrades[index]),
                        onTap: () => {showAlertDialog(context)},
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
