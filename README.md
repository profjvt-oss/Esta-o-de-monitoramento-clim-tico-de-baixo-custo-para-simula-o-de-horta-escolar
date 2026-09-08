# 🌱 Estação de Monitoramento Climático para Horta Marciana

*Estação meteorológica de baixo custo com Arduino para monitorar temperatura, umidade e luminosidade em hortas escolares que simulam condições marcianas.*

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.SEU-DOI.svg)](https://doi.org/10.5281/zenodo.SEU-DOI)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Arduino](https://img.shields.io/badge/Arduino-UNO-00979D?logo=arduino&logoColor=white)](https://arduino.cc)

---

## 📋 Sobre o Projeto

Este projeto foi desenvolvido no âmbito do programa **"Meninas no Espaço"** e tem como objetivo construir uma estação meteorológica autônoma de baixo custo para monitorar variáveis ambientais em hortas escolares que simulam condições marcianas.

Utilizando uma plataforma **Arduino Uno** e sensores de baixo custo (DHT22 e LDR), o sistema registra:

- 🌡️ Temperatura ambiente
- 💧 Umidade relativa do ar
- ☀️ Intensidade luminosa (incidência solar)

Os dados são coletados periodicamente e enviados via porta serial para um computador, onde são armazenados em formato CSV para análise posterior. O custo total dos componentes é inferior a **R$ 100,00**, tornando o sistema acessível para replicação em escolas públicas.

---

## 🧩 Componentes Utilizados

| Componente           | Quantidade | Função                                      |
|----------------------|------------|---------------------------------------------|
| Arduino Uno          | 1          | Placa microcontroladora                     |
| Sensor DHT22         | 1          | Medição de temperatura e umidade            |
| Sensor LDR (CdS)     | 1          | Medição de luminosidade                     |
| Resistor 10 kΩ       | 1          | Divisor de tensão para o LDR                |
| Protoboard + jumpers | 1 conjunto | Montagem do circuito                        |
| Cabo USB tipo A-B    | 1          | Comunicação e alimentação                   |

> 💰 **Custo total aproximado: R$ 96,50**

---

## 🔌 Esquema de Ligação

| Sensor         | Pino do Arduino        |
|----------------|------------------------|
| DHT22 VCC      | 5V                     |
| DHT22 GND      | GND                    |
| DHT22 DATA     | Digital 2              |
| LDR Terminal A | 5V                     |
| LDR Terminal B | Analógico A0 (via resistor 10 kΩ para GND) |

---

## 🚀 Como Utilizar

### 1. Configuração do Arduino

1. Conecte os componentes conforme o esquema acima.
2. Abra o arquivo `firmware/estacao_meteorologica.ino` na IDE do Arduino.
3. Selecione a porta correta e faça o upload do código para a placa.

### 2. Captura dos Dados

1. Conecte o Arduino ao computador via USB.
2. Verifique qual porta serial está sendo utilizada (ex: COM3, COM14).
3. Edite o arquivo `scripts/captura_dados.bat` e ajuste a variável `PORTA` conforme necessário:
   ```batch
   set "PORTA=COM14"
4. Execute o script .bat. Ele criará automaticamente:
- Um arquivo CSV com os dados capturados
- Um arquivo de LOG com os registros de início e fim
Para encerrar a captura, pressione Ctrl+C.


📄 Licença
Este projeto é distribuído sob a licença MIT. Sinta-se à vontade para usar, modificar e distribuir, desde que seja dado o devido crédito ao autor original.

📝 Como Citar
Se você utilizar este código em seu trabalho, por favor cite-o como:

Formato ABNT:
LIMA, João Victor Tomaz de. Estação de Monitoramento Climático para Horta Marciana. GitHub, 2026. 
Disponível em: https://github.com/profjvt-oss/horta-marciana. 

Formato BibTeX:
@software{lima_2026_estacao,
  author       = {Lima, João Victor Tomaz de},
  title        = {Esta{\c c}{\~a}o de Monitoramento Clim{\'a}tico para Horta Marciana},
  year         = {2026},
  publisher    = {Zenodo},
  version      = {1.0.0},
  doi          = {10.5281/zenodo.SEU-DOI},
  url          = {https://github.com/[SEU-USUARIO]/horta-marciana}
}
