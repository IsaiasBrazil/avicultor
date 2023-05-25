import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;


class RecebeDados extends StatefulWidget {
  const RecebeDados({Key? key}) : super(key: key);

  @override
  State<RecebeDados> createState() => _RecebeDadosState();
}

class _RecebeDadosState extends State<RecebeDados> {
  final client = MqttServerClient('test.mosquitto.org', '');
  String temperature = 'N/A';
  String humidity = 'N/A';
  String toxicGas = 'N/A';

  @override
  Widget build(BuildContext context) {
    return _Dados();
  }

  _Dados(){
    client.logging(on: false);
    client.keepAlivePeriod = 30;
    client.onDisconnected = _onDisconnected;
    client.onConnected = _onConnected;

    final mqtt.MqttConnectMessage connMess = mqtt.MqttConnectMessage()
        .withClientIdentifier('flutter_client')
        .startClean()
        .keepAliveFor(30)
        .withWillTopic('willtopic')
        .withWillMessage('Will message')
        .withWillQos(mqtt.MqttQos.exactlyOnce);

    client.connectionMessage = connMess;

    try {
      client.connect('', '');
    } catch (e) {
      print('Exception: $e');
    }
  }

  void _onConnected() {
    print('Connected');
  }

  void _onDisconnected() {
    print('Disconnected');
  }
  void subscribeToSensorData() {
    final mqtt.Subscription? topicTemperature =
    client.subscribe('sensor/temperature', mqtt.MqttQos.exactlyOnce);
    final mqtt.Subscription? topicHumidity =
    client.subscribe('sensor/humidity', mqtt.MqttQos.exactlyOnce);
    final mqtt.Subscription? topicToxicGas =
    client.subscribe('sensor/toxic_gas', mqtt.MqttQos.exactlyOnce);

    client.updates?.listen(
          (mqtt.MqttReceivedMessage message) async {
        final String topic = message.topic;
        final mqtt.MqttPublishMessage payload =
        message.payload as mqtt.MqttPublishMessage;
        final String data =
        mqtt.MqttPublishPayload.bytesToStringAsString(payload.payload.message);

        if (topic == topicTemperature?.topic) {
          setState(() {
            temperature = data;
          });
        } else if (topic == topicHumidity?.topic) {
          setState(() {
            humidity = data;
          });
        } else if (topic == topicToxicGas?.topic) {
          setState(() {
            toxicGas = data;
          });
        }
      } as void Function(List<MqttReceivedMessage<MqttMessage>> event)?,
    );
  }

}