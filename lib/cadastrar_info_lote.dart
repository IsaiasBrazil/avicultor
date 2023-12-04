import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:tcc/banco_dados/bd.dart';

import 'classes/producao.dart';
import 'widget_botao.dart';
import 'widget_caixa_dialog.dart';
import 'widget_campo.dart';
import 'widget_drawer.dart';

class TelaCadastroInfoLote extends StatefulWidget {
  const TelaCadastroInfoLote({super.key});

  @override
  State<TelaCadastroInfoLote> createState() => _TelaCadastroInfoLoteState();
}

class _TelaCadastroInfoLoteState extends State<TelaCadastroInfoLote> {
  TextEditingController codigoDeControle = TextEditingController();
  TextEditingController codigoDoLote = TextEditingController();
  TextEditingController peso = TextEditingController();
  TextEditingController qtDeAves = TextEditingController();
  TextEditingController data = TextEditingController();
  TextEditingController observacao = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: const Text(
          'Diário de produção',
          style: TextStyle(fontSize: 34),
        ),
      ),
      drawer: const MenuLateral(titulo: 'Avicontrol'),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Campo(
                  nome: 'Código do lote:',
                  controller: codigoDoLote,
                  keyboardType: TextInputType.name,
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Campo(
                  nome: 'Quantidade de aves:',
                  controller: qtDeAves,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+$'))
                  ],
                ),
              ),
              Expanded(
                child: Campo(
                  nome: 'Peso:',
                  controller: peso,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d{0,2}$'))
                  ],
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Campo(
                  nome: 'Data:',
                  controller: data,
                  onTap: () async {
                    DateTime? dataSelecionada = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
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
              Expanded(
                child: Campo(
                  nome: 'Observação:',
                  controller: observacao,
                  keyboardType: TextInputType.name,
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
                      tamanhoFonte: 20.0,
                      corFundo: const Color.fromRGBO(60, 179, 113, 1),
                      corTexto: const Color.fromRGBO(255, 255, 255, 1),
                      aoSerPressionado: () async {
                        String caracteres =
                            '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
                        String cod = '';
                        Random random = Random();

                        for (int i = 0; i < 6; i++) {
                          cod += caracteres[random.nextInt(caracteres.length)];
                        }

                        String codLote = codigoDoLote.text.isNotEmpty
                            ? codigoDoLote.text
                            : '';
                        int qtAves = qtDeAves.text.isNotEmpty
                            ? int.parse(qtDeAves.text)
                            : 0;
                        double pesoMedioAves = peso.text.isNotEmpty
                            ? double.parse(peso.text)
                            : 0.0;
                        String dataHora = data.text.isNotEmpty
                            ? DateFormat('yyyy-MM-dd').format(
                                DateFormat('dd/MM/yyyy').parse(data.text))
                            : '';
                        String obs = observacao.text;
                        BancoDados bd = BancoDados.instance;
                        bool loteEncontrado = await bd.loteExiste(codLote);

                        if (!mounted) return;

                        if (codLote.isEmpty) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => const CaixaDialog(
                                  titulo: 'Aviso',
                                  mensagem:
                                      'Preencha o campo código do lote para realizar o cadastro!',
                                  tituloBotao: 'OK',
                                  corFundo: Color.fromRGBO(227, 200, 18, 1),
                                  corTexto: Colors.white));
                        } else if (!loteEncontrado) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => const CaixaDialog(
                                  titulo: 'Aviso',
                                  mensagem:
                                      'Insira um código de lote existente para realizar o cadastro!',
                                  tituloBotao: 'OK',
                                  corFundo: Color.fromRGBO(227, 200, 18, 1),
                                  corTexto: Colors.white));
                        } else if (loteEncontrado && qtAves <= 0) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => const CaixaDialog(
                                  titulo: 'Aviso',
                                  mensagem:
                                      'Insira uma quantidade de aves válida para realizar o cadastro!',
                                  tituloBotao: 'OK',
                                  corFundo: Color.fromRGBO(227, 200, 18, 1),
                                  corTexto: Colors.white));
                        } else if (loteEncontrado && pesoMedioAves <= 0) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => const CaixaDialog(
                                  titulo: 'Aviso',
                                  mensagem:
                                      'Insira um peso válido para realizar o cadastro!',
                                  tituloBotao: 'OK',
                                  corFundo: Color.fromRGBO(227, 200, 18, 1),
                                  corTexto: Colors.white));
                        } else if (loteEncontrado && dataHora.isEmpty) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => const CaixaDialog(
                                  titulo: 'Aviso',
                                  mensagem:
                                      'Insira uma data válida para realizar o cadastro!',
                                  tituloBotao: 'OK',
                                  corFundo: Color.fromRGBO(227, 200, 18, 1),
                                  corTexto: Colors.white));
                        } else {
                          Producao diario = Producao(
                              codigo: cod,
                              codigoLote: codLote,
                              quantidadeAves: qtAves,
                              peso: pesoMedioAves,
                              data: dataHora,
                              observacao: obs);

                          bool resultadoCadastro =
                              await bd.inserirProducao(diario);
                          if (!mounted) return;
                          mostrarResultado(context, resultadoCadastro);
                        }
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
                      tamanhoFonte: 20.0,
                      corFundo: const Color.fromRGBO(60, 179, 113, 1),
                      corTexto: const Color.fromRGBO(255, 255, 255, 1),
                      aoSerPressionado: () {
                        codigoDoLote.clear();
                        peso.clear();
                        qtDeAves.clear();
                        data.clear();
                        observacao.clear();
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
  String mensagem = conseguiuCadastrar
      ? 'Produção cadastrada!'
      : 'Falha ao cadastrar produção!';

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