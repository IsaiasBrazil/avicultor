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
