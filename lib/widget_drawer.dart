import 'package:flutter/material.dart';
import 'package:tcc/alterar_galpao.dart';
import 'package:tcc/alterar_lote.dart';
import 'package:tcc/cadastrar_estoque_racao.dart';
import 'package:tcc/cadastrar_galpao.dart';
import 'package:tcc/cadastrar_info_lote.dart';
import 'package:tcc/cadastrar_lote.dart';
import 'package:tcc/consultar_galpao.dart';
import 'package:tcc/consultar_sensor.dart';
import 'package:tcc/excluir_galpao.dart';
import 'package:tcc/excluir_sensor.dart';
import 'cadastrar_sensor2.dart';
import 'consultar_lote.dart';
import 'excluir_lote.dart';
import 'home.dart';
import 'widget_listtile.dart';

class MenuLateral extends StatelessWidget {
  final String titulo;
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
            style: const TextStyle(
                fontFamily: 'BebasNeue', fontSize: 28, color: Colors.white),
          ))),
          ListTileCustom(
            nome: 'Página inicial',
            icone: Icons.home,
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const Home()));
            },
          ),
          // Criação do item menu 'Galpões'
          ExpansionTile(
            title: const Text('Galpões',
                style: TextStyle(
                    fontFamily: 'BebasNeue',
                    fontSize: 26,
                    color: Colors.white)),
            leading: const Icon(Icons.warehouse),

            // Criação dos submenus
            children: [
              ListTileCustom(
                nome: 'Cadastro',
                alinhamentoDoTexto: TextAlign.center,
                icone: null,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TelaCadastroGalpao()));
                },
              ),
              ListTileCustom(
                nome: 'Alteração',
                alinhamentoDoTexto: TextAlign.center,
                icone: null,
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const TelaAlteracaoGalpao()));
                },
              ),
              ListTileCustom(
                nome: 'Exclusão',
                alinhamentoDoTexto: TextAlign.center,
                icone: null,
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const TelaExclusaoGalpao()));
                },
              ),
              ListTileCustom(
                nome: 'Consulta',
                alinhamentoDoTexto: TextAlign.center,
                icone: null,
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const TelaConsultaGalpao()));
                },
              ),
            ],
          ),
          //Criação do item menu 'Lotes'
          ExpansionTile(
            title: const Text('Lotes',
                style: TextStyle(
                    fontFamily: 'BebasNeue',
                    fontSize: 26,
                    color: Colors.white)),
            leading: const Icon(Icons.warehouse_outlined),

            // Criação dos submenus
            children: [
              ListTileCustom(
                nome: 'Cadastro',
                alinhamentoDoTexto: TextAlign.center,
                icone: null,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TelaCadastroLote()));
                },
              ),
              ListTileCustom(
                nome: 'Alteração',
                alinhamentoDoTexto: TextAlign.center,
                icone: null,
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const TelaAlteracaoLote()));
                },
              ),
              ListTileCustom(
                nome: 'Exclusão',
                alinhamentoDoTexto: TextAlign.center,
                icone: null,
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const TelaExclusaoLote()));
                },
              ),
              ListTileCustom(
                nome: 'Consulta',
                alinhamentoDoTexto: TextAlign.center,
                icone: null,
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const TelaConsultaLote()));
                },
              ),
            ],
          ),

          // Criação do item menu 'Sensores'
          ExpansionTile(
            title: const Text('Sensores',
                style: TextStyle(
                    fontFamily: 'BebasNeue',
                    fontSize: 26,
                    color: Colors.white)),
            leading: const Icon(Icons.sensors),

            // Criação dos submenus
            children: [
              ListTileCustom(
                nome: 'Cadastro',
                alinhamentoDoTexto: TextAlign.center,
                icone: null,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TelaCadastroSensor()));
                },
              ),
              ListTileCustom(
                nome: 'Alteração',
                alinhamentoDoTexto: TextAlign.center,
                icone: null,
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const Home()));
                },
              ),
              ListTileCustom(
                nome: 'Exclusão',
                alinhamentoDoTexto: TextAlign.center,
                icone: null,
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const TelaExclusaoSensor()));
                },
              ),
              ListTileCustom(
                nome: 'Consulta',
                alinhamentoDoTexto: TextAlign.center,
                icone: null,
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const TelaConsultaSensor()));
                },
              ),
            ],
          ),

          // Criação do item menu 'Diário de produção'
          ListTileCustom(
            nome: 'Diário de produção',
            icone: Icons.note_add,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TelaCadastroInfoLote()));
            },
          ),

          // Criação do item menu 'Ração'
          ListTileCustom(
            nome: 'Ração',
            icone: Icons.food_bank,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TelaCadastroEstoqueRacao()));
            },
          ),
        ],
      ),
    ));
  }
}
