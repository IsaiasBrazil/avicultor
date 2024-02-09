import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:tcc/controllers/galpao_controller.dart';
import 'package:tcc/controllers/lote_controller.dart';
import 'package:tcc/widgets/widget_dropdown.dart';
import '../../models/galpao.dart';
import '../../models/lote.dart';
import '../../utils/mostrar_dialog.dart';
import '../../widgets/widget_botao.dart';
import '../../widgets/widget_campo.dart';

class TelaCadastroLote extends StatefulWidget {
  const TelaCadastroLote({super.key});

  @override
  State<TelaCadastroLote> createState() => _TelaCadastroLoteState();
}

class _TelaCadastroLoteState extends State<TelaCadastroLote> {
  TextEditingController codigoDoLote = TextEditingController();
  TextEditingController idade = TextEditingController();
  TextEditingController data = TextEditingController();
  TextEditingController descricao = TextEditingController();
  final GalpaoController galpaoController = GalpaoController(); 
  final LoteController loteController = LoteController();
  String? itemSelecionado;
  late int atual;

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
      body: FutureBuilder<List<Galpao>>(
        future: galpaoController.obterGalpoes(),
        builder: (BuildContext context, AsyncSnapshot<List<Galpao>> snapshot) {
            // o banco de dados está carregando
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // ou teve algum erro
            else if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            }

            // ou nenhum galpão foi encontrado
            else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Padding(
                padding: EdgeInsets.only(left: 18.0, right: 18.0),
                child: Center(
                    child: Text('Para cadastrar lotes, você precisa ter galpões registrados!',
                        style: TextStyle(fontSize: 30))),
              );
            }

            else {              
              List<Galpao> galpoes = snapshot.data!;
              List<String> opcoes = [];

              for (var galpao in galpoes) {
                opcoes.add(galpao.codigo);
              }

              if (itemSelecionado == null && opcoes.isNotEmpty) {
                itemSelecionado = opcoes.first;
                atual = 0;
              }

              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Campo(
                          nome: 'Código do lote',
                          controller: codigoDoLote,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  const Text('Código do galpão', style: TextStyle(fontSize: 22.0)),
                                  // Parte responsável pela seleção do galpão
                                  Dropdown(
                                    tamanhoIcone: 30.0,
                                    itemSelecionado: itemSelecionado,
                                    opcoes: opcoes,
                                    aoSerSelecionado: (opcao) => setState(() {
                                      itemSelecionado = opcao;
                                      atual = opcoes.indexOf(itemSelecionado!);
                                    }),
                                  )
                                ],
                              ),
                            )           
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
                          nome: 'Idade',
                          controller: idade,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+$'))
                          ],
                        ),
                      ),
                      Expanded(
                        child: Campo(
                          nome: 'Data de chegada',
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
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Campo(
                          nome: 'Descrição',
                          controller: descricao,
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
                            tamanhoFonte: 20.0,
                            corFundo: const Color.fromRGBO(60, 179, 113, 1),
                            corTexto: const Color.fromRGBO(255, 255, 255, 1),
                            aoSerPressionado: () async {
                              Lote l = Lote(
                                codigoLote: codigoDoLote.text,
                                codigoGalpao: itemSelecionado,
                                idade: idade.text.isNotEmpty ? int.parse(idade.text) : 0,
                                dataChegada: data.text,
                                descricao: descricao.text
                              );
                  
                              bool sucessoNoCadastro = await loteController.cadastrarLote(l, galpoes[atual]);

                              if (!mounted) return;

                              if (sucessoNoCadastro) {
                                mostrarDialog(context, 'Sucesso', 'Lote cadastrado!', 'Ok', const Color.fromRGBO(60, 179, 113, 1), Colors.white);
                              }
                              else if (!sucessoNoCadastro &&
                              !loteController.loteValido(l)) {
                                mostrarDialog(context, 'Aviso', 'Código do lote inválido!', 'Ok', const Color.fromRGBO(227, 200, 18, 1), Colors.white);
                              }
                              else {
                                mostrarDialog(context, 'Erro', 'Falha ao cadastrar lote!', 'Ok', const Color.fromRGBO(210, 43, 43, 1), Colors.white);
                              }
                            },
                          ),
                        ),
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
                                idade.clear();
                                data.clear();
                                descricao.clear();
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              );
            }
        },
      ),
    );
  }
}