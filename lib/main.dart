import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, 
    DeviceOrientation.portraitDown]);
  runApp(
    MaterialApp(
        theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'BebasNeue'),
        debugShowCheckedModeBanner: false,
        home: const Home(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
    )
  );
}
