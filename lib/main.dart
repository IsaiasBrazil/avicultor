import 'package:flutter/material.dart';
import 'package:tcc/cadastrar_lote.dart';
import 'home.dart';

void main() {
  runApp(
    MaterialApp(
        theme: ThemeData(primarySwatch: Colors.green), 
        home: const TelaCadastroLote()),
  );
}
