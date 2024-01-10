import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../widgets/widget_botao.dart';
import '../widgets/widget_campo.dart';

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
        title: const Text('Estoque de ração',
            style: TextStyle(fontSize: 34)),
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
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))
                  ],
                ),
              ),
              Expanded(
                child: Campo(
                  nome: 'Quantidade de reposição:',
                  controller: qtDeReposicao,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))
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
                padding: const EdgeInsets.all(
                    8.0), // Adjust the padding value as per your preference
                child: SizedBox(
                    width: 115,
                    height: 40,
                    child: Botao(
                      texto: 'Cadastrar',
                      tamanhoFonte: 20.0,
                      corFundo: const Color.fromRGBO(60, 179, 113, 1),
                      corTexto: const Color.fromRGBO(255, 255, 255, 1),
                      aoSerPressionado: () {},
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
