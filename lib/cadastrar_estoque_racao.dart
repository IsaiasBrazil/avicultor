import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'widget_campo.dart';

class TelaCadastroEstoqueRacao extends StatefulWidget {
  const TelaCadastroEstoqueRacao({super.key});

  @override
  State<TelaCadastroEstoqueRacao> createState() =>
      _TelaCadastroEstoqueRacaoState();
}

class _TelaCadastroEstoqueRacaoState extends State<TelaCadastroEstoqueRacao> {
  TextEditingController qtDeConsumo = TextEditingController();
  TextEditingController qtDeReposicao = TextEditingController();
  TextEditingController data = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: Text('Quantidade de consumo',
            style: TextStyle(fontFamily: 'BebasNeue', fontSize: 34)),
      ),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Campo(
                  nome: 'Quantidade de consumo:',
                  controller: qtDeConsumo,
                  keyboardType: TextInputType.text,
                ),
              ),
              Expanded(
                child: Campo(
                  nome: 'Quantidade de reposição:',
                  controller: qtDeReposicao,
                  keyboardType: TextInputType.text,
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Campo(
                  nome: 'Data:',
                  controller: data,
                  keyboardType: TextInputType.text,
                  onTap: () async {
                    DateTime? dataSelecionada = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (dataSelecionada != null) {
                      setState(() {
                        data.text =
                            DateFormat('dd/MM/yyyy').format(dataSelecionada);
                      });
                    }
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
