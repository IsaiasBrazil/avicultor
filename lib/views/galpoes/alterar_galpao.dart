import 'package:flutter/material.dart';
import 'package:tcc/widgets/widget_botao.dart';
import 'package:tcc/widgets/widget_dropdown.dart';
import '../../controllers/galpao_controller.dart';
import '../../models/galpao.dart';
import '../../utils/mostrar_dialog.dart';
import '../../widgets/widget_campo_texto.dart';

class TelaAlteracaoGalpao extends StatefulWidget {
  const TelaAlteracaoGalpao({super.key});

  @override
  State<TelaAlteracaoGalpao> createState() => _TelaAlteracaoGalpaoState();
}

class _TelaAlteracaoGalpaoState extends State<TelaAlteracaoGalpao> {
  TextEditingController descricaoGalpao = TextEditingController();
  String? itemSelecionado;
  late int atual;
  final GalpaoController controller = GalpaoController();
  
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
          future: controller.obterGalpoes(),
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
                              Galpao galp = Galpao(
                                codigo: opcoes[atual], 
                                descricao: descricaoGalpao.text
                              );

                              bool sucessoNaAtualizacao = await controller.atualizarGalpao(galp);

                              if (!context.mounted) return;

                              if (sucessoNaAtualizacao) {
                                mostrarDialog(context, 'Sucesso', 'Galpão alterado!', 'Ok', const Color.fromRGBO(60, 179, 113, 1), Colors.white);
                              }
                              else {
                                mostrarDialog(context, 'Erro', 'Falha ao alterar galpão!', 'Ok', const Color.fromRGBO(210, 43, 43, 1), Colors.white);
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