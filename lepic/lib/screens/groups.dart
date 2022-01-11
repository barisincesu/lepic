import 'package:lepic/screens/edit_group.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/group.dart';

class Groups extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final groups = Provider.of<List<Group>>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Groups'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                size: 30.0,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => EditGroup()));
              },
            )
          ],
        ),
        body: (groups != null)
            ? ListView.builder(
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(groups[index].name),
                    trailing: Text(groups[index].price.toString()),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditGroup(groups[index])));
                    },
                  );
                })
            : Center(child: CircularProgressIndicator()));
  }
}
