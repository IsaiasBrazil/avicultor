import 'dart:convert';


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
  dynamic dados;

  // Variáveis de controle
  String temperatura = '0';
  int umidade = 0;
  int presencaGasToxico = 0;

  // Variáveis para armazenar as mensagens
  String avisoTemperatura = '';
  String avisoUmidade = '';
  String avisoPresencaGasToxico = '';
  String temperaturaSensor = '';
  String humidadeSensor = '';
  String gasesSensor = '';

  // Variáveis para definir a cor do texto dos avisos
  Color corAvisoTemperatura = Colors.black;
  Color corAvisoUmidade = Colors.black;
  Color corGasesToxicos = Colors.black;

  // Variáveis sobre o dia/horário atual
  String horarioAtual = '';
  String dataAtual = '';

  //Variável para controlar o tempo
  String tempo = "";

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
    try {
      jsonDecode(dados);
      tempo = horarioAtual.toString();
    }
    catch(e){
    }
    setState(() {
      DateTime instanteAtual = DateTime.now();
      horarioAtual = DateFormat('HH:mm:ss').format(instanteAtual);
      dataAtual = DateFormat('dd/MM/yyyy').format(instanteAtual);
      dados = mqttHandler.dados.value;
      tempo = mqttHandler.tempo.value;
      // Mostrar mensagem de acordo com a temperatura atual
      if(temperaturaSensor.isNotEmpty){
        print(temperaturaSensor);
        //
        // temperatura = int.parse(temperaturaSensor);
        // if (temperatura <= 18) {
        //   avisoTemperatura = 'Temperatura baixa!';
        //   corAvisoTemperatura = Colors.blue;
        // } else if (temperatura >= 24) {
        //   avisoTemperatura = 'Temperatura acima do ideal!';
        //   corAvisoTemperatura = Colors.red;
        // } else {
        //   avisoTemperatura = 'Temperatura ideal!';
        //   corAvisoTemperatura = Colors.green;
        // }
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

  Widget listaDadosSensores(){
    // Os dados dos sensores
    // dynamic dados=mqttHandler.temperatura.value;
    Map<String, dynamic> sensorData;
    try {
      sensorData= jsonDecode(dados);
      print("decode ok");
      // Você pode agora trabalhar com o objeto jsonData normalmente.
    } catch (e) {
      dados ="{\"Aguardando dados do sensor\":{\"temperature\":0.00,\"humidity\":0.00}}";
      sensorData = jsonDecode(dados);
      print("falhou decode");
    }
    print("sensorData $sensorData");
    return ListView(
      children: sensorData.entries.map((entry) {
        String sensorName = entry.key;
        if (sensorData[sensorName] is Map<String, dynamic>) {
          if (sensorData[sensorName].containsKey('temperature') &&
              sensorData[sensorName].containsKey('humidity')) {
            // Sensor de temperatura e umidade
            return Card(
              child: ListTile(
                title: Text('Sensor: $sensorName'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(style: TextStyle(
                        fontFamily: "Bebas", fontWeight: FontWeight.bold),
                        'Temperatura: ${sensorData[sensorName]['temperature']}°C'),
                    Text(style: TextStyle(
                        fontFamily: "Bebas", fontWeight: FontWeight.bold),
                        'Umidade: ${sensorData[sensorName]['humidity']}%'),
                  ],
                ),
              ),
            );
          }
          if (sensorData[sensorName].containsKey('NH4')) {
            print("linha 192");
            // Sensor MQ135
            return Card(
              child: ListTile(
                title: Text(style:TextStyle(fontFamily: "BebasNeue"),'Sensor: $sensorName'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text( style:TextStyle(fontFamily: "Bebas",fontWeight: FontWeight.bold),'NH4: ${sensorData[sensorName]['NH4']} ${'ppm'.toLowerCase()}'),
                  ],
                ),
              ),
            );
          }
        }
        return SizedBox(); // Lidando com qualquer outro formato de dados
      }).toList(),
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
              Container(height: 200,
                  child: listaDadosSensores()),
              //     Text(avisoTemperatura,
              //         style: TextStyle(
              //             fontFamily: 'BebasNeue',
              //             fontSize: 20,
              //             color: corAvisoTemperatura)),
              //     Text(avisoUmidade,
              //         style: TextStyle(
              //             fontFamily: 'BebasNeue',
              //             fontSize: 20,
              //             color: corAvisoUmidade)),
              //     Text(
              //         avisoPresencaGasToxico,style: TextStyle(
              //         fontFamily: 'BebasNeue',
              //         fontSize: 20,
              //         color: corGasesToxicos)),
              //
            ],
          ),
        )
      ],
    );
  }
  //
  // _receber() {
  //   return Column(
  //     children: [
  //       Text('Temperatura: $temperaturaSensorº',
  //           style: TextStyle(color: _temperaturaBoa(temperaturaSensor)?Colors.black:Colors.red, fontSize: 35)),
  //       Text('Humidade: $humidadeSensor%',
  //           style: TextStyle(color: _humidadeBoa(humidadeSensor)?Colors.black:Colors.red, fontSize: 35)),
  //       Text('Gases: $gasesSensor ppm',
  //           style: TextStyle(color: _gasBom(gasesSensor)?Colors.black:Colors.red, fontSize: 35)),
  //       // Resto do código...
  //     ],
  //   );
  // }

  // bool _temperaturaBoa(String temperatura){
  //   if(temperatura!='') {
  //     int vumid = 0;
  //
  //     //int.parse(temperatura);
  //
  //     if (vumid >= 18 && vumid <= 24)
  //       return true;
  //   }
  //   return false;
  // }

  // bool _humidadeBoa(String umidade){
  //   if(umidade!='') {
  //     int vumid = int.parse(umidade);
  //     if (vumid >= 30 && vumid <= 70)
  //       return true;
  //   }
  //   return false;
  // }


  // bool _gasBom(String gases){
  //   if(gases!='') {
  //     int vgases = int.parse(gases);
  //     if (vgases < 20)
  //       return true;
  //   }
  //   return false;
  // }

}
 