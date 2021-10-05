import 'package:distingueur/screens/addresses.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Distingueur',
      theme: ThemeData(),
      home: AddressesScreen(),
    );
  }
}