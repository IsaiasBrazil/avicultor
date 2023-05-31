import 'package:flutter/material.dart';
import 'package:tcc/banco_dados/bd.dart';
import 'package:tcc/classes/galpao.dart';
import 'package:tcc/widget_botao.dart';
import 'widget_campo.dart';

class TelaExclusaoGalpao extends StatefulWidget {
  const TelaExclusaoGalpao({super.key});

  @override
  State<TelaExclusaoGalpao> createState() => _TelaExclusaoGalpaoState();
}

class _TelaExclusaoGalpaoState extends State<TelaExclusaoGalpao> {
  TextEditingController codigoGalpao = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: const Text(
          'Exclusão de Galpão',
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: 115,
                    height: 40,
                    child: Botao(
                      texto: 'Excluir',
                      aoSerPressionado: () async {
                        String codigo = codigoGalpao.text;

                        Galpao galpao = Galpao(codigo: codigo);
                        BancoDados bd = BancoDados.instance;

                        bool resultadoExclusao = await bd.excluirGalpao(galpao.codigo);

                        mostrarResultado(context, resultadoExclusao);
                      },
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: 115,
                    height: 40,
                    child: Botao(
                      texto: 'Limpar tudo',
                      aoSerPressionado: () {
                        codigoGalpao.clear();
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

void mostrarResultado(BuildContext context, bool conseguiuExcluir) {
  String mensagem =
      conseguiuExcluir ? 'Galpão excluído!' : 'Falha ao excluir galpão!';

  showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: conseguiuExcluir
              ? const Text('Sucesso',
                  style: TextStyle(fontSize: 32, color: Colors.white))
              : const Text('Erro',
                  style: TextStyle(fontSize: 32, color: Colors.white)),
          content: Text(mensagem,
              style: const TextStyle(fontSize: 24, color: Colors.white)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('OK',
                  style: TextStyle(fontSize: 24, color: Colors.white)),
            )
          ],
          backgroundColor: conseguiuExcluir ? const Color.fromRGBO(60, 179, 113, 1) : const Color.fromRGBO(210, 43, 43, 1)
        );
      });
}
