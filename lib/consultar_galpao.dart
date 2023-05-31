import 'package:flutter/material.dart';
import 'package:tcc/banco_dados/bd.dart';

import 'classes/galpao.dart';

class TelaConsultaGalpao extends StatefulWidget {
  const TelaConsultaGalpao({super.key});

  @override
  State<TelaConsultaGalpao> createState() => _TelaConsultaGalpaoState();
}

class _TelaConsultaGalpaoState extends State<TelaConsultaGalpao> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: const Text('Consulta de galpão', style: TextStyle(fontSize: 34)),
      ),
      body: Center(
        child: FutureBuilder<List<Galpao>>(
          future: BancoDados.instance.obterGalpoes(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Galpao>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                  child: Text('Carregando...', style: TextStyle(fontSize: 30)));
            }
            return snapshot.data!.isEmpty
                ? const Center(
                    child: Text('Não há galpões para consultar',
                        style: TextStyle(fontSize: 30)))
                : ListView(
                    children: snapshot.data!.map((galpao) {
                    return Center(
                      child: Card(
                        margin: const EdgeInsets.all(10.0),
                        child: ListTile(
                            title: Text('Galpão ${galpao.codigo}',
                                style: const TextStyle(fontSize: 28)),
                            subtitle: galpao.descricao != null
                                ? Text(galpao.descricao!,
                                    style: const TextStyle(
                                        fontSize: 22,
                                        color:
                                            Color.fromARGB(255, 188, 188, 188)))
                                : const Text('',
                                    style: TextStyle(
                                        fontSize: 22,
                                        color:
                                            Color.fromARGB(255, 188, 188, 188)))
                            ),
                      ),
                    );
                  }).toList());
          },
        ),
      ),
    );
  }
}
