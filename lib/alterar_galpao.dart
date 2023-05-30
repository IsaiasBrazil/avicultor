import 'package:flutter/material.dart';
import 'package:tcc/widget_botao.dart';
import 'widget_campo.dart';

class TelaAlteracaoGalpao extends StatefulWidget {
  const TelaAlteracaoGalpao({super.key});

  @override
  State<TelaAlteracaoGalpao> createState() => _TelaAlteracaoGalpaoState();
}

class _TelaAlteracaoGalpaoState extends State<TelaAlteracaoGalpao> {
  TextEditingController codigoGalpao = TextEditingController();
  TextEditingController descricaoGalpao = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: const Text(
          'Alteração de Galpão',
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
                      texto: 'Alterar',
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
