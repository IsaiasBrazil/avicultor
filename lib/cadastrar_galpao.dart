import 'package:flutter/material.dart';
import 'package:tcc/widget_botao.dart';
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
        title: const Text(
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
                  nome: 'Código:',
                  controller: codigoGalpao,
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
                  nome: 'Descrição:',
                  controller: descricaoGalpao,
                  keyboardType: TextInputType.text,
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
                      aoSerPressionado: () {
                        codigoGalpao.clear();
                        descricaoGalpao.clear();
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
