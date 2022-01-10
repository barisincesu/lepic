import 'package:flutter/material.dart';
import 'package:lepic/screens/Teacher/StudentTextDetail.dart';

// ignore: must_be_immutable
class ReportIndivucialTeacher extends StatelessWidget {
  const ReportIndivucialTeacher({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context).settings.arguments;

    final complatedText = ["Text 1", "Text 2", "Text 3", "Text 4"];
    final complatedTextZCNO = ["0.65", "0.85", "0.75", "0.65"];
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
            ListView.builder(
                shrinkWrap: true,
                itemCount: complatedText.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(complatedText[index]),
                    subtitle: Text(complatedTextZCNO[index]),
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
                              arguments: complatedText[index],
                            ),
                          ))
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
