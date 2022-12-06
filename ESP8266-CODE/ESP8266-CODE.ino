#include <Arduino.h>
#include <ESP8266WiFi.h>
#include <WiFiClient.h> 
#include <ESP8266WebServer.h>
#include <ArduinoJson.h>

const char* ssid = "SMARTHOME";
const char *password = "123456789";
ESP8266WebServer server(80);


String unoData = "";
int ip_flag = 0;
int ultra_state = 1;
String ip_str;
String req;
String previousRequest;

void setup() {
  Serial.begin(115200); 

  // Connecting WiFi
  WiFi.mode(WIFI_AP);
  WiFi.softAP(ssid);
 // Starting WEB-server 
  server.on ( "/", HTTP_handleRoot );
  server.onNotFound ( HTTP_handleRoot );
  server.begin();  
  delay(2000);
}

void loop() {

    server.handleClient();
    req = server.arg("State");
    
    if(previousRequest != req){
      
      if(req == "fan_1")
      {
        Serial.write('F');
        previousRequest = req;
        String response = buildResponse("turn on the fan");  
        server.send ( 200, "text/html", response );
      }
      else if(req == "fan_0")
      {
        Serial.write('f');
        previousRequest = req;
        String response = buildResponse("turn off the fan");  
        server.send ( 200, "text/html", response );
      }
  
      
      else if(req == "door_1")
      {
        Serial.write('D');
        previousRequest = req;
        String response = buildResponse("door opened");  
        server.send ( 200, "text/html", response );
      }
      else if(req == "door_0")
      {
        Serial.write('d');
        previousRequest = req;
        String response = buildResponse("door closed");  
        server.send ( 200, "text/html", response );
      }
  
      
      else if(req == "alarm_1")
      {
        Serial.write('A');
        previousRequest = req;
        String response = buildResponse("alarm enabled");  
        server.send ( 200, "text/html", response );
      }
      else if(req == "alarm_0")
      {
        Serial.write('a');
        previousRequest = req;
        String response = buildResponse("alarm disabled");  
        server.send ( 200, "text/html", response );
      }
  
      
      else if(req == "motion_1")
      {
        Serial.write('M');
        previousRequest = req;
        String response = buildResponse("motion enabled");  
        while(Serial.available() > 0)
        {
          unoData = Serial.readStringUntil('#');
          String response = buildResponse(unoData);  
          server.send ( 200, "text/html", response );
        }
      }
      else if(req == "motion_0")
      {
        Serial.write('m');
        previousRequest = req;
        String response = buildResponse("motion disabled");  
        server.send ( 200, "text/html", response );
      }

    
      else if(req == "temperature_1")
      {
        Serial.write('T');
        previousRequest = req;
        String response = buildResponse("temperature enabled");  
        while(Serial.available() > 0)
        {
  
          unoData = Serial.readStringUntil('#');
          String response = buildResponse(unoData);  
          server.send ( 200, "text/html", response );
        }
      }
      else if(req == "temperature_0")
      {
        Serial.write('t');
        previousRequest = req;
        String response = buildResponse("temperature disabled");  
        server.send ( 200, "text/html", response );
      }

       else if(req == "ultrasonic_0")
      {
        Serial.write('u');
        previousRequest = req;
        String response = buildResponse("motion disabled");  
        server.send ( 200, "text/html", response );
      }
      else if(req == "ultrasonic_1")
      {
        Serial.write('U');
        while(Serial.available() > 0)
        {
          unoData = Serial.readStringUntil('#');
          String response = buildResponse(unoData);  
          server.send ( 200, "text/html", response );
        }
      }
     

      else if(req == "humidity_1")
      {
          Serial.write('H');
          previousRequest = req;
          while(Serial.available() > 0)
          {
            unoData = Serial.readStringUntil('#');
            String response = buildResponse(unoData);  
            server.send ( 200, "text/html", response );
          }
      }
      else if(req == "humidity_0")
      {
        Serial.write('h');
        previousRequest = req;
        String response = buildResponse("humidity disabled");  
        server.send ( 200, "text/html", response );
      }
      
    

      else if(req == "lamp1_1")
      {
        Serial.write('L');
        previousRequest = req;
        String response = buildResponse("motion disabled");  
        server.send ( 200, "text/html", response );
      }
      else if(req == "lamp1_0")
      {
        Serial.write('l');
        previousRequest = req;
        String response = buildResponse("lamp disabled");  
        server.send ( 200, "text/html", response );
      }

      else if(req == "lamp2_1")
      {
        Serial.write('Z');
        previousRequest = req;
        String response = buildResponse("motion disabled");  
        server.send ( 200, "text/html", response );
      }
      else if(req == "lamp2_0")
      {
        Serial.write('z');
        previousRequest = req;
        String response = buildResponse("lamp disabled");  
        server.send ( 200, "text/html", response );
      }

      else if(req == "lamp3_1")
      {
        Serial.write('X');
        previousRequest = req;
        String response = buildResponse("motion disabled");  
        server.send ( 200, "text/html", response );
      }
      else if(req == "lamp3_0")
      {
        Serial.write('x');
        previousRequest = req;
        String response = buildResponse("lamp disabled");  
        server.send ( 200, "text/html", response );
      }

      else if(req == "lamp4_1")
      {
        Serial.write('C');
        previousRequest = req;
        String response = buildResponse("motion disabled");  
        server.send ( 200, "text/html", response );
      }
      else if(req == "lamp4_0")
      {
        Serial.write('c');
        previousRequest = req;
        String response = buildResponse("lamp disabled");  
        server.send ( 200, "text/html", response );
      }

      else if(req == "lamp5_1")
      {
        Serial.write('V');
        previousRequest = req;
        String response = buildResponse("motion disabled");  
        server.send ( 200, "text/html", response );
      }
      else if(req == "lamp5_0")
      {
        Serial.write('v');
        previousRequest = req;
        String response = buildResponse("lamp disabled");  
        server.send ( 200, "text/html", response );
      }

      else if(req == "lamp6_1")
      {
        Serial.write('B');
        previousRequest = req;
        String response = buildResponse("motion disabled");  
        server.send ( 200, "text/html", response );
      }
      else if(req == "lamp6_0")
      {
        Serial.write('b');
        previousRequest = req;
        String response = buildResponse("lamp disabled");  
        server.send ( 200, "text/html", response );
      }

      else if(req == "lamp7_1")
      {
        Serial.write('N');
        previousRequest = req;
        String response = buildResponse("motion disabled");  
        server.send ( 200, "text/html", response );
      }
      else if(req == "lamp7_0")
      {
        Serial.write('n');
        previousRequest = req;
        String response = buildResponse("lamp disabled");  
        server.send ( 200, "text/html", response );
      }

      else if(req == "lamp8_1")
      {
        Serial.write('Q');
        previousRequest = req;
        String response = buildResponse("motion disabled");  
        server.send ( 200, "text/html", response );
      }
      else if(req == "lamp8_0")
      {
        Serial.write('q');
        previousRequest = req;
        String response = buildResponse("lamp disabled");  
        server.send ( 200, "text/html", response );
      }

      else if(req == "lamp9_1")
      {
        Serial.write('W');
        previousRequest = req;
        String response = buildResponse("motion disabled");  
        server.send ( 200, "text/html", response );
      }
      else if(req == "lamp9_0")
      {
        Serial.write('w');
        previousRequest = req;
        String response = buildResponse("lamp disabled");  
        server.send ( 200, "text/html", response );
      }
      
  
      else {
  
      }
    }
}

void HTTP_handleRoot(void) {

  if( server.hasArg("State") ){
       //Serial.println(server.arg("State"));
  }
  else{
      Serial.write("*");
      StaticJsonDocument<64> doc;
      doc["ip_address"] = WiFi.softAPIP();
      doc["status"] = true;
      String responseJson ="";
      serializeJson(doc, responseJson);
      String response = buildResponse(responseJson);  
      server.send ( 200, "text/json", response );
  }
  delay(1);
}

String buildResponse(String response){
   return response;
}
