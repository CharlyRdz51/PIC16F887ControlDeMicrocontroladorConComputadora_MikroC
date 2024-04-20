#line 1 "C:/Users/user/Desktop/practica7/practica7.c"
const unsigned char txt1[]="LED 1 on = a   \n\f";
const unsigned char txt2[]="LED 1 off = b  \n\f";
const unsigned char txt3[]="sw1 = tecla c  \n\f";
const unsigned char txt5[]="led 1 = on     \n\f";
const unsigned char txt6[]="led 1 = off    \n\f";
const unsigned char txt7[]="Swirch cerrado \n\f";
const unsigned char txt8[]="switch abierto \n\f";





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
 TXSTA.SYNC=0;

 ANSEL = 0;
 ANSELH = 0;
 C1ON_BIT=0;
 C2ON_BIT=0;
 TRISC=0xFF;
 PORTC=0x00;
 UART1_Init(9600);
 Delay_ms(100);
 PIE1.RCIE=1;
 INTCON.PEIE=1;
 INTCON.GIE=1;




 while (1) {
 UART1_Data_Ready();
 UART1_Read();



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
 case 'a':  portc.f0 = 1 ; ver(txt5);break;
 case 'b':  portc.f0 = 0 ; ver(txt6);break;
 case 'c': if( porta.F0 == 1 ){
 ver (txt7);
 }
 else ver(txt8);
 }

 }
 }
