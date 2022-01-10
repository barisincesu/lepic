// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';

class AddTextToClassTeacher extends StatelessWidget {
  const AddTextToClassTeacher({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _currentClass = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Add Text to $_currentClass"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.multiline,
                // ignore: prefer_const_constructors
                decoration: new InputDecoration.collapsed(
                    hintText:
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
                maxLines: 15,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(
                    40), // fromHeight use double.infinity as width and 40 is the height
              ),
              child: Text(
                "Add this text to $_currentClass",
                style: const TextStyle(color: Colors.white),
              ),
              onPressed: () {
                debugPrint("Butona tıklandı");
              },
            ),
          ],
        ),
      ),
    );
  }
}
