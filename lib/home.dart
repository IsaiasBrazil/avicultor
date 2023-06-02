
import 'package:flutter/material.dart';
import 'package:tcc/widget_drawer.dart';
import 'dart:math';
import 'dart:async';
import 'package:intl/intl.dart';
import 'mqtt/mqtthandler.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  MqttHandler mqttHandler = MqttHandler();

  // Variáveis de controle
  int temperatura = 0;
  int umidade = 0;
  int presencaGasToxico = 0;

  // Variáveis para armazenar as mensagens
  String avisoTemperatura = '';
  String avisoUmidade = '';
  String avisoPresencaGasToxico = '';
  String temperaturaSensor = '&';
  String humidadeSensor = '&';
  String gasesSensor = '&';

  // Variáveis para definir a cor do texto dos avisos
  Color corAvisoTemperatura = Colors.black;
  Color corAvisoUmidade = Colors.black;
  Color corGasesToxicos = Colors.black;

  // Variáveis sobre o dia/horário atual
  String horarioAtual = '';
  String dataAtual = '';

  Random random = Random();
  late Timer timer;

  @override
  void initState() {
    mqttHandler.connect();
    super.initState();
    iniciarAtualizacoes();
  }

  void iniciarAtualizacoes() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      gerarDadosSensores();
    });
  }

  void gerarDadosSensores() {
    setState(() {
      DateTime instanteAtual = DateTime.now();
      horarioAtual = DateFormat('HH:mm:ss').format(instanteAtual);
      dataAtual = DateFormat('dd/MM/yyyy').format(instanteAtual);
      temperaturaSensor = mqttHandler.temperatura.value;
      humidadeSensor = mqttHandler.humidade.value;
      gasesSensor = mqttHandler.gases.value;

      // Mostrar mensagem de acordo com a temperatura atual
      if(temperaturaSensor.isNotEmpty){
        temperatura = int.parse(temperaturaSensor);
        if (temperatura <= 18) {
          avisoTemperatura = 'Temperatura baixa!';
          corAvisoTemperatura = Colors.blue;
        } else if (temperatura >= 24) {
          avisoTemperatura = 'Temperatura acima do ideal!';
          corAvisoTemperatura = Colors.red;
        } else {
          avisoTemperatura = 'Temperatura ideal!';
          corAvisoTemperatura = Colors.green;
        }
      }else{
        avisoTemperatura = 'Temperatura sem leitura!';
        corAvisoTemperatura = Colors.black;
      }

      // Mostrar mensagem de acordo com a % de umidade atual
      if(humidadeSensor.isNotEmpty){
        umidade = int.parse(humidadeSensor);
        if (umidade <= 30) {
          avisoUmidade = 'Tempo seco demais!';
          corAvisoUmidade = Colors.red;
        } else if (umidade >= 70) {
          avisoUmidade = 'Excesso de umidade!';
          corAvisoUmidade = Colors.orange;
        } else {
          avisoUmidade = 'Umidade ideal!';
          corAvisoUmidade = Colors.green;
        }
      }else{
        avisoUmidade = 'Umidade sem leitura!';
        corAvisoUmidade = Colors.black;
      }

      // Mostrar mensagem de acordo com a presença de gases tóxicos
      if(gasesSensor.isNotEmpty){
        presencaGasToxico = int.parse(gasesSensor);
        if (presencaGasToxico>50) {
          avisoPresencaGasToxico = 'Perigo extremo! Presença massiva de gases tóxicos';
          corGasesToxicos = Colors.red;
        } else if (presencaGasToxico > 20) {
          avisoPresencaGasToxico = 'Perigo! Presença de gases tóxicos';
          corGasesToxicos= Colors.orange;
        } else {
          avisoPresencaGasToxico = 'Gases tóxicos ausentes ou dentro da tolerância!';
          corGasesToxicos = Colors.green;
        }
      }else{
        avisoPresencaGasToxico = 'Gases tóxicos sem leitura!';
        corGasesToxicos = Colors.black;
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
          style: TextStyle(fontSize: 32),
        ),
      ),
      drawer: const MenuLateral(titulo: 'AVICONTROL'),
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
                  style: const TextStyle(fontSize: 40)),
              _receber(),
              Container(height: 20,),

              Text(avisoTemperatura,
                  style: TextStyle(
                      fontFamily: 'BebasNeue',
                      fontSize: 20,
                      color: corAvisoTemperatura)),
              Text(avisoUmidade,
                  style: TextStyle(
                      fontFamily: 'BebasNeue',
                      fontSize: 20,
                      color: corAvisoUmidade)),
              Text(
                  avisoPresencaGasToxico,style: TextStyle(
                  fontFamily: 'BebasNeue',
                  fontSize: 20,
                  color: corGasesToxicos)),

            ],
          ),
        )
      ],
    );
  }

  _receber() {
    return Column(
      children: [
        Text('Temperatura: $temperaturaSensorº',
            style: TextStyle(color: _temperaturaBoa(temperaturaSensor)?Colors.black:Colors.red, fontSize: 35)),
        Text('Humidade: $humidadeSensor%',
            style: TextStyle(color: _humidadeBoa(humidadeSensor)?Colors.black:Colors.red, fontSize: 35)),
        Text('Gases: $gasesSensor ppm',
            style: TextStyle(color: _gasBom(gasesSensor)?Colors.black:Colors.red, fontSize: 35)),
        // Resto do código...
      ],
    );
  }

  bool _temperaturaBoa(String temperatura){
    if(temperatura!='') {
      int vumid = int.parse(temperatura);

      if (vumid >= 18 && vumid <= 24)
        return true;
    }
    return false;
  }

  bool _humidadeBoa(String umidade){
    if(umidade!='') {
      int vumid = int.parse(umidade);
      if (vumid >= 30 && vumid <= 70)
        return true;
    }
    return false;
  }


  bool _gasBom(String gases){
    if(gases!='') {
      int vgases = int.parse(gases);
      if (vgases < 20)
        return true;
    }
    return false;
  }

}
