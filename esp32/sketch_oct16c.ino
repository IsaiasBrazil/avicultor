#include "DHT.h"
#include <WiFi.h>
#include <PubSubClient.h>
#include <WiFiUdp.h>
#include <NTPClient.h>
#include <MQUnifiedsensor.h>


//definições referente ao sensor mq135
#define board ("ESP-32")          // Development Board
#define Voltage_Resolution 3.3    // VCC
#define pin A5                    // Analog Input 0 of ESP32
#define type "MQ-135"             // MQ135
#define ADC_Bit_Resolution 12     // For ESP32
#define RatioMQ135CleanAir 3.6    // RS / R0 = 3.6 ppm
//declara sensor
MQUnifiedsensor MQ135(board, Voltage_Resolution, ADC_Bit_Resolution, pin, type);


#define DHTPIN1 2
#define DHTPIN2 4
#define DHTTYPE DHT11

const char* ssid = "Isaias";
const char* password = "richard89";
const char* mqttServer = "test.mosquitto.org";
const int mqttPort = 1883;
const char* mqttUser = "";
const char* mqttPassword = "";
const char* mqttTopic = "av1c0ntr0lz2er0";
const char* mqttTime = "av1c0ntr0lz2er0/time";
const char* mqttClientID = "av1c0ntr0lz2er0-ESP32";
const long utcOffsetInSeconds = -10800;  // Ajuste de fuso horário (em segundos), se necessário
double NH4 = (0);  


WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP, "pool.ntp.org", utcOffsetInSeconds);
DHT dht1(DHTPIN1, DHTTYPE);
DHT dht2(DHTPIN2, DHTTYPE);


WiFiClient espClient;
PubSubClient client(espClient);

void setup() {
  Serial.begin(115200);
  Serial.println("DHTxx test!");
  dht1.begin();
  dht2.begin();
  WiFi.begin(ssid, password);
  timeClient.begin();

  //pinMode(pin,INPUT);

  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi...");
  }

  client.setServer(mqttServer, mqttPort);

     //Set math model to calculate the PPM concentration and the value of constants   
    MQ135.setRegressionMethod(1); //_PPM =  a*ratio^b   
    MQ135.setA(102.2); //nh4 = amonia
    MQ135.setB(-2.473); //nh4      
  /*
    Exponential regression:
  GAS      | a      | b
  CO       | 605.18 | -3.937  
  Alcohol  | 77.255 | -3.18 
  CO2      | 110.47 | -2.862
  Toluen   | 44.947 | -3.445
  NH4      | 102.2  | -2.473
  Aceton   | 34.668 | -3.369
  */

    // // Configurate the ecuation values to get NH4 concentration    
    MQ135.init();    
    Serial.print("Calibrating please wait.");   
    float calcR0 = 0;   
    for(int i = 1; i<=10; i ++)   {     
      MQ135.update(); // Update data, the arduino will be read the voltage on the analog pin     
      calcR0 += MQ135.calibrate(RatioMQ135CleanAir);    
      Serial.print(".");
    }   
    MQ135.setR0(calcR0/10);  
    Serial.println("  done!.");      
    if(isinf(calcR0)) { 
      Serial.println("Warning: Conection issue founded, R0 is infite (Open circuit detected) please check your wiring and supply");
      while(1);
    }
    if(calcR0 == 0){
      Serial.println("Warning: Conection issue founded, R0 is zero (Analog pin with short circuit to ground) please check your wiring and supply");
      while(1);
    }   
    //**********  MQ CAlibration *********/                   
    MQ135.serialDebug(false); 
}

void loop() {
  delay(2000);
  timeClient.update();
  Serial.println(timeClient.getFormattedTime());
  MQ135.update(); // Update data, the arduino will read the voltage from the analog pin
  NH4 = MQ135.readSensor();// Sensor will read PPM concentration using the model, a and b values set previously or from the setup
  if (isnan(NH4)) {
    Serial.println("Error reading NH4 concentration. Skipping MQTT update.");
  } else {
    Serial.print("NH4 : ");
  }


  float h1 = dht1.readHumidity();
  float t1 = dht1.readTemperature();
  float h2 = dht2.readHumidity();
  float t2 = dht2.readTemperature();
  
  if (isnan(t1)) {
    Serial.println("Erro na hora de ler temp1");
  } else {
    Serial.print("Sensor 1 - Temperatura: ");
    Serial.print(t1);
    Serial.println(" C");
  }

  if (isnan(h1)) {
    Serial.println("Erro na hora de ler umidade1");
  } else {
    Serial.print("Sensor 1 - Umidade: ");
    Serial.print(h1);
    Serial.println(" %");
  }

  if (isnan(t2)) {
    Serial.println("Erro na hora de ler temp2");
  } else {
    Serial.print("Sensor 2 - Temperatura: ");
    Serial.print(t2);
    Serial.println(" C");
  }

  if (isnan(h2)) {
    Serial.println("Erro na hora de ler umidade2");
  } else {
    Serial.print("Sensor 2 - Umidade: ");
    Serial.print(h2);
    Serial.println(" %");
  }

  if (!isnan(t1) && !isnan(h1) && !isnan(t2) && !isnan(h2)) {
    char payload[200];
    snprintf(payload, sizeof(payload), "{\"sensor1\":{\"temperature\":%.2f,\"humidity\":%.2f},\"sensor2\":{\"temperature\":%.2f,\"humidity\":%.2f},\"NH4\":{\"NH4\":%.2f}}", t1, h1, t2, h2,NH4);
    client.publish(mqttTopic, payload);
    Serial.println(payload);
    String horaRTC=timeClient.getFormattedTime();
    client.publish(mqttTime, horaRTC.c_str());
  }

  if (!client.connected()) {
    reconnect();
  }
}

void reconnect() {
  while (!client.connected()) {
    if (WiFi.status() != WL_CONNECTED) {
      Serial.println("WiFi connection lost. Reconnecting...");
      connectWiFi();
    }
    Serial.println("Connecting to MQTT...");
    if (client.connect(mqttClientID, mqttUser, mqttPassword)) {
      Serial.println("Connected to MQTT");
    } else {
      Serial.print("Failed, rc=");
      Serial.print(client.state());
      Serial.println(" Try again in 5 seconds");
      delay(5000);
    }
  }
}

void connectWiFi() {
 Serial.println("Reconnecting to WiFi...");
  WiFi.begin(ssid, password);
  int attempts = 0;
  
  while (WiFi.status() != WL_CONNECTED && attempts < 10) {
    delay(500);  // Aguarde 500 milissegundos antes de verificar novamente
    Serial.print(".");
    attempts++;
  }

  if (WiFi.status() == WL_CONNECTED) {
    Serial.println("\nWiFi reconnected.");
  } else {
    Serial.println("\nFailed to reconnect to WiFi. Will retry in loop.");
  }
}