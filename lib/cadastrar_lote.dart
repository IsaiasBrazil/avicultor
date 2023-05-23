import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'widget_campo.dart';

class TelaCadastroLote extends StatefulWidget {
  const TelaCadastroLote({Key? key}) : super(key: key);

  @override
  State<TelaCadastroLote> createState() => _TelaCadastroLoteState();
}

class _TelaCadastroLoteState extends State<TelaCadastroLote> {
  TextEditingController numeroDoLote = TextEditingController();
  TextEditingController peso = TextEditingController();
  TextEditingController qtDeAves = TextEditingController();
  TextEditingController data = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: const Text(
          'Cadastro de Lote',
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
                  nome: 'Número do lote:',
                  controller: numeroDoLote,
                  keyboardType: TextInputType.text,
                ),
              ),
              Expanded(
                child: Campo(
                  nome: 'Peso:',
                  controller: peso,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d{0,4}\.?\d{0,2}$')),
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
                  nome: 'Quantidade de aves:',
                  controller: qtDeAves,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d{0,4}$')),
                  ],
                ),
              ),
              Expanded(
                child: Campo(
                  nome: 'Data de chegada:',
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
            ],
          ),
        ],
      ),
    );
  }
}
