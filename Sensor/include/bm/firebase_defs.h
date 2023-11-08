#include <Arduino.h>
#include <WiFi.h>

#include <Firebase_ESP_Client.h>
//Provide the token generation process info.
#include "addons/TokenHelper.h"
//Provide the RTDB payload printing info and other helper functions.
#include "addons/RTDBHelper.h"

extern std::string API_KEY = "AIzaSyB2X-tl75TrWjCySBZiv1ltUNymzmO0xKs";
extern std::string DATABASE_URL = "https://tem-vaga-b56e8-default-rtdb.firebaseio.com/";
