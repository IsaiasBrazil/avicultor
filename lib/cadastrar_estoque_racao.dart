import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'widget_botao.dart';
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
        title: Text('Estoque de ração',
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
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+$'))
                  ],
                ),
              ),
              Expanded(
                child: Campo(
                  nome: 'Quantidade de reposição:',
                  controller: qtDeReposicao,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+$'))
                  ],
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(
                    8.0), // Adjust the padding value as per your preference
                child: SizedBox(
                    width: 115,
                    height: 40,
                    child: Botao(
                      texto: 'Cadastrar',
                      aoSerPressionado: () {},
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(
                    8.0), // Adjust the padding value as per your preference
                child: SizedBox(
                    width: 115,
                    height: 40,
                    child: Botao(
                      texto: 'Limpar tudo',
                      aoSerPressionado: () {
                        qtDeConsumo.clear();
                        qtDeReposicao.clear();
                        data.clear();
                      },
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
