import 'package:flutter/material.dart';
import 'package:lepic/screens/SupportTeam/ManageGroup.dart';
import 'package:lepic/screens/SupportTeam/ManagePerson.dart';
import 'package:lepic/screens/SupportTeam/ManageSentence.dart';

class Support extends StatelessWidget {
  const Support({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Support Page"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(
                    40), // fromHeight use double.infinity as width and 40 is the height
              ),
              child: const Text(
                "Manage Users",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ManagePerson(),
                      settings: RouteSettings(
                        arguments: "currentName",
                      ),
                    ));
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(
                    40), // fromHeight use double.infinity as width and 40 is the height
              ),
              child: const Text(
                "Manage Classes",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ManageGroup(),
                      settings: RouteSettings(
                        arguments: "currentName",
                      ),
                    ));
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(
                    40), // fromHeight use double.infinity as width and 40 is the height
              ),
              child: const Text(
                "Manage Texts",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ManageSentence(),
                      settings: RouteSettings(
                        arguments: "currentName",
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
