// GPIO and baud
#define TRIG_PIN  13
#define ECHO_PIN  12
#define BAUD_RATE 115200

#define distance_conversion 29

#define WIFI_SSID "josiasmequetrefe"
#define WIFI_PASSWORD "cartomante3d"

#include "../../include/common/hal.h"
#include "../../include/bm/firebase_defs.h"
#include "../../include/common/definitions.h"

FirebaseData fb;
FirebaseAuth auth;
FirebaseConfig config;

static uint16_t duration;
static uint16_t distance;
static uint16_t sendDataPrevMillis;

static boolean signupOK = FALSE;

void Delay(uint8_t time){
  delayMicroseconds(time*MICRO_2_SECOND);
}

void SetWifi(){
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("\nConnecting to Wi-Fi\n");
  while (WiFi.status() != WL_CONNECTED){
    Serial.print(".");
    Delay(3);
  }
}

void SetFirebase(){
  SetWifi();
  config.api_key = API_KEY.c_str();
  config.database_url = DATABASE_URL.c_str();

  if (Firebase.signUp(&config, &auth, "", "")){
    Serial.println("\nOk, firebase configured");
    signupOK = TRUE;
  }
  else{
    Serial.printf("%s\n", config.signer.signupError.message.c_str());
  }
  /* callback para a função geradora de tokens */
  config.token_status_callback = tokenStatusCallback;
  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);
  Serial.println("\nFirebase is on");
}

void TriggerSensor(){
    delayMicroseconds(2);
    digitalWrite(TRIG_PIN, HIGH);
    delayMicroseconds(10);
    digitalWrite(TRIG_PIN, LOW);
}

boolean ParkingSpace(){
    TriggerSensor();    
    duration = pulseIn(ECHO_PIN, HIGH);
    distance = duration/distance_conversion;
    Serial.print("\nDistance: ");
    Serial.print(distance);
    if(duration==0){
        Serial.println("\nWarning: no pulse from sensor");
        return (false);
        } 
    else
        return (distance <= PARKED_DISTANCE_CM);
}

boolean FirebaseUp()
{
  boolean response = (Firebase.ready() && signupOK && (millis() - sendDataPrevMillis > 1500 || sendDataPrevMillis == 0));
  return (Firebase.ready() && signupOK && (millis() - sendDataPrevMillis > 1500 || sendDataPrevMillis == 0));
}

void FirebaseUpdate(){
  Firebase.RTDB.setBool(&fb, "counter", ParkingSpace());
}

void InitHal(){
    Serial.begin(BAUD_RATE);
    Serial.print("\nSetting wifi...");
    SetFirebase();
    pinMode(TRIG_PIN, OUTPUT);
    pinMode(ECHO_PIN, INPUT);
}
