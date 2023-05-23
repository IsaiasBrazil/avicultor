import 'package:flutter/material.dart';
import 'package:tcc/widget_drawer.dart';

import 'widget_listtile.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          centerTitle: true,         
          title: const Text(
            'Informações dos sensores',
            style: TextStyle(
                fontFamily: 'BebasNeue', fontSize: 32),
          ),
        ),
        drawer: MenuLateral(titulo: 'AVICONTROL'),
        );
  }
}
