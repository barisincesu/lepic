import 'package:flutter/material.dart';
import 'package:lepic/screens/authenticate/authenticate.dart';
import 'package:lepic/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return either Home or Authenticate widget
    return Authenticate();
  }
}
