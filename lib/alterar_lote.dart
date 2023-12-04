import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'widget_botao.dart';
import 'widget_campo.dart';

class TelaAlteracaoLote extends StatefulWidget {
  const TelaAlteracaoLote({Key? key}) : super(key: key);

  @override
  State<TelaAlteracaoLote> createState() => _TelaAlteracaoLoteState();
}

class _TelaAlteracaoLoteState extends State<TelaAlteracaoLote> {
  TextEditingController codigoDoLote = TextEditingController();
  TextEditingController codigoDoGalpao = TextEditingController();
  TextEditingController idade = TextEditingController();
  TextEditingController data = TextEditingController();
  TextEditingController descricao = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: const Text(
          'Alteração de Lote',
          style: TextStyle(fontSize: 34),
        ),
      ),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Campo(
                  nome: 'Código do lote:',
                  controller: codigoDoLote,
                  keyboardType: TextInputType.text,
                ),
              ),
              Expanded(
                child: Campo(
                  nome: 'Código do galpão:',
                  controller: codigoDoGalpao,
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
                  nome: 'Idade:',
                  controller: idade,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+$'))
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Campo(
                  nome: 'Descrição:',
                  controller: descricao,
                  keyboardType: TextInputType.text,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(
                    8.0), // Adjust the padding value as per your preference
                child: SizedBox(
                    width: 115,
                    height: 40,
                    child: Botao(
                      texto: 'Alterar',
                      tamanhoFonte: 20.0,
                      corFundo: const Color.fromRGBO(60, 179, 113, 1),
                      corTexto: const Color.fromRGBO(255, 255, 255, 1),
                      aoSerPressionado: () {
                        debugPrint(codigoDoLote.text);
                      },
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(
                    8.0), // Adjust the padding value as per your preference
                child: SizedBox(
                    width: 115,
                    height: 40,
                    child: Botao(
                      texto: 'Limpar tudo',
                      tamanhoFonte: 20.0,
                      corFundo: const Color.fromRGBO(60, 179, 113, 1),
                      corTexto: const Color.fromRGBO(255, 255, 255, 1),
                      aoSerPressionado: () {
                        codigoDoLote.clear();
                        codigoDoGalpao.clear();
                        idade.clear();
                        data.clear();
                        descricao.clear();
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
