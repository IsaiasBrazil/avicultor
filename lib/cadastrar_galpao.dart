import 'package:flutter/material.dart';
import 'widget_campo.dart';

class TelaCadastroGalpao extends StatefulWidget {
  const TelaCadastroGalpao({super.key});

  @override
  State<TelaCadastroGalpao> createState() => _TelaCadastroGalpaoState();
}

class _TelaCadastroGalpaoState extends State<TelaCadastroGalpao> {
  TextEditingController codigoGalpao = TextEditingController();
  TextEditingController descricaoGalpao = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: Text(
          'Cadastro de Galpão',
          style: TextStyle(fontFamily: 'BebasNeue', fontSize: 34),
        ),
      ),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Campo(
                  nome: 'Código',
                  controller: codigoGalpao,
                  keyboardType: TextInputType.text,
                ),
              ),
              Expanded(
                child: Campo(
                  nome: 'Descrição',
                  controller: descricaoGalpao,
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
