import 'package:flutter/material.dart';

showAlertDialog(BuildContext context) {
  final scoreText = ["02:59", "240", "250", "242", "0.59", "0.9"];
  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Detail of Text"),
    content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        //position
        mainAxisSize: MainAxisSize.min,
        // wrap content in flutter
        children: <Widget>[
          Text("T. Reading Time                      : " +
              scoreText[0].toString()),
          Text("N.Words Read Per Minute     : " + scoreText[1].toString()),
          Text("N.Words Read First Minute   : " + scoreText[2].toString()),
          Text("T.N Words Incorrectly Read  : " + scoreText[3].toString()),
          Text("Z Score                                     : " +
              scoreText[4].toString()),
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
    final todo = ModalRoute.of(context).settings.arguments;
    final List<String> texts = ["Text 1", "Text2"];
    final List<String> zcno = ["0.59", "0.85"];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("My Reports"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: texts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.school_rounded),
                    title: Text(texts[index]),
                    subtitle: Text(zcno[index]),
                    onTap: () => {showAlertDialog(context)},
                  );
                }),
          ],
        ),
      ),
    );
  }
}
