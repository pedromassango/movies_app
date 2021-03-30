import 'package:flutter/material.dart';
import 'package:movies/src/ui/home_page/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      home: HomePage(),
    );
  }
}

