import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
        color: Colors.white,
        child: SizedBox.expand(
          child: Center(child: Text("HomeScreen")),
        ));
  }
}
