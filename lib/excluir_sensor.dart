import 'package:flutter/material.dart';
import 'banco_dados/bd.dart';
import 'widget_botao.dart';
import 'classes/sensor.dart';
import 'widget_campo.dart';

class TelaExclusaoSensor extends StatefulWidget {
  const TelaExclusaoSensor({super.key});

  @override
  State<TelaExclusaoSensor> createState() => _TelaExclusaoSensorState();
}

class _TelaExclusaoSensorState extends State<TelaExclusaoSensor> {
  TextEditingController codigoSensor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: const Text(
          'Exclusão de Sensor',
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
                  nome: 'Código:',
                  controller: codigoSensor,
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
                      texto: 'Excluir',
                      tamanhoFonte: 20.0,
                      corFundo: const Color.fromRGBO(60, 179, 113, 1),
                      corTexto: const Color.fromRGBO(255, 255, 255, 1),
                      aoSerPressionado: () async {
                        String codSensor = codigoSensor.text;

                        Sensor sensor = Sensor(codigo: codSensor);
                        BancoDados bd = BancoDados.instance;

                        bool resultadoExclusao =
                            await bd.excluirSensor(sensor.codigo);
                        if (!mounted) return;
                        mostrarResultado(context, resultadoExclusao);
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
                        codigoSensor.clear();
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

void mostrarResultado(BuildContext context, bool conseguiuExcluir) {
  String mensagem =
      conseguiuExcluir ? 'Sensor excluído!' : 'Falha ao excluir sensor!';

  showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
            title: conseguiuExcluir
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
            backgroundColor: conseguiuExcluir
                ? const Color.fromRGBO(60, 179, 113, 1)
                : const Color.fromRGBO(210, 43, 43, 1));
      });
}
