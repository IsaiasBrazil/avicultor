import 'package:flutter/material.dart';
import 'package:tcc/banco_dados/bd.dart';
import 'package:tcc/classes/galpao.dart';
import 'package:tcc/widget_botao.dart';
import 'package:tcc/widget_caixa_dialog.dart';
import 'package:tcc/widget_campo_texto.dart';

class ViewGalpao extends StatefulWidget {
  final String tituloView;
  ViewGalpao({super.key, required this.tituloView});

  @override
  State<ViewGalpao> createState() => _ViewGalpaoState();
}

class _ViewGalpaoState extends State<ViewGalpao> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return _construirTelaMobile(widget.tituloView, context);
        } else {
          return _construirTelaDesktop(widget.tituloView, context);
        }
      },
    );
  }
}

Widget _construirTelaMobile(String tituloView, BuildContext context) {
  TextEditingController codigoGalpao = TextEditingController();
  TextEditingController descricaoGalpao = TextEditingController();

  return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: Text(tituloView, style: TextStyle(fontSize: 34.0)),
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
                    aoSerPressionado: () async {
                      String codigo = codigoGalpao.text;
                      String descricao = descricaoGalpao.text;

                      if (codigo.isEmpty) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => const CaixaDialog(
                                titulo: 'Aviso',
                                mensagem:
                                    'Preencha o campo código do galpão para realizar o cadastro!',
                                tituloBotao: 'OK',
                                corFundo: Color.fromRGBO(227, 200, 18, 1),
                                corTexto: Colors.white));
                      } else {
                        Galpao galpao =
                            Galpao(codigo: codigo, descricao: descricao);
                        BancoDados bd = BancoDados.instance;

                        bool resultadoCadastro = await bd.inserirGalpao(galpao);

                        if (!context.mounted) return;
                        mostrarResultado(context, resultadoCadastro);
                      }
                    },
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
                    aoSerPressionado: () {
                      codigoGalpao.clear();
                      descricaoGalpao.clear();
                    },
                  ),
                ),
              )
            ],
          )
        ],
      ));
}

Widget _construirTelaDesktop(String tituloView, BuildContext context) {
  TextEditingController codigoGalpao = TextEditingController();
  TextEditingController descricaoGalpao = TextEditingController();

  return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: Text(tituloView, style: TextStyle(fontSize: 46.0)),
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
                    aoSerPressionado: () async {
                      String codigo = codigoGalpao.text;
                      String descricao = descricaoGalpao.text;

                      if (codigo.isEmpty) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => const CaixaDialog(
                                titulo: 'Aviso',
                                mensagem:
                                    'Preencha o campo código do galpão para realizar o cadastro!',
                                tituloBotao: 'OK',
                                corFundo: Color.fromRGBO(227, 200, 18, 1),
                                corTexto: Colors.white));
                      } else {
                        Galpao galpao =
                            Galpao(codigo: codigo, descricao: descricao);
                        BancoDados bd = BancoDados.instance;

                        bool resultadoCadastro = await bd.inserirGalpao(galpao);

                        if (!context.mounted) return;
                        mostrarResultado(context, resultadoCadastro);
                      }
                    },
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
                    aoSerPressionado: () {
                      codigoGalpao.clear();
                      descricaoGalpao.clear();
                    },
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
