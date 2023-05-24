import 'package:flutter/material.dart';

import 'widget_campo.dart';

class TelaCadastroSensor extends StatefulWidget {
  const TelaCadastroSensor({super.key});

  @override
  State<TelaCadastroSensor> createState() => _TelaCadastroSensorState();
}

class _TelaCadastroSensorState extends State<TelaCadastroSensor> {
  TextEditingController codigoDoSensor = TextEditingController();
  TextEditingController descricaoDoSensor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: Text('Cadastro de sensor',
            style: TextStyle(fontFamily: 'BebasNeue', fontSize: 34)),
      ),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Campo(
                  nome: 'Código do sensor:',
                  controller: codigoDoSensor,
                  keyboardType: TextInputType.text,
                ),
              ),
              Expanded(
                child: Campo(
                  nome: 'Descrição:',
                  controller: descricaoDoSensor,
                  keyboardType: TextInputType.text,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
