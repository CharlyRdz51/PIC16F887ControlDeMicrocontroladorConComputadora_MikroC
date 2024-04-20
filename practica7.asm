
_ver:

;practica7.c,17 :: 		void ver(const unsigned char txt[])
;practica7.c,20 :: 		for(i=0;i<15;i++)
	CLRF       ver_i_L0+0
L_ver0:
	MOVLW      15
	SUBWF      ver_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_ver1
;practica7.c,22 :: 		uart1_write(txt[i]);
	MOVF       ver_i_L0+0, 0
	ADDWF      FARG_ver_txt+0, 0
	MOVWF      R0+0
	MOVF       FARG_ver_txt+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;practica7.c,20 :: 		for(i=0;i<15;i++)
	INCF       ver_i_L0+0, 1
;practica7.c,23 :: 		}
	GOTO       L_ver0
L_ver1:
;practica7.c,24 :: 		}
L_end_ver:
	RETURN
; end of _ver

_main:

;practica7.c,26 :: 		void main() {
;practica7.c,27 :: 		TXSTA.SYNC=0; // EUSART en Modo Asincrono
	BCF        TXSTA+0, 4
;practica7.c,29 :: 		ANSEL  = 0;                     // Configure AN pins as digital
	CLRF       ANSEL+0
;practica7.c,30 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;practica7.c,31 :: 		C1ON_BIT=0;
	BCF        C1ON_bit+0, BitPos(C1ON_bit+0)
;practica7.c,32 :: 		C2ON_BIT=0;
	BCF        C2ON_bit+0, BitPos(C2ON_bit+0)
;practica7.c,33 :: 		TRISC=0xFF;
	MOVLW      255
	MOVWF      TRISC+0
;practica7.c,34 :: 		PORTC=0x00;
	CLRF       PORTC+0
;practica7.c,35 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;practica7.c,36 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	DECFSZ     R11+0, 1
	GOTO       L_main3
	NOP
;practica7.c,37 :: 		PIE1.RCIE=1; // Habilitacion de interrupcion por recepcion
	BSF        PIE1+0, 5
;practica7.c,38 :: 		INTCON.PEIE=1; // Habilitacion de interrupcion por periferico
	BSF        INTCON+0, 6
;practica7.c,39 :: 		INTCON.GIE=1; // Habilitacion Global de las interruopcciones
	BSF        INTCON+0, 7
;practica7.c,44 :: 		while (1) {                     // Endless loop
L_main4:
;practica7.c,45 :: 		UART1_Data_Ready();     // If data is received,
	CALL       _UART1_Data_Ready+0
;practica7.c,46 :: 		UART1_Read();     // read the received data,
	CALL       _UART1_Read+0
;practica7.c,50 :: 		ver (txt1);
	MOVLW      _txt1+0
	MOVWF      FARG_ver_txt+0
	MOVLW      hi_addr(_txt1+0)
	MOVWF      FARG_ver_txt+1
	CALL       _ver+0
;practica7.c,51 :: 		UART1_Write(10);
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;practica7.c,52 :: 		UART1_Write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;practica7.c,54 :: 		ver (txt2);
	MOVLW      _txt2+0
	MOVWF      FARG_ver_txt+0
	MOVLW      hi_addr(_txt2+0)
	MOVWF      FARG_ver_txt+1
	CALL       _ver+0
;practica7.c,55 :: 		UART1_Write(10);
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;practica7.c,56 :: 		UART1_Write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;practica7.c,58 :: 		ver (txt3);
	MOVLW      _txt3+0
	MOVWF      FARG_ver_txt+0
	MOVLW      hi_addr(_txt3+0)
	MOVWF      FARG_ver_txt+1
	CALL       _ver+0
;practica7.c,59 :: 		UART1_Write(10);
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;practica7.c,60 :: 		UART1_Write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;practica7.c,62 :: 		while(uart1_data_ready()==0);
L_main6:
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main7
	GOTO       L_main6
L_main7:
;practica7.c,63 :: 		uart_rd = uart1_read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _uart_rd+0
;practica7.c,64 :: 		switch(uart_rd)
	GOTO       L_main8
;practica7.c,66 :: 		case 'a': led1=on; ver(txt5);break;
L_main10:
	BSF        PORTC+0, 0
	MOVLW      _txt5+0
	MOVWF      FARG_ver_txt+0
	MOVLW      hi_addr(_txt5+0)
	MOVWF      FARG_ver_txt+1
	CALL       _ver+0
	GOTO       L_main9
;practica7.c,67 :: 		case 'b': led1=off; ver(txt6);break;
L_main11:
	BCF        PORTC+0, 0
	MOVLW      _txt6+0
	MOVWF      FARG_ver_txt+0
	MOVLW      hi_addr(_txt6+0)
	MOVWF      FARG_ver_txt+1
	CALL       _ver+0
	GOTO       L_main9
;practica7.c,68 :: 		case 'c': if(sw1==on){
L_main12:
	BTFSS      PORTA+0, 0
	GOTO       L_main13
;practica7.c,69 :: 		ver (txt7);
	MOVLW      _txt7+0
	MOVWF      FARG_ver_txt+0
	MOVLW      hi_addr(_txt7+0)
	MOVWF      FARG_ver_txt+1
	CALL       _ver+0
;practica7.c,70 :: 		}
	GOTO       L_main14
L_main13:
;practica7.c,71 :: 		else ver(txt8);
	MOVLW      _txt8+0
	MOVWF      FARG_ver_txt+0
	MOVLW      hi_addr(_txt8+0)
	MOVWF      FARG_ver_txt+1
	CALL       _ver+0
L_main14:
;practica7.c,72 :: 		}
	GOTO       L_main9
L_main8:
	MOVF       _uart_rd+0, 0
	XORLW      97
	BTFSC      STATUS+0, 2
	GOTO       L_main10
	MOVF       _uart_rd+0, 0
	XORLW      98
	BTFSC      STATUS+0, 2
	GOTO       L_main11
	MOVF       _uart_rd+0, 0
	XORLW      99
	BTFSC      STATUS+0, 2
	GOTO       L_main12
L_main9:
;practica7.c,74 :: 		}
	GOTO       L_main4
;practica7.c,75 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
