import 'package:flutter/material.dart';
import 'package:tcc/widgets/widget_botao.dart';
import 'package:tcc/widgets/widget_dropdown.dart';
import 'package:tcc/widgets/widget_future_builder.dart';
import '../../controllers/galpao_controller.dart';
import '../../models/galpao.dart';
import '../../utils/mostrar_dialog.dart';
import '../../widgets/widget_campo_input.dart';
import '../../widgets/widget_nome_campo.dart';

class TelaExclusaoGalpao extends StatefulWidget {
  const TelaExclusaoGalpao({super.key});

  @override
  State<TelaExclusaoGalpao> createState() => _TelaExclusaoGalpaoState();
}

class _TelaExclusaoGalpaoState extends State<TelaExclusaoGalpao> {
  TextEditingController descricaoGalpao = TextEditingController();
  String itemSelecionado = '';
  late int atual;
  final GalpaoController controller = GalpaoController();
  late Future<List<Galpao>> futuro;

  @override
  void initState() {
    super.initState();
    futuro = controller.obterGalpoes();
  }

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
      body: FutureBuilderCustom<List<Galpao>>(
        future: futuro,
        aoObterDadosComSucesso: (dados) {
          if (dados.isEmpty) {
            return const Center(
                child: Text('Não há galpões para excluir',
                    style: TextStyle(fontSize: 30.0)));
          } else {
            List<Galpao> galpoes = dados;
            List<String> opcoes = [];

            for (var galpao in galpoes) {
              opcoes.add(galpao.codigo);
            }

            if (galpoes.isNotEmpty && itemSelecionado.isEmpty) {
              itemSelecionado = opcoes.first;
              atual = 0;
              descricaoGalpao.text = galpoes[atual].descricao.toString();
            }

            return Column(
              children: [
                const Codigo(),
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
                                      itemSelecionado = opcao.toString();
                                      atual = opcoes.indexOf(itemSelecionado);
                                      descricaoGalpao.text =
                                          galpoes[atual].descricao.toString();
                                    }))))
                  ],
                ),
                const Descricao(),
                InputDescricao(descricaoGalpao: descricaoGalpao),
                Botoes(
                  excluir: () async {
                    Galpao galp = Galpao(
                        codigo: opcoes[atual], descricao: descricaoGalpao.text);

                    bool sucessoNaExclusao =
                        await controller.excluirGalpao(galp);

                    if (!context.mounted) return;

                    if (sucessoNaExclusao) {
                      mostrarDialog(
                          context,
                          'Sucesso',
                          'Galpão excluído!',
                          'Ok',
                          const Color.fromRGBO(60, 179, 113, 1),
                          Colors.white);
                    } else {
                      mostrarDialog(
                          context,
                          'Erro',
                          'Falha ao excluir galpão!',
                          'Ok',
                          const Color.fromRGBO(210, 43, 43, 1),
                          Colors.white);
                    }

                    // Ainda há galpões no dropdown?
                    if (atual < opcoes.length - 1) {
                      String codigoProximoGalpao = opcoes[atual + 1];
                      String descricaoProximoGalpao =
                          galpoes[atual + 1].descricao.toString();

                      setState(() {
                        futuro = controller.obterGalpoes();
                        itemSelecionado = codigoProximoGalpao;
                        descricaoGalpao.text = descricaoProximoGalpao;
                      });
                    } else {
                      setState(() {
                        futuro = controller.obterGalpoes();
                        itemSelecionado = '';
                        descricaoGalpao.text = '';
                      });
                    }
                  },
                  limpar: () {
                    descricaoGalpao.clear();
                  },
                )
              ],
            );
          }
        },
      ),
    );
  }
}

class Codigo extends StatelessWidget {
  const Codigo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        NomeCampo(
            texto: 'Código',
            tamanhoFonte: 24.0,
            paddingSuperior: 8.0,
            paddingInferior: 8.0,
            paddingEsquerda: 16.0,
            paddingDireita: 16.0),
      ],
    );
  }
}

class Descricao extends StatelessWidget {
  const Descricao({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        NomeCampo(
            texto: 'Descrição',
            tamanhoFonte: 24.0,
            paddingSuperior: 8.0,
            paddingInferior: 8.0,
            paddingEsquerda: 16.0,
            paddingDireita: 16.0),
      ],
    );
  }
}

class InputDescricao extends StatelessWidget {
  const InputDescricao({
    super.key,
    required this.descricaoGalpao,
  });

  final TextEditingController descricaoGalpao;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CampoInput(
            controlador: descricaoGalpao,
            tipoTeclado: TextInputType.text,
            paddingSuperior: 0.0,
            paddingInferior: 18.0,
            paddingEsquerda: 16.0,
            paddingDireita: 16.0,
          ),
        ),
      ],
    );
  }
}

class Botoes extends StatelessWidget {
  final VoidCallback excluir;
  final VoidCallback limpar;
  const Botoes({super.key, required this.excluir, required this.limpar});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 135,
            height: 40,
            child: Botao(
              texto: 'Excluir',
              tamanhoFonte: 20.0,
              corFundo: const Color.fromRGBO(60, 179, 113, 1),
              corTexto: const Color.fromRGBO(255, 255, 255, 1),
              aoSerPressionado: () async {
                excluir();
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
                limpar();
              },
            ),
          ),
        )
      ],
    );
  }
}