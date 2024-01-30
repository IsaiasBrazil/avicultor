import 'package:flutter/material.dart';
import 'package:tcc/models/galpao.dart';
import 'package:tcc/widgets/widget_botao.dart';
import 'package:tcc/widgets/widget_campo_texto.dart';
import 'package:tcc/controllers/galpao_controller.dart';
import '../../utils/mostrar_dialog.dart';

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
                      Galpao galp = Galpao(
                        codigo: codigoGalpao.text, 
                        descricao: descricaoGalpao.text
                      );

                      bool sucessoNoCadastro = await controller.cadastrarGalpao(galp);

                      if (!context.mounted) return;

                      if (sucessoNoCadastro) {
                        mostrarDialog(context, 'Sucesso', 'Galpão cadastrado!', 'Ok', const Color.fromRGBO(60, 179, 113, 1), Colors.white);
                      }
                      else if (!sucessoNoCadastro && !controller.galpaoValido(galp)) {
                        mostrarDialog(context, 'Aviso', 'Preencha o campo código do galpão para realizar o cadastro!', 'Ok', const Color.fromRGBO(227, 200, 18, 1), Colors.white);
                      }
                      else {
                        mostrarDialog(context, 'Erro', 'Falha ao cadastrar galpão!', 'Ok', const Color.fromRGBO(210, 43, 43, 1), Colors.white);
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