import 'package:flutter/material.dart';
import 'package:tcc/banco_dados/bd.dart';
import 'package:tcc/widget_dropdown.dart';

import 'classes/sensor.dart';
import 'widget_botao.dart';
import 'widget_caixa_dialog.dart';
import 'widget_campo.dart';

class TelaCadastroSensor extends StatefulWidget {
  const TelaCadastroSensor({super.key});

  @override
  State<TelaCadastroSensor> createState() => _TelaCadastroSensorState();
}

class _TelaCadastroSensorState extends State<TelaCadastroSensor> {
  TextEditingController codigoDoSensor = TextEditingController();
  TextEditingController codigoDoGalpao = TextEditingController();
  TextEditingController tipoDeSensor = TextEditingController();
  TextEditingController descricaoDoSensor = TextEditingController();
  String tipoDoSensor = "Temperatura";
  String codigoDeGalpao = "abc";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: const Text('Cadastro de sensor', style: TextStyle(fontSize: 34)),
      ),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Campo(
                  nome: 'Código do sensor:',
                  controller: codigoDoSensor,
                  keyboardType: TextInputType.text,
                ),
              ),
              Expanded(
                /*child: Campo(
                  nome: 'Código do galpão:',
                  controller: codigoDoGalpao,
                  keyboardType: TextInputType.text,
                ),*/
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(style: const TextStyle(
                      fontSize: 22,
                      fontFamily: 'BebasNeue',),"Código do galpão:"),
                    Dropdown(
                      selectedOption: codigoDeGalpao,
                      options: const ['abc','2b','3'],
                      onChanged: trocarGalpao,
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Campo(
                  nome: 'Descrição do sensor:',
                  controller: descricaoDoSensor,
                  keyboardType: TextInputType.text,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(style: const TextStyle(
                        fontSize: 22,
                        fontFamily: 'BebasNeue',),"Tipo:"),
                      Dropdown(
                        selectedOption: tipoDoSensor,
                        options: const ["Temperatura","Umidade","Gases"],
                        onChanged: trocarTipo,
                      ),
                    ],
                  ),
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
                      aoSerPressionado: () async {
                        String codSensor = codigoDoSensor.text;
                        String codGalpao = codigoDoGalpao.text;
                        String tipoSensor = tipoDeSensor.text;
                        String descSensor = descricaoDoSensor.text;

                        BancoDados bd = BancoDados.instance;
                        bool galpaoEncontrado =
                        await bd.galpaoExiste(codGalpao);

                        if (!mounted) return;

                        if (!galpaoEncontrado && codSensor.isNotEmpty) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => const CaixaDialog(
                                  titulo: 'Aviso',
                                  mensagem:
                                  'Insira um código de galpão existente para realizar o cadastro!',
                                  tituloBotao: 'OK',
                                  corFundo: Color.fromRGBO(227, 200, 18, 1),
                                  corTexto: Colors.white));
                        } else if (!galpaoEncontrado && codSensor.isEmpty) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => const CaixaDialog(
                                  titulo: 'Aviso',
                                  mensagem:
                                  'Insira um código de galpão existente e preencha o campo código do sensor para realizar o cadastro!',
                                  tituloBotao: 'OK',
                                  corFundo: Color.fromRGBO(227, 200, 18, 1),
                                  corTexto: Colors.white));
                        } else if (galpaoEncontrado && codSensor.isEmpty) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => const CaixaDialog(
                                  titulo: 'Aviso',
                                  mensagem:
                                  'Preencha o campo código do sensor para realizar o cadastro!',
                                  tituloBotao: 'OK',
                                  corFundo: Color.fromRGBO(227, 200, 18, 1),
                                  corTexto: Colors.white));
                        } else {
                          Sensor sensor = Sensor(
                              codigo: codSensor,
                              descricao: descSensor,
                              codigoGalpao: codGalpao,
                              tipo: tipoSensor);

                          bool resultadoCadastro =
                          await bd.inserirSensor(sensor);
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
                      aoSerPressionado: () {
                        codigoDoSensor.clear();
                        codigoDoGalpao.clear();
                        tipoDeSensor.clear();
                        descricaoDoSensor.clear();
                      },
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
  void  trocarTipo(newValue) {
    setState((){
      tipoDoSensor= newValue;
    });
  }

  void  trocarGalpao(newValue) {
    setState((){
      codigoDeGalpao= newValue;
    });
  }
}

void mostrarResultado(BuildContext context, bool conseguiuCadastrar) {
  String mensagem =
  conseguiuCadastrar ? 'Sensor cadastrado!' : 'Falha ao cadastrar sensor!';

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
