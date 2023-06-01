import 'package:flutter/material.dart';
import 'package:tcc/banco_dados/bd.dart';
import 'package:tcc/classes/galpao.dart';
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
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: 115,
                    height: 40,
                    child: Botao(
                      texto: 'Cadastrar',
                      aoSerPressionado: () async {
                        String codigo = codigoGalpao.text;
                        String descricao = descricaoGalpao.text;

                        Galpao galpao = Galpao(codigo: codigo, descricao: descricao);
                        BancoDados bd = BancoDados.instance;

                        bool resultadoCadastro = await bd.inserirGalpao(galpao);

                        mostrarResultado(context, resultadoCadastro);
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

void mostrarResultado(BuildContext context, bool conseguiuCadastrar) {
  String mensagem =
      conseguiuCadastrar ? 'Galpão cadastrado!' : 'Falha ao cadastrar galpão!';

  showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
            title: conseguiuCadastrar
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
            backgroundColor: conseguiuCadastrar
                ? const Color.fromRGBO(60, 179, 113, 1)
                : const Color.fromRGBO(210, 43, 43, 1));
      });
}
