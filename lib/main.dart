import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
        theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'BebasNeue'),
        debugShowCheckedModeBanner: false,
        home: const Home()),
  );
}
