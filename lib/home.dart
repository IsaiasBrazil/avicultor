import 'package:flutter/material.dart';
// import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:tcc/widget_drawer.dart';
import 'dart:math';
import 'dart:async';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Variáveis de controle
  int temperatura = 0;
  int umidade = 0;
  bool presencaGasToxico = false;

  // Variáveis para armazenar as mensagens
  String avisoTemperatura = '';
  String avisoUmidade = '';
  String avisoPresencaGasToxico = '';

  // Variáveis para definir a cor do texto dos avisos
  Color corAvisoTemperatura = Colors.black;
  Color corAvisoUmidade = Colors.black;

  // Variáveis sobre o dia/horário atual
  String horarioAtual = '';
  String dataAtual = '';

  Random random = Random();
  late Timer timer;

  @override
  void initState() {
    super.initState();
    iniciarAtualizacoes();
  }

  void iniciarAtualizacoes() {
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) {
      gerarDadosSensores();
    });
  }

  void gerarDadosSensores() {
    setState(() {
      DateTime instanteAtual = DateTime.now();
      horarioAtual = DateFormat('HH:mm:ss').format(instanteAtual);
      dataAtual = DateFormat('dd/MM/yyyy').format(instanteAtual);
      temperatura = random.nextInt(51);
      umidade = random.nextInt(101);
      presencaGasToxico = random.nextBool();

      // Mostrar mensagem de acordo com a temperatura atual
      if (temperatura <= 20) {
        avisoTemperatura = 'Temperatura baixa!';
        corAvisoTemperatura = Colors.blue;
      } else if (temperatura >= 32) {
        avisoTemperatura = 'Temperatura alta!';
        corAvisoTemperatura = Colors.red;
      } else {
        avisoTemperatura = 'Temperatura ideal!';
        corAvisoTemperatura = Colors.black;
      }

      // Mostrar mensagem de acordo com a % de umidade atual
      if (umidade <= 30) {
        avisoUmidade = 'Tempo seco!';
        corAvisoUmidade = Colors.yellow;
      } else if (umidade >= 70) {
        avisoUmidade = 'Tempo úmido!';
        corAvisoUmidade = Colors.yellow;
      } else {
        avisoUmidade = 'Umidade ideal!';
        corAvisoUmidade = Colors.black;
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: const Text(
          'Informações dos sensores',
          style: TextStyle(fontFamily: 'BebasNeue', fontSize: 32),
        ),
      ),
      drawer: MenuLateral(titulo: 'AVICONTROL'),
      body: corpo(),
    );
  }

  Widget corpo() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            children: [
              Text('$dataAtual - $horarioAtual',
                  style: TextStyle(fontFamily: 'BebasNeue', fontSize: 40)),
              Text('Temperatura: $temperatura°C',
                  style: TextStyle(fontFamily: 'BebasNeue', fontSize: 40)),
              Text('$avisoTemperatura',
                  style: TextStyle(
                      fontFamily: 'BebasNeue',
                      fontSize: 40,
                      color: corAvisoTemperatura)),
              Text('Umidade: $umidade %',
                  style: TextStyle(fontFamily: 'BebasNeue', fontSize: 40)),
              Text('$avisoUmidade',
                  style: TextStyle(
                      fontFamily: 'BebasNeue',
                      fontSize: 40,
                      color: corAvisoUmidade)),
              Text(
                  'Presença de gases tóxicos: ' +
                      (presencaGasToxico == true ? 'Sim' : 'Não'),
                  style: TextStyle(fontFamily: 'BebasNeue', fontSize: 40))
            ],
          ),
        )
      ],
    );
  }
}
