import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Informações Gerais',
          style: TextStyle(fontFamily: 'BebasNeue', fontSize: 34),
        ),
      ),
    );
  }
}
