const unsigned char txt1[]="LED 1 on = a   \n\f";
const unsigned char txt2[]="LED 1 off = b  \n\f";
const unsigned char txt3[]="sw1 = tecla c  \n\f";
const unsigned char txt5[]="led 1 = on     \n\f";
const unsigned char txt6[]="led 1 = off    \n\f";
const unsigned char txt7[]="Swirch cerrado \n\f";
const unsigned char txt8[]="switch abierto \n\f";

#define led1 portc.f0
#define on 1
#define off 0
#define sw1 porta.F0
char uart_rd;



void ver(const unsigned char txt[])
  {
   unsigned char i;
   for(i=0;i<15;i++)
  {
   uart1_write(txt[i]);
  }
  }

void main() {
  TXSTA.SYNC=0; // EUSART en Modo Asincrono

  ANSEL  = 0;                     // Configure AN pins as digital
  ANSELH = 0;
  C1ON_BIT=0;
  C2ON_BIT=0;
  TRISC=0xFF;
  PORTC=0x00;
  UART1_Init(9600);               // Initialize UART module at 9600 bps
  Delay_ms(100);                  // Wait for UART module to stabilize
  PIE1.RCIE=1; // Habilitacion de interrupcion por recepcion
  INTCON.PEIE=1; // Habilitacion de interrupcion por periferico
  INTCON.GIE=1; // Habilitacion Global de las interruopcciones


                      // Endless loop

    while (1) {                     // Endless loop
      UART1_Data_Ready();     // If data is received,
      UART1_Read();     // read the received data,



    ver (txt1);
    UART1_Write(10);
  UART1_Write(13);

    ver (txt2);
    UART1_Write(10);
  UART1_Write(13);

    ver (txt3);
    UART1_Write(10);
  UART1_Write(13);

    while(uart1_data_ready()==0);
     uart_rd = uart1_read();
     switch(uart_rd)
    {
        case 'a': led1=on; ver(txt5);break;
        case 'b': led1=off; ver(txt6);break;
        case 'c': if(sw1==on){
         ver (txt7);
        }
        else ver(txt8);
    }
     
    }
    }





