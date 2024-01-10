import 'package:flutter/material.dart';
import 'package:tcc/models/bd.dart';
import '../models/sensor.dart';

class TelaConsultaSensor extends StatefulWidget {
  const TelaConsultaSensor({super.key});

  @override
  State<TelaConsultaSensor> createState() => _TelaConsultaSensorState();
}

class _TelaConsultaSensorState extends State<TelaConsultaSensor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: const Text('Consulta de sensor', style: TextStyle(fontSize: 34)),
      ),
      body: Center(
        child: FutureBuilder<List<Sensor>>(
          future: BancoDados.instance.obterSensores(),
          builder: (BuildContext context, AsyncSnapshot<List<Sensor>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text('Carregando...', style: TextStyle(fontSize: 30)));
            }
            return snapshot.data!.isEmpty
                ? const Center(child: Text('Não há sensores para consultar', style: TextStyle(fontSize: 30)))
                : ListView(
                    children: snapshot.data!.map((sensor) {
                    return Center(
                      child: Card(
                          margin: const EdgeInsets.all(10.0),
                          child: ListTile(
                              title: Center(
                                child: Text('Sensor ${sensor.codigo}', style: const TextStyle(fontSize: 28)),
                              ),
                              subtitle: Column(
                                children: [
                                  Text('Código do galpão: ${sensor.codigoGalpao}', style: const TextStyle(fontSize: 24)),
                                  Text('Tipo: ${sensor.tipo}', style: const TextStyle(fontSize: 24)),
                                  Text('Descrição: ${sensor.descricao}', style: const TextStyle(fontSize: 24))
                                ],
                              ))),
                    );
                  }).toList());
          },
        ),
      ),
    );
  }
}
