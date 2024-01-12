#include <Arduino.h>
#if defined(ESP32)
  #include <WiFi.h>
#elif defined(ESP8266)
  #include <ESP8266WiFi.h>
#endif
#include <Firebase_ESP_Client.h>

//Provide the token generation process info.
#include "addons/TokenHelper.h"
//Provide the RTDB payload printing info and other helper functions.
#include "addons/RTDBHelper.h"

// Insert your network credentials
#define WIFI_SSID "x"
#define WIFI_PASSWORD "fadhlur12"

// Insert Firebase project API Key
#define API_KEY "AIzaSyDRRSRXrbteQIwHhBjcwk07A5SPGXqAezE"

// Insert RTDB URLefine the RTDB URL */
#define DATABASE_URL "https://agrosmart-e86d3-default-rtdb.asia-southeast1.firebasedatabase.app/" 

//Define Firebase Data object
FirebaseData fbdo;

FirebaseAuth auth;
FirebaseConfig config;

unsigned long sendDataPrevMillis = 0;
int count = 0;
bool signupOK = false;

#include <DHT.h>    // Library dht
#include <BH1750.h> // Library sensor cahaya
#include <Wire.h>   // Library wire
#include <RTClib.h> // Library rtc

#define PHPin 27        //Pin sensor ph tanah
#define DHTPIN 2        //Pin where the DHT11 is connected
#define DHTTYPE DHT11   //Type of the DHT sensor
#define soilPin  12     //Pin sensor soil
#define relayPin 13     //Pin relay

int sensorValue = 0;    //Value sensor tanah
float outputValue = 0.0;//Value output ph tanah
int nilaiPh ;           //Value nilai kelembapan

bool rly_on = true;
bool rly_off = false;

DHT dht(DHTPIN, DHTTYPE);
BH1750 lightMeter;
RTC_DS3231 rtc;

void startIrrigation() {
  // Hidupkan relay untuk memulai penyiraman
  
  Serial.println("Memulai penyiraman...");
  digitalWrite(relayPin, LOW);
  Serial.println(rly_on);
  // Simulasikan penyiraman selama 10 detik (gantilah dengan logika sesuai kebutuhan Anda)
  delay(10000);

  // Matikan relay setelah selesai penyiraman
  digitalWrite(relayPin, HIGH);
  Serial.println("Penyiraman selesai.");
  Serial.println(rly_off);
}

void addIrrigationSchedule() {
  Serial.println("Masukkan jadwal penyiraman (hh:mm):");

  String scheduleInput = "";
  while (true) {
    if (Serial.available() > 0) {
      char inputChar = Serial.read();

      // Berhenti jika ditemukan karakter baru atau garis baru
      if (inputChar == '\n' || inputChar == '\r') {
        break;
      }

      // Tambahkan karakter ke string jadwalInput
      scheduleInput += inputChar;
    }
    scheduleInput.trim();  // Hilangkan spasi ekstra

  if (scheduleInput.length() == 5 && scheduleInput[2] == ':') {
    int hour = scheduleInput.substring(0, 2).toInt();
    int minute = scheduleInput.substring(3, 5).toInt();

    // Validasi waktu
    if (hour >= 0 && hour <= 23 && minute >= 0 && minute <= 59) {
      // Tambahkan kode untuk menyimpan jadwal penyiraman
      Serial.println("Jadwal penyiraman berhasil ditambahkan.");
    } else {
      Serial.println("Format waktu tidak valid. Gunakan format hh:mm");
    }
  } else {
    Serial.println("Format waktu tidak valid. Gunakan format hh:mm");
  }
}
}
  


void setup() {
   WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED){
    Serial.print(".");
    delay(1000);
  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();

  /* Assign the api key (required) */
  config.api_key = API_KEY;

  /* Assign the RTDB URL (required) */
  config.database_url = DATABASE_URL;

  /* Sign up */
  if (Firebase.signUp(&config, &auth, "", "")){
    Serial.println("ok");
    signupOK = true;
  }
  else{
    Serial.printf("%s\n", config.signer.signupError.message.c_str());
  }

  /* Assign the callback function for the long running token generation task */
  config.token_status_callback = tokenStatusCallback; //see addons/TokenHelper.h
  
  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);

  Serial.begin(115200);
  dht.begin();
  Wire.begin();
  lightMeter.begin();
  Serial.println(F("BH1750 Test begin"));

 //baca ph sensor in value:
  sensorValue = analogRead(PHPin);
 delay(500);
 //rumus Ph sensor 
  outputValue = (-0.0139*sensorValue)+7.7851;
  Serial.println(F("BH1750 Test begin"));

  // Inisialisasi RTC
  if (!rtc.begin()) {
    Serial.println("Couldn't find RTC");
    while (1);
  }

  if (rtc.lostPower()) {
    Serial.println("RTC lost power, let's set the time!");
    rtc.adjust(DateTime(F(__DATE__), F(__TIME__)));
  }

  // Konfigurasi pin relay sebagai OUTPUT
  pinMode(relayPin, OUTPUT);
  digitalWrite(relayPin, HIGH);  // Matikan relay awalnya

}



