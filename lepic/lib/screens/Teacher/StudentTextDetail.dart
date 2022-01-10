import 'package:flutter/material.dart';

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
    final scoreText = ["02:59", "240", "250", "242", "8", "0.9"];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Detail of $todo"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: titles.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(
                      Icons.check_circle_outline_sharp,
                      color: Colors.green,
                    ),
                    title: Text(titles[index]),
                    subtitle: Text(scoreText[index]),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
