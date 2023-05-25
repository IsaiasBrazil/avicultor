import 'package:flutter/material.dart';
import 'package:tcc/cadastrar_estoque_racao.dart';
import 'package:tcc/cadastrar_galpao.dart';
import 'package:tcc/cadastrar_info_lote.dart';
import 'package:tcc/cadastrar_lote.dart';
import 'cadastrar_sensor.dart';
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
            icone: Icons.warehouse,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TelaCadastroGalpao()));
            },
          ),
          ListTileCustom(
            nome: 'Cadastro de Lotes',
            icone: Icons.warehouse_outlined,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TelaCadastroLote()));
            },
          ),
          ListTileCustom(
            nome: 'Controle de Lotes',
            icone: Icons.warehouse_sharp,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TelaCadastroInfoLote()));
            },
          ),
          ListTileCustom(
            nome: 'Estoque de Ração',
            icone: Icons.food_bank,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TelaCadastroEstoqueRacao()));
            },
          ),
          ListTileCustom(
            nome: 'Cadastro de Sensores',
            icone: Icons.sensors,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TelaCadastroSensor()));
            },
          ),
        ],
      ),
    ));
  }
}
