import 'package:flutter/material.dart';
import 'package:tcc/models/galpao.dart';
import 'package:tcc/widgets/widget_botao.dart';
import 'package:tcc/controllers/galpao_controller.dart';
import '../../utils/mostrar_dialog.dart';
import '../../widgets/widget_nome_campo.dart';
import '../../widgets/widget_campo_input.dart';

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
          return const Scaffold();
        }
      },
    );
  }
}

Widget _construirTelaMobile(String tituloView, BuildContext context) {
  TextEditingController codigoGalpao = TextEditingController();
  TextEditingController descricaoGalpao = TextEditingController();
  final GalpaoController controller = GalpaoController();

  return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: Text(tituloView, style: const TextStyle(fontSize: 34.0)),
      ),
      body: Column(
        children: [
          const Row(
            children: [
              NomeCampo(
                  texto: 'Código',
                  tamanhoFonte: 24.0,
                  paddingSuperior: 8.0,
                  paddingInferior: 8.0,
                  paddingEsquerda: 16.0,
                  paddingDireita: 16.0),
            ],
          ),
          Row(
            children: [
              CampoInput(
                controlador: codigoGalpao,
                tipoTeclado: TextInputType.text,
                paddingSuperior: 0.0,
                paddingInferior: 18.0,
                paddingEsquerda: 16.0,
                paddingDireita: 16.0,
              ),
            ],
          ),
          const Row(
            children: [
              NomeCampo(
                  texto: 'Descrição',
                  tamanhoFonte: 24.0,
                  paddingSuperior: 8.0,
                  paddingInferior: 8.0,
                  paddingEsquerda: 16.0,
                  paddingDireita: 16.0),
            ],
          ),
          Row(
            children: [
              CampoInput(
                controlador: descricaoGalpao,
                tipoTeclado: TextInputType.text,
                paddingSuperior: 0.0,
                paddingInferior: 18.0,
                paddingEsquerda: 16.0,
                paddingDireita: 16.0,
              ),
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
                      Galpao galp = Galpao(
                          codigo: codigoGalpao.text,
                          descricao: descricaoGalpao.text);

                      String? resultadoValidacao =
                          controller.validar(galpao: galp);

                      // Se a validação não retornou nenhum erro
                      if (resultadoValidacao == null) {
                        bool sucessoNoCadastro =
                            await controller.cadastrarGalpao(galp);

                        if (!context.mounted) return;

                        if (sucessoNoCadastro) {
                          mostrarDialog(
                              context,
                              'Sucesso',
                              'Galpão cadastrado!',
                              'Ok',
                              const Color.fromRGBO(60, 179, 113, 1),
                              Colors.white);
                        } else {
                          mostrarDialog(
                              context,
                              'Erro',
                              'Falha ao cadastrar galpão!',
                              'Ok',
                              const Color.fromRGBO(210, 43, 43, 1),
                              Colors.white);
                        }
                      } else {
                        mostrarDialog(context, 'Erro', resultadoValidacao, 'Ok',
                            const Color.fromRGBO(210, 43, 43, 1), Colors.white);
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