import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'banco_dados/bd.dart';
import 'classes/lote.dart';
import 'widget_botao.dart';
import 'widget_caixa_dialog.dart';
import 'widget_campo.dart';

class TelaCadastroLote extends StatefulWidget {
  const TelaCadastroLote({super.key});

  @override
  State<TelaCadastroLote> createState() => _TelaCadastroLoteState();
}

class _TelaCadastroLoteState extends State<TelaCadastroLote> {
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
          'Cadastro de Lote',
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
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: 115,
                    height: 40,
                    child: Botao(
                        texto: 'Cadastrar',
                        tamanhoFonte: 20.0,
                        corFundo: const Color.fromRGBO(60, 179, 113, 1),
                        corTexto: const Color.fromRGBO(255, 255, 255, 1),
                        aoSerPressionado: () async {
                          String codLote = codigoDoLote.text;
                          String codGalpao = codigoDoGalpao.text;
                          int idadeLote =
                              idade.text.isNotEmpty ? int.parse(idade.text) : 0;
                          String dataLote = data.text;
                          String descLote = descricao.text;
                          BancoDados bd = BancoDados.instance;
                          bool galpaoEncontrado =
                              await bd.galpaoExiste(codGalpao);

                          if (!mounted) return;

                          if (!galpaoEncontrado && codLote.isNotEmpty) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    const CaixaDialog(
                                        titulo: 'Aviso',
                                        mensagem:
                                            'Insira um código de galpão existente para realizar o cadastro!',
                                        tituloBotao: 'OK',
                                        corFundo:
                                            Color.fromRGBO(227, 200, 18, 1),
                                        corTexto: Colors.white));
                          } else if (!galpaoEncontrado && codLote.isEmpty) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    const CaixaDialog(
                                        titulo: 'Aviso',
                                        mensagem:
                                            'Insira um código de galpão existente e preencha o campo código do lote para realizar o cadastro!',
                                        tituloBotao: 'OK',
                                        corFundo:
                                            Color.fromRGBO(227, 200, 18, 1),
                                        corTexto: Colors.white));
                          } else if (galpaoEncontrado && codLote.isEmpty) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    const CaixaDialog(
                                      titulo: 'Aviso',
                                      mensagem:
                                          'Preencha o campo código do lote para realizar o cadastro!',
                                      tituloBotao: 'OK',
                                      corFundo: Color.fromRGBO(227, 200, 18, 1),
                                      corTexto: Colors.white,
                                    ));
                          } else {
                            Lote lote = Lote(
                                codigoLote: codLote,
                                descricao: descLote,
                                idade: idadeLote,
                                dataChegada: dataLote,
                                codigoGalpao: codGalpao);

                            bool resultadoCadastro = await bd.inserirLote(lote);
                            if (!mounted) return;
                            mostrarResultado(context, resultadoCadastro);
                          }
                        })),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
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

void mostrarResultado(BuildContext context, bool conseguiuCadastrar) {
  String mensagem =
      conseguiuCadastrar ? 'Lote cadastrado!' : 'Falha ao cadastrar lote!';

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
