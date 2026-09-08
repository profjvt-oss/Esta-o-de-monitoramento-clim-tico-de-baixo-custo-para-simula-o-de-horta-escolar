#include <DHT.h>

#define DHTPIN 2
#define DHTTYPE DHT11  // ou DHT22
#define LDRPIN A0
#define INTERVALO_LEITURA 600000  // 10 minutos

DHT dht(DHTPIN, DHTTYPE);

unsigned long ultimoTempo = 0;
unsigned long tempoInicial = 0;
int numeroLeitura = 1;

void setup() {
  Serial.begin(9600);
  dht.begin();
  
  tempoInicial = millis();
  
  // Cabeçalho CSV (sem texto extra)
  Serial.println("Numero;Tempo(min);Temperatura(C);Umidade(%);Luminosidade");
  
  fazerLeitura();
}

void loop() {
  if (millis() - ultimoTempo >= INTERVALO_LEITURA) {
    ultimoTempo = millis();
    fazerLeitura();
  }
}

void fazerLeitura() {
  float temperatura = dht.readTemperature();
  float umidade = dht.readHumidity();
  int luminosidade = analogRead(LDRPIN);
  
  if (isnan(temperatura) || isnan(umidade)) {
    return;  // Ignora leituras com erro
  }
  
  unsigned long tempoDecorrido = (millis() - tempoInicial) / 60000;
  
  // Formato CSV limpo (apenas dados, sem texto)
  Serial.print(numeroLeitura);
  Serial.print(";");
  Serial.print(tempoDecorrido);
  Serial.print(";");
  Serial.print(temperatura, 1);
  Serial.print(";");
  Serial.print(umidade, 1);
  Serial.print(";");
  Serial.println(luminosidade);
  
  numeroLeitura++;
}