void loop() {
  Serial.println("Pilih opsi:");
  Serial.println("1. Mulai penyiraman");
  Serial.println("2. Tambahkan jadwal penyiraman");

  while (!Serial.available()) {
    // Tunggu hingga data tersedia di Serial Monitor
  }

  int selectedOption = Serial.parseInt();

  switch (selectedOption) {
    case 1:
      startIrrigation();
      break;
    case 2:
      addIrrigationSchedule();
      break;
    default:
      Serial.println("Opsi tidak valid");
      break;
  }
   // Read temperature and humidity from the DHT sensor
  float temperature = dht.readTemperature();
  float humidity = dht.readHumidity();

    // Suhu dan kelembapan ruangan
  Serial.print("Temperature: ");
  Serial.print(temperature);
  Serial.print(" °C\t");
  Serial.print("Humidity: ");
  Serial.print(humidity);
  Serial.println(" %");
  delay(2000); // Wait for 2 seconds before the next reading

    //Ph 
  Serial.print("adc= ");
  Serial.println(sensorValue);
  Serial.print("pH = ");
  Serial.println(outputValue);
  delay(2000);
    // Kelembapan tanah
  int nilaiPh = analogRead (soilPin);
  Serial.print ("kelembaban tanah = ");
  Serial.print(nilaiPh);

  if(nilaiPh > 700){
  Serial.println("  tanah kondisi kering");
  }else if(nilaiPh < 700 && nilaiPh > 350){
  Serial.println("  tanah kondisi normal");
  }else{
  Serial.println("  tanah kondisi basah");
  delay(2000);
  }
    //Cahaya
  float lux = lightMeter.readLightLevel();
  Serial.print("Light: ");
  Serial.print(lux);
  Serial.println(" lx");
  delay(2000);

  if (Firebase.ready() && signupOK && (millis() - sendDataPrevMillis > 15000 || sendDataPrevMillis == 0)){
    sendDataPrevMillis = millis();
    
    // suhu
    if (Firebase.RTDB.setInt(&fbdo, "suhu/int", temperature)){
      Serial.println("PASSED");
      Serial.println("PATH: " + fbdo.dataPath());
      Serial.println("TYPE: " + fbdo.dataType());
    }
    else {
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
    }
    // kelembapan ruangan
    if (Firebase.RTDB.setInt(&fbdo, "kelembapan_ruangan/int", humidity)){
      Serial.println("PASSED");
      Serial.println("PATH: " + fbdo.dataPath());
      Serial.println("TYPE: " + fbdo.dataType());
    }
    else {
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
    }
    // Adc 
    if (Firebase.RTDB.setInt(&fbdo, "adc/int", sensorValue)){
      Serial.println("PASSED");
      Serial.println("PATH: " + fbdo.dataPath());
      Serial.println("TYPE: " + fbdo.dataType());
    }
    else {
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
    }
    // Ph
    if (Firebase.RTDB.setInt(&fbdo, "ph/int", outputValue)){
      Serial.println("PASSED");
      Serial.println("PATH: " + fbdo.dataPath());
      Serial.println("TYPE: " + fbdo.dataType());
    }
    else {
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
  }
      // kelembapan tanah
    if (Firebase.RTDB.setInt(&fbdo, "kelembapan/int", nilaiPh)){
      Serial.println("PASSED");
      Serial.println("PATH: " + fbdo.dataPath());
      Serial.println("TYPE: " + fbdo.dataType());
    }
    else {
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
  }
        // penyiraman
    if (Firebase.RTDB.setBool(&fbdo, "switch/boolean", nilaiPh)){
      Serial.println("PASSED");
      Serial.println("PATH: " + fbdo.dataPath());
      Serial.println("TYPE: " + fbdo.dataType());
    }
    else {
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
  }      // cahaya
    if (Firebase.RTDB.setInt(&fbdo, "intensitas_cahaya/int", lux)){
      Serial.println("PASSED");
      Serial.println("PATH: " + fbdo.dataPath());
      Serial.println("TYPE: " + fbdo.dataType());
    }
    else {
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
  }
 }
}



   