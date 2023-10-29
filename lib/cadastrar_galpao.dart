import 'package:flutter/material.dart';
import 'package:tcc/banco_dados/bd.dart';
import 'package:tcc/classes/galpao.dart';
import 'package:tcc/widget_botao.dart';
import 'package:tcc/widget_caixa_dialog.dart';
import 'package:tcc/widget_campo_texto.dart';

class CadastrarGalpao extends StatefulWidget {
  const CadastrarGalpao({super.key});

  @override
  State<CadastrarGalpao> createState() => _CadastrarGalpaoState();
}

class _CadastrarGalpaoState extends State<CadastrarGalpao> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return _construirTelaMobile();
        } else {
          return _construirTelaDesktop();
        }
      },
    );
  }
}

Widget _construirTelaMobile() {
  TextEditingController codigoGalpao = TextEditingController();
  TextEditingController descricaoGalpao = TextEditingController();

  return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title:
            const Text('Cadastro de galpão', style: TextStyle(fontSize: 34.0)),
      ),
      body: Column(
        children: [
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
                child: Text(
                  'Código',
                  style: TextStyle(fontSize: 24.0),
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 18.0, left: 16.0, right: 16.0),
                  child: CampoTexto(
                    controller: codigoGalpao,
                    keyboardType: TextInputType.text,
                  ),
                ),
              )
            ],
          ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
                child: Text(
                  'Descrição:',
                  style: TextStyle(fontSize: 24.0),
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 18.0, left: 16.0, right: 16.0),
                  child: CampoTexto(
                    controller: descricaoGalpao,
                    keyboardType: TextInputType.text,
                  ),
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
                  width: 135,
                  height: 40,
                  child: Botao(
                    texto: 'Cadastrar',
                    tamanhoFonte: 20.0,
                    corFundo: const Color.fromRGBO(60, 179, 113, 1),
                    corTexto: const Color.fromRGBO(255, 255, 255, 1),
                    aoSerPressionado: () {},
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 135,
                  height: 40,
                  child: Botao(
                    texto: 'Limpar tudo',
                    tamanhoFonte: 20.0,
                    corFundo: const Color.fromRGBO(60, 179, 113, 1),
                    corTexto: const Color.fromRGBO(255, 255, 255, 1),
                    aoSerPressionado: () {},
                  ),
                ),
              )
            ],
          )
        ],
      ));
}

Widget _construirTelaDesktop() {
  TextEditingController codigoGalpao = TextEditingController();
  TextEditingController descricaoGalpao = TextEditingController();

  return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title:
            const Text('Cadastro de galpão', style: TextStyle(fontSize: 46.0)),
      ),
      body: Column(
        children: [
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
                child: Text(
                  'Código',
                  style: TextStyle(fontSize: 32.0),
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 18.0, left: 16.0, right: 16.0),
                  child: CampoTexto(
                    controller: codigoGalpao,
                    keyboardType: TextInputType.text,
                  ),
                ),
              )
            ],
          ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
                child: Text(
                  'Descrição:',
                  style: TextStyle(fontSize: 32.0),
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 18.0, left: 16.0, right: 16.0),
                  child: CampoTexto(
                    controller: descricaoGalpao,
                    keyboardType: TextInputType.text,
                  ),
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
                  width: 135,
                  height: 40,
                  child: Botao(
                    texto: 'Cadastrar',
                    tamanhoFonte: 26.0,
                    corFundo: const Color.fromRGBO(60, 179, 113, 1),
                    corTexto: const Color.fromRGBO(255, 255, 255, 1),
                    aoSerPressionado: () {},
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 135,
                  height: 40,
                  child: Botao(
                    texto: 'Limpar tudo',
                    tamanhoFonte: 26.0,
                    corFundo: const Color.fromRGBO(60, 179, 113, 1),
                    corTexto: const Color.fromRGBO(255, 255, 255, 1),
                    aoSerPressionado: () {},
                  ),
                ),
              )
            ],
          )
        ],
      ));
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