import 'package:flutter/material.dart';
import 'package:tcc/banco_dados/bd.dart';
import 'package:tcc/widget_botao.dart';
import 'package:tcc/widget_dropdown.dart';
import 'classes/galpao.dart';
import 'widget_campo_texto.dart';

class TelaAlteracaoGalpao extends StatefulWidget {
  const TelaAlteracaoGalpao({super.key});

  @override
  State<TelaAlteracaoGalpao> createState() => _TelaAlteracaoGalpaoState();
}

class _TelaAlteracaoGalpaoState extends State<TelaAlteracaoGalpao> {
  TextEditingController descricaoGalpao = TextEditingController();
  String? itemSelecionado;
  late int atual;

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
        body: FutureBuilder<List<Galpao>>(
          future: BancoDados.instance.obterGalpoes(),
          builder: (BuildContext context, AsyncSnapshot<List<Galpao>> snapshot) {
            
            // o banco de dados está carregando
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // ou teve algum erro
            else if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            }

            // ou não teve dados no banco de dados
            else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                  child: Text('Não há galpões para alterar',
                      style: TextStyle(fontSize: 30)));
            }

            // ou os dados foram carregados com sucesso
            else {
              List<Galpao> galpoes = snapshot.data!;
              List<String> opcoes = [];

              for (var galpao in galpoes) {
                opcoes.add(galpao.codigo);
              }

              if (itemSelecionado == null) {
                itemSelecionado = opcoes.first;
                atual = 0;
                descricaoGalpao.text = galpoes[atual].descricao.toString();
              }

              return Column(
                children: [
                  const Row(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                        child: Text('Código', style: TextStyle(fontSize: 24.0)),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8.0, left: 16.0, right: 16.0),
                          child: SizedBox(
                              width: 80,
                              child: Dropdown(
                                  tamanhoIcone: 30.0,
                                  itemSelecionado: itemSelecionado,
                                  opcoes: opcoes,
                                  aoSerSelecionado: (opcao) => setState(() {
                                      itemSelecionado = opcao;
                                      atual = opcoes.indexOf(itemSelecionado!);
                                      descricaoGalpao.text =
                                      galpoes[atual].descricao.toString();
                                  })
                              )
                            )
                          )
                      ],
                  ),
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
                        child: Text(
                          'Descrição',
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
                      ))
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
                            texto: 'Alterar',
                            tamanhoFonte: 20.0,
                            corFundo: const Color.fromRGBO(60, 179, 113, 1),
                            corTexto: const Color.fromRGBO(255, 255, 255, 1),
                            aoSerPressionado: () async {
                              String codigo = opcoes[atual];
                              String descricao = descricaoGalpao.text;

                              Galpao galpao =
                                  Galpao(codigo: codigo, descricao: descricao);
                              BancoDados bd = BancoDados.instance;

                              // debugPrint('codigo: ${galpao.codigo}');
                              // debugPrint('descricao: ${galpao.descricao}');
                              int resultadoAtualizacao =
                                  await bd.atualizarGalpao(galpao);

                              if (!context.mounted) return;
                              resultadoAtualizacao > 0
                                  ? mostrarResultado(context, true)
                                  : mostrarResultado(context, false);
                              // debugPrint(
                              //     'Return do resultado da atualização: $resultadoAtualizacao');
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
                              descricaoGalpao.clear();
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
            }
          },
        ));
  }
}

void mostrarResultado(BuildContext context, bool conseguiuCadastrar) {
  String mensagem =
      conseguiuCadastrar ? 'Galpão alterado!' : 'Falha ao alterar galpão!';

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
