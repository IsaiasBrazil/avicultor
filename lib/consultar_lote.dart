import 'package:flutter/material.dart';
import 'package:tcc/banco_dados/bd.dart';
import 'classes/lote.dart';

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
                                Text('Código do galpão: ${lote.codigoGalpao.toString()}'),
                                Text('Idade: ${lote.idade.toString()}'),
                                Text('Data de chegada: ${lote.dataChegada.toString()}'),
                                Text('Descrição: ${lote.descricao.toString()}')
                              ],
                            )
                            //Text('Código do galpão: ${lote.codigoGalpao.toString()}'),
                                       //Text('Idade do lote: ${lote.idade.toString()}'),
                            // subtitle: lote.descricao != null
                            //     ? Text(lote.descricao!,
                            //         style: const TextStyle(
                            //             fontSize: 22,
                            //             color:
                            //                 Color.fromARGB(255, 188, 188, 188)))
                            //     : const Text('',
                            //         style: TextStyle(
                            //             fontSize: 22,
                            //             color: Color.fromARGB(
                            //                 255, 188, 188, 188)))),
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
