#include <dht.h>
#include<string.h>
#include <LiquidCrystal.h> 

//byte buff[2];
int pin = 8;//DSM501A input D8
# define RELAY1 10
# define RELAY2 11
# define RELAY3 12
float duration;
float starttime;
float endtime;
float sampletime_ms = 3000;
float lowpulseoccupancy = 0;
float ratio = 0;
float concentration = 0;

int i=0;
int flag = 0;

#define dataPin 9 // Defines pin number to which the sensor is connected
dht DHT; // Creats a DHT object

LiquidCrystal lcd(1, 2, 4, 5, 6, 7);

struct Trend{
  float data[6]={0,0,0,0,0,0};
  float data1=0;
  float data2=0;
  float data3=0;
  float data4=0;
  float data5=0;
  float data6=0;

  float gap[5];
  float gap1 = data2 - data1;
  float gap2 = data3 - data2;
  float gap3 = data4 - data3;
  float gap4 = data5 - data4;
  float gap5 = data6 - data5;

  int up_count = 0;
  int down_count = 0;
  int stable_count = 0;
  }trend;


void setup() {
  lcd.begin(16,2); // Initializes the interface to the LCD screen, and specifies the dimensions (width and height) of the display
  Serial.begin(9600);
  pinMode(8,INPUT);
 // pinMode(RELAY1,OUTPUT);
 // pinMode(RELAY2,OUTPUT);
 // pinMode(RELAY3,OUTPUT);

  starttime = millis(); 
  
}
void loop() {
  //digitalWrite(RELAY1,LOW);
  //digitalWrite(RELAY2,LOW);
  //digitalWrite(RELAY3,LOW);

  duration = pulseIn(pin, LOW);
  lowpulseoccupancy += duration;
  endtime = millis();

  if ((endtime-starttime) > sampletime_ms)
  {
  int readData = DHT.read22(dataPin); // Reads the data from the sensor
  float plot[3];
  float t = DHT.temperature; // Gets the values of the temperature
  plot[0] = t;
  float h = DHT.humidity; // Gets the values of the humidity
  plot[1] = h;
  
    if (trend.data[0] == 0)
    trend.data[0] = h;
    else if(trend.data[1] == 0)
    trend.data[1] = h;
    else if (trend.data[2] == 0)
    trend.data[2] = h;
    else if (trend.data[3] == 0)
    trend.data[3] = h;
    else if (trend.data[4] == 0)
    trend.data[4] = h;
    else if (trend.data[5] == 0){
    trend.data[5] = h;
  for (i=0; i<5 ; i++){
    trend.gap[i] = trend.data[i+1] - trend.data[i];
    if (trend.gap[i] > 0.1)
      trend.up_count++;
    else if (trend.gap[i] < -0.1)
      trend.down_count++;
    else
      trend.stable_count++;
      }
  if (trend.up_count >=  trend.down_count){
    if (trend.up_count > trend.stable_count)
    flag = 1;
    else
    flag = 0;
    } else if (trend.up_count <  trend.down_count)
    if (trend.down_count > trend.stable_count)
    flag = -1;
    else
    flag = 0;
    }  
    
    else if (trend.data[5]!= 0){
      for (i=0;i<6;i++)
      trend.data[i] = 0;

       trend.up_count=0;
       trend.down_count=0;
       trend.stable_count=0;

      }
      /*
    Serial.println(trend.data[0]);
    Serial.println(trend.data[1]);
    Serial.println(trend.data[2]);
    Serial.println(trend.data[3]);
    Serial.println(trend.data[4]);
    Serial.println(trend.data[5]);
    
     Serial.println("gaps:");
     Serial.println(trend.gap[0]);
     Serial.println(trend.gap[1]);
     Serial.println(trend.gap[2]);
     Serial.println(trend.gap[3]);
     Serial.println(trend.gap[4]);
     Serial.println("counts:");
     Serial.println(trend.up_count);
     Serial.println(trend.down_count);
     Serial.println(trend.stable_count);

    Serial.println("\n");

*/
    /*
    Serial.print("duration:");
    Serial.print(duration);
    Serial.print("\n");
    Serial.print("lowpulseoccupancy:");
    Serial.print(lowpulseoccupancy);
    Serial.print("\n");
    */
    ratio = (lowpulseoccupancy-endtime+starttime + sampletime_ms)/(sampletime_ms*10.0);  // Integer percentage 0=>100
    plot[2] = ratio;
    Serial.println(plot[0]);
    Serial.println(plot[1]);
    Serial.println(plot[2]);

    
    concentration = 1.1*pow(ratio,3)-3.8*pow(ratio,2)+520*ratio+0.62; // using spec sheet curve
   // Serial.print("Dust Ratio:");
  //  Serial.print(ratio);
   lcd.setCursor(0,0);
    lcd.print("Ratio:");
    lcd.print(ratio);
   // delay(2000);
   // Serial.print("\n");
    //Serial.print("DSM501A:");
    //Serial.println(concentration);
   // Serial.print("\n");

    lowpulseoccupancy = 0;
    starttime = millis();
  lcd.setCursor(0,1);
  lcd.print("T:"); // Prints string "Temp." on the LCD
  lcd.print(t,0); // Prints the temperature value from the sensor
  lcd.print("C");
 
  
  lcd.print(" H:");
  lcd.print(h,0);
  lcd.print("%");
  if (flag == -1){
    lcd.print("<<");
   // Serial.println("<<");
  }
  if (flag == 0){
    lcd.print("==");
    //Serial.println("==");
  }
  if (flag == 1){
    lcd.print(">>");
    //Serial.println(">>");
  } 
    }

  }
