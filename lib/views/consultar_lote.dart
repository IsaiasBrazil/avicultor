import 'package:flutter/material.dart';
import 'package:tcc/models/bd.dart';
import '../models/lote.dart';

class TelaConsultaLote extends StatefulWidget {
  const TelaConsultaLote({super.key});

  @override
  State<TelaConsultaLote> createState() => _TelaConsultaLoteState();
}

class _TelaConsultaLoteState extends State<TelaConsultaLote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: const Text('Consulta de lote', style: TextStyle(fontSize: 34)),
      ),
      body: Center(
        child: FutureBuilder<List<Lote>>(
          future: BancoDados.instance.obterLotes(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Lote>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                  child: Text('Carregando...', style: TextStyle(fontSize: 30)));
            }
            return snapshot.data!.isEmpty
                ? const Center(
                    child: Text('Não há lotes para consultar',
                        style: TextStyle(fontSize: 30)))
                : ListView(
                    children: snapshot.data!.map((lote) {
                    return Center(
                      child: Card(
                        margin: const EdgeInsets.all(10.0),
                        child: ListTile(
                            title: Center(
                              child: Text('Lote ${lote.codigoLote}',
                                  style: const TextStyle(fontSize: 28)),
                            ),
                            subtitle:  Column(
                              children: [
                                Text('Código do galpão: ${lote.codigoGalpao}', style: const TextStyle(fontSize: 24)),
                                Text('Idade: ${lote.idade}', style: const TextStyle(fontSize: 24)),
                                Text('Data de chegada: ${lote.dataChegada}', style: const TextStyle(fontSize: 24)),
                                Text('Descrição: ${lote.descricao}', style: const TextStyle(fontSize: 24))
                              ],
                            )
                        )
                      ),
                    );
                  }).toList());
          },
        ),
      ),
    );
  }
}
