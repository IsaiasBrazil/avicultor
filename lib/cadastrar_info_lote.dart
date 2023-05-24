import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'widget_campo.dart';
import 'widget_drawer.dart';

class TelaCadastroInfoLote extends StatefulWidget {
  const TelaCadastroInfoLote({super.key});

  @override
  State<TelaCadastroInfoLote> createState() => _TelaCadastroInfoLoteState();
}

class _TelaCadastroInfoLoteState extends State<TelaCadastroInfoLote> {
  TextEditingController codigoDeControle = TextEditingController();
  TextEditingController codigoDoLote = TextEditingController();
  TextEditingController peso = TextEditingController();
  TextEditingController qtDeAves = TextEditingController();
  TextEditingController data = TextEditingController();
  TextEditingController descricao = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: Text(
          'Controle de lote',
          style: TextStyle(fontFamily: 'BebasNeue', fontSize: 34),
        ),
      ),
      drawer: MenuLateral(titulo: 'Avicontrol'),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Campo(
                  nome: 'Código de controle:',
                  controller: codigoDeControle,
                  keyboardType: TextInputType.text,
                ),
              ),
              Expanded(
                child: Campo(
                  nome: 'Código do lote:',
                  controller: codigoDoLote,
                  keyboardType: TextInputType.name,
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Campo(
                  nome: 'Quantidade de aves:',
                  controller: qtDeAves,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+$'))
                  ],
                ),
              ),
              Expanded(
                child: Campo(
                  nome: 'Peso:',
                  controller: peso,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+$'))
                  ],
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Campo(
                  nome: 'Data:',
                  controller: data,
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
              ),
              Expanded(
                child: Campo(
                  nome: 'Descrição:',
                  controller: descricao,
                  keyboardType: TextInputType.name,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
