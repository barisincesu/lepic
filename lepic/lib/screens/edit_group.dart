import 'package:lepic/models/group.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/group_provider.dart';

class EditGroup extends StatefulWidget {
  final Group group;

  EditGroup([this.group]);

  @override
  _EditGroupState createState() => _EditGroupState();
}

class _EditGroupState extends State<EditGroup> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.group == null) {
      //New Record
      nameController.text = "";
      priceController.text = "";
      new Future.delayed(Duration.zero, () {
        final groupProvider =
            Provider.of<ProductProvider>(context, listen: false);
        groupProvider.loadValues(Group());
      });
    } else {
      //Controller Update
      nameController.text = widget.group.name;
      priceController.text = widget.group.price.toString();
      //State Update
      new Future.delayed(Duration.zero, () {
        final groupProvider =
            Provider.of<GroupProvider>(context, listen: false);
        groupProvider.loadValues(widget.group);
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final groupProvider = Provider.of<GroupProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Edit Product')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'Product Name'),
              onChanged: (value) {
                groupProvider.changeName(value);
              },
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(hintText: 'Product Price'),
              onChanged: (value) => groupProvider.changePrice(value),
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              child: Text('Save'),
              onPressed: () {
                groupProvider.saveGroup();
                Navigator.of(context).pop();
              },
            ),
            (widget.group != null)
                ? RaisedButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Text('Delete'),
                    onPressed: () {
                      groupProvider.removeGroup(widget.group.productId);
                      Navigator.of(context).pop();
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
