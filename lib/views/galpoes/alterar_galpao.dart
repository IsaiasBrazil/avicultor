import 'package:flutter/material.dart';
import 'package:tcc/widgets/widget_botao.dart';
import 'package:tcc/widgets/widget_dropdown.dart';
import 'package:tcc/widgets/widget_future_builder.dart';
import '../../controllers/galpao_controller.dart';
import '../../models/galpao.dart';
import '../../utils/mostrar_dialog.dart';
import '../../widgets/widget_campo_input.dart';
import '../../widgets/widget_nome_campo.dart';

class TelaAlteracaoGalpao extends StatefulWidget {
  const TelaAlteracaoGalpao({super.key});

  @override
  State<TelaAlteracaoGalpao> createState() => _TelaAlteracaoGalpaoState();
}

class _TelaAlteracaoGalpaoState extends State<TelaAlteracaoGalpao> {
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
          'Alteração de Galpão',
          style: TextStyle(fontSize: 34),
        ),
      ),
      body: FutureBuilderCustom<List<Galpao>>(
        future: futuro,
        aoObterDadosComSucesso: (dados) {
          if (dados.isEmpty) {
            return const Center(
                child: Text('Não há galpões para alterar',
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
                  alterar: () async {
                    Galpao galp = Galpao(
                        codigo: opcoes[atual], descricao: descricaoGalpao.text);

                    bool sucessoNaAtualizacao =
                        await controller.atualizarGalpao(galp);

                    if (!context.mounted) return;

                    if (sucessoNaAtualizacao) {
                      mostrarDialog(
                          context,
                          'Sucesso',
                          'Galpão alterado!',
                          'Ok',
                          const Color.fromRGBO(60, 179, 113, 1),
                          Colors.white);
                    } else {
                      mostrarDialog(
                          context,
                          'Erro',
                          'Falha ao alterar galpão!',
                          'Ok',
                          const Color.fromRGBO(210, 43, 43, 1),
                          Colors.white);
                    }

                    setState(() {
                      futuro = controller.obterGalpoes();
                    });
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
  final VoidCallback alterar;
  final VoidCallback limpar;
  const Botoes({super.key, required this.alterar, required this.limpar});

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
              texto: 'Alterar',
              tamanhoFonte: 20.0,
              corFundo: const Color.fromRGBO(60, 179, 113, 1),
              corTexto: const Color.fromRGBO(255, 255, 255, 1),
              aoSerPressionado: () async {
                alterar();
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