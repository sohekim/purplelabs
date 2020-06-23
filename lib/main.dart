import 'package:demo/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // pass in the keyword of the picture and the number of pictures we want to show
      // i thought this would give more flexibility in showing data
      home: MyHomePage('chair', 10),
      debugShowCheckedModeBanner: false,
    );
  }
}
