import 'package:flutter/material.dart';
import 'package:flutter_api/ui/main_scaffold.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NimZero ;)',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScaffold(title: 'Home'),
    );
  }
}
