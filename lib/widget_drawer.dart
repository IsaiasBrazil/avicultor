import 'package:flutter/material.dart';
import 'package:tcc/cadastrar_lote.dart';
import 'home.dart';
import 'widget_listtile.dart';

class MenuLateral extends StatelessWidget {
  final titulo;
  const MenuLateral({
    super.key,
    required this.titulo,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: Colors.green,
      child: ListView(
        children: [
          DrawerHeader(
              child: Center(
                  child: Text(
            titulo,
            style: TextStyle(
                fontFamily: 'BebasNeue', fontSize: 28, color: Colors.white),
          ))),
          ListTileCustom(
            nome: 'Página inicial',
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
          ),
          ListTileCustom(
            nome: 'Cadastro de galpões',
          ),
          ListTileCustom(
            nome: 'Cadastro de Lotes',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TelaCadastroLote()));
            },
          ),
          ListTileCustom(nome: 'Controle de Lotes'),
          ListTileCustom(nome: 'Estoque de Ração'),
          ListTileCustom(nome: 'Cadastro de Sensores')
        ],
      ),
    ));
  }
}
