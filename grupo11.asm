; *********************************************************************************
; * Modulo:    
; * Descrição: 
; *********************************************************************************

; *********************************************************************************
; * Constantes
; *********************************************************************************

COMANDOS			EQU	6000H		    ; endereço de base dos comandos do 
                                        ; MediaCenter
DEFINE_LINHA    EQU COMANDOS + 0AH		; endereço do comando para definir a 
										; linha
DEFINE_COLUNA   EQU COMANDOS + 0CH		; endereço do comando para definir a 
										; coluna
DEFINE_PIXEL    EQU COMANDOS + 12H		; endereço do comando para escrever um
										; pixel
APAGA_AVISO     EQU COMANDOS + 40H		; endereço do comando para apagar o 
										; aviso de nenhum cenário selecionado
APAGA_ECRA	 		EQU COMANDOS + 02H	; endereço para apagar todos os pixels
SELECIONA_CENARIO	EQU COMANDOS + 42H	; endereço para selecionar fundo
DISPLAYS   EQU 0A000H                   ; endereço dos displays 
TEC_LIN    EQU 0C000H                   ; endereço das linhas do teclado
TEC_COL    EQU 0E000H                   ; endereço das colunas do teclado 
LINHA_TEC  EQU 1                        ; 1ª linha a testar (0001b)
MASCARA    EQU 0FH                      ; para isolar os bits de menor peso
DELAY      EQU 1000H                    ; valor associado às interrupções

; VALORES ASSOCIADOS AO TECLADO
TECLA EQU -1                            ; valor inicial do valor da tecla
ANTERIOR EQU -1                         ; valor inicial do valor da tecla anterior

; VALORES ASSOCIADOS AOS OBJETOS DO JOGO
RAPAZ 					EQU 0           ; 1ª opção de personagem
RAPARIGA				EQU 1           ; 2ª opção de personagem

LINHA_PERSONAGEM		EQU  21         ; linha inicial da personagem     	
COLUNA_PERSONAGEM		EQU  15         ; coluna inicial da pesonagem
LARGURA_PERSONAGEM		EQU	 20		    ; largura do desenho da personagem
ALTURA_PERSONAGEM		EQU  11			; altura do desenho da personagem

CINZENTO 		EQU 0                   ; 1ª cor possivel para a arma
BRANCO 			EQU 1                   ; 2ª cor possivel para a arma

LINHA_ARMA		EQU	27                  ; linha inicial da arma
COLUNA_ARMA		EQU	25                  ; coluna inicial da arma
LARGURA_ARMA	EQU	9                   ; largura do desenho da arma
ALTURA_ARMA		EQU	5                   ; altura do desenho da arma

LINHA_BOMBA_ESQ			EQU	 0          ; linha inicial da bomba à direita
COLUNA_BOMBA_ESQ		EQU	 2          ; coluna inicial da bomba à direita

LINHA_BOMBA_DIR			EQU	 0          ; linha inicial da bomba à esquerda
COLUNA_BOMBA_DIR		EQU	 58         ; coluna inicial da bomba à esquerda

LINHA_BOMBA_MEIO		EQU	 0          ; linha inicial da bomba no meio
COLUNA_BOMBA_MEIO		EQU	 30         ; coluna inicial da bomba no meio

LARGURA_BOMBA		 	EQU	 4          ; largura do desenho da bomba
ALTURA_BOMBA			EQU	 4          ; altura do desenho da bomba

LINHA_MISSIL		  	EQU  21 	    ; linha inicial do missil
COLUNA_MISSIL		 	EQU  33 	    ; coluna inicial do missil
LARGURA_MISSIL		 	EQU  1          ; largura do desenho do missil
ALTURA_MISSIL		 	EQU  1          ; altura do desenho do missil

NAO_MINERAVEL			EQU  0			; valor associado às bombas não mineraveis
MINERAVEL				EQU	 1			; valor associado às bombas mineraveis
; VALOREES ASSOCIADOS À DIREÇÃO DAS BOMBAS E MISSEIS
DIREITA 				EQU 0			
ESQUERDA				EQU 1
MEIO					EQU 2

; VALORES ASSOCIADOS AOS SONS
SOM_BOMBA			EQU 0               ; som quando a bomba se move 
SOM_PERSONAGEM			EQU 1               ; som quando muda personagem 
SOM_MISSIL			EQU 2               ; som quando o missil se move
REPRODUZ_SOM		EQU COMANDOS + 5AH	; endereço do comando para tocar um som

;VALORES POSSIVEIS PARA A VARIAVEL ESTADO_JOGO
JOGO_ACABADO		EQU 0               ; estado de quando o jogo ainda não começou
JOGO_EM_CURSO		EQU 1               ; estado enquanto o jogo está a decorrer
JOGO_PAUSADO		EQU 2               ; estado de quando o jogo está pausado

; *********************************************************************************
; * Zona de Dados
; *********************************************************************************
    PLACE		1000H	
    pilha:      STACK 100H              ; espaço reservado para a pilha 
    topo_pilha:                         ; (200H bytes)

tabela_interrupções:      
    WORD rot_int_arma                   ; interrupção 0 - relógio muda cor da arma
    WORD rot_int_1                      ; interrupção 1 
    WORD rot_int_2                      ; interrupção 2 
    WORD rot_int_3                      ; interrupção 3

palete:                                 ; valores de cores para o desenho de 
                                        ; objetos
	COR_PRETO           EQU 0F000H
	COR_CINZENTO		EQU	0F666H
	COR_VERMELHO		EQU	0FC40H 
	COR_CASTANHO        EQU 0FFEFH
	COR_LARANJA       	EQU 0FFA5H
	COR_BEGE	        EQU 0FFCBH
	COR_BRANCO			EQU 0FFFFH
	COR_AMARELO			EQU 0FFF0H
	COR_VERMELHO_CLARO	EQU 0FE66H
	COR_VERDE			EQU 0F0A0H

ESTADO_JOGO:
	WORD JOGO_ACABADO                   ; estado inicial do jogo (não começado)

DEF_TECLA:
	WORD TECLA 		                    ; valor associado à tecla atual
	WORD ANTERIOR 		                ; valor associado à tecla anterior

POS_PERSONAGEM:                         ; variavel que armazena a posição atual
                                        ; da personagem
	WORD LINHA_PERSONAGEM               ; valor da linha atual da personagem
	WORD COLUNA_PERSONAGEM              ; valor da coluna atual da personagem

POS_BOMBA_1:                            ; variavel que armazena a posição atual
                                        ; da bomba 1
	WORD LINHA_BOMBA_ESQ	            ; valor da linha atual da bomba
	WORD COLUNA_BOMBA_ESQ	            ; valor da coluna atual da bomba
	WORD DIREITA						; valor inicial da direção da bomba 1
	WORD NAO_MINERAVEL

POS_BOMBA_2:                            ; variavel que armazena a posição atual
                                        ; da bomba 2
	WORD LINHA_BOMBA_MEIO	            ; valor da linha atual da bomba
	WORD COLUNA_BOMBA_MEIO	            ; valor da coluna atual da bomba
	WORD ESQUERDA						; valor inicial da direção da bomba 2
	WORD NAO_MINERAVEL

POS_BOMBA_3:                            ; variavel que armazena a posição atual
                                        ; da bomba 3
	WORD LINHA_BOMBA_MEIO	            ; valor da linha atual da bomba
	WORD COLUNA_BOMBA_MEIO	            ; valor da coluna atual da bomba
	WORD DIREITA						; valor inicial da direção da bomba 3
	WORD MINERAVEL


POS_BOMBA_4:                            ; variavel que armazena a posição atual
                                        ; da bomba 3
	WORD LINHA_BOMBA_DIR	            ; valor da linha atual da bomba
	WORD COLUNA_BOMBA_DIR	            ; valor da coluna atual da bomba
	WORD ESQUERDA						; valor inicial da direção da bomba 3
	WORD NAO_MINERAVEL

POS_MISSIL_1:                           ; variavel que armazena a posição atual
                                        ; do missil
	WORD LINHA_MISSIL  		            ; valor da linha atual do missil
	WORD COLUNA_MISSIL	                ; valor da coluna atual do missil
	WORD -1								; valor associado à direção do missil

POS_MISSIL_2:                           ; variavel que armazena a posição atual
                                        ; do missil
	WORD LINHA_MISSIL	                ; valor da linha atual do missil
	WORD COLUNA_MISSIL	                ; valor da coluna atual do missil
	WORD -1								; valor associado à direção do missil

POS_MISSIL_3:                           ; variavel que armazena a posição atual
                                        ; do missil
	WORD LINHA_MISSIL	                ; valor da linha atual do missil
	WORD COLUNA_MISSIL	                ; valor da coluna atual do missil
	WORD -1								; valor associado à direção do missil

POS_ARMA:
	WORD LINHA_ARMA
	WORD COLUNA_ARMA

ESTADO_PERSONAGEM:                      ; variavel que armazena qual das
                                        ; personagens foi selecionada para o jogo
	WORD RAPAZ 			                ; valor da personagem atual

ENERGIA_BONECO:                         ; valor associado à energia (display)
	WORD 0         	 	                ; valor atual da energia

INT_ENERGIA:                            ; variável que indica se se tem de
                                        ; diminuir a energia da nave
	WORD 0                              ; 1 - sim, 0 - não

INT_BOMBAS:								; variável que indica se se tem de
                                        ; mover as bombas
	WORD 0                              ; 1 - sim, 0 - não
COR_ARMA:                               ; variavel que armazena qual a cor atual 
                                        ; da arma
	WORD CINZENTO                       

; *********************************************************************************
; * Desenhos dos objectos
; *********************************************************************************
DEF_RAPAZ:		                        ; desenho da 1ª opção de personagem 11x20
	WORD 		LARGURA_PERSONAGEM
	WORD		ALTURA_PERSONAGEM
	WORD		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, COR_PRETO, 0, 
				COR_PRETO, 0, 0, 0, COR_PRETO, COR_PRETO, COR_PRETO, COR_PRETO, 
				COR_PRETO, COR_PRETO, 0, 0, 0, 0, 0, 0, 0, 0, 0, COR_PRETO, 0, 0, 
				0, COR_PRETO, COR_CASTANHO, COR_CASTANHO, COR_CASTANHO, COR_PRETO, 
				COR_CASTANHO, COR_CASTANHO, COR_PRETO, COR_PRETO, COR_PRETO, 0, 0, 
				0, 0, 0, COR_PRETO, 0, 0, 0, COR_PRETO, COR_CASTANHO, 
				COR_CASTANHO, COR_CASTANHO, COR_PRETO, COR_CASTANHO, COR_CASTANHO,
				COR_PRETO, COR_CASTANHO, COR_CASTANHO, COR_PRETO, 0, 0, 0, 0, 
				COR_PRETO, COR_PRETO, 0 , 0, 0, COR_PRETO, COR_CASTANHO, 
				COR_CASTANHO, COR_CASTANHO, COR_CASTANHO, COR_CASTANHO, 
				COR_CASTANHO, COR_CASTANHO, COR_CASTANHO, COR_PRETO, 0, 0, 0, 0, 
				COR_PRETO, COR_CASTANHO, COR_PRETO, 0, 0, 0, COR_PRETO, 
				COR_CASTANHO, COR_CASTANHO, COR_BEGE, COR_BEGE, COR_BEGE, COR_BEGE,
				COR_BEGE, COR_CASTANHO, COR_PRETO, 0, 0, 0, COR_PRETO, 
				COR_CASTANHO, COR_PRETO, COR_BEGE, COR_PRETO, 0, 0, COR_PRETO, 
				COR_CASTANHO, COR_CASTANHO, COR_BEGE, COR_BEGE, COR_BEGE, COR_BEGE,
				COR_BEGE, COR_BEGE, COR_PRETO, 0, 0, COR_PRETO, COR_CINZENTO, 
				COR_PRETO, COR_PRETO, COR_PRETO, 0, 0, 0, COR_PRETO, COR_BEGE, 
				COR_CASTANHO, COR_BEGE, COR_PRETO, COR_BEGE, COR_BEGE, COR_PRETO, 
				COR_BEGE, COR_PRETO, 0, COR_PRETO, COR_CINZENTO, COR_CINZENTO, 
				COR_PRETO, COR_CINZENTO, COR_PRETO, COR_PRETO, COR_PRETO, 0, 
				COR_PRETO, COR_BEGE, COR_BEGE, COR_BEGE, COR_PRETO, COR_BEGE, 
				COR_BEGE, COR_PRETO, COR_BEGE, COR_PRETO, COR_PRETO, COR_CINZENTO, 
				COR_CINZENTO, COR_PRETO, COR_BEGE, COR_PRETO, COR_CINZENTO, 
				COR_CINZENTO, COR_PRETO, COR_PRETO, COR_PRETO, COR_PRETO, COR_BEGE,
				COR_BEGE, COR_BEGE, COR_BEGE, COR_BEGE, COR_BEGE, COR_BEGE, 
				COR_PRETO, COR_CINZENTO, COR_CINZENTO, COR_PRETO, COR_PRETO,
				COR_PRETO, 0, COR_PRETO, COR_PRETO, COR_PRETO, COR_PRETO, 
				COR_VERMELHO, COR_PRETO, COR_PRETO, COR_PRETO, COR_VERMELHO, 
				COR_VERMELHO, COR_VERMELHO, COR_PRETO, COR_PRETO, COR_CINZENTO, 
				COR_CINZENTO, COR_PRETO, COR_BEGE, COR_BEGE, COR_PRETO, 0, 0, 0, 0

DEF_RAPARIGA:                           ; desenho da 2ª opção de personagem 11x20
	WORD        LARGURA_PERSONAGEM
	WORD        ALTURA_PERSONAGEM
	WORD        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, COR_PRETO, 0, 
                COR_PRETO, 0, 0, COR_PRETO, COR_PRETO, COR_PRETO, COR_PRETO, 
                COR_PRETO, COR_PRETO, COR_PRETO, COR_PRETO, 0, 0, 0, 0, 0, 0, 0, 0,
                COR_PRETO, 0, 0, COR_PRETO, COR_VERMELHO, COR_VERMELHO, 
                COR_VERMELHO, COR_VERMELHO_CLARO, COR_VERMELHO_CLARO, 
                COR_VERMELHO_CLARO, COR_VERMELHO, COR_VERMELHO, COR_PRETO, 
                COR_PRETO, 0, 0, 0, 0, 0, COR_PRETO, 0, 0, COR_PRETO, COR_VERMELHO,
                COR_VERMELHO_CLARO, COR_VERMELHO, COR_VERMELHO_CLARO, 
                COR_VERMELHO_CLARO, COR_VERMELHO_CLARO, COR_VERMELHO_CLARO, 
                COR_VERMELHO_CLARO, COR_VERMELHO_CLARO, COR_VERMELHO_CLARO, 
                COR_PRETO, 0, 0, 0, 0, COR_PRETO, COR_PRETO, 0, 0, COR_PRETO, 
                COR_VERMELHO, COR_VERMELHO, COR_VERMELHO_CLARO, COR_VERMELHO_CLARO,
                COR_VERMELHO_CLARO, COR_VERMELHO_CLARO, COR_VERMELHO, 
                COR_VERMELHO_CLARO, COR_VERMELHO_CLARO, COR_PRETO, 0, 0, 0, 0, 
                COR_PRETO, COR_BRANCO, COR_PRETO, 0, 0, COR_PRETO, COR_VERMELHO, 
                COR_VERMELHO, COR_VERMELHO, COR_VERMELHO_CLARO, COR_VERMELHO_CLARO, 
                COR_VERMELHO, COR_BEGE, COR_VERMELHO, COR_VERMELHO_CLARO, 
                COR_VERMELHO, COR_PRETO, 0, 0, COR_PRETO, COR_BRANCO, COR_PRETO, 
                COR_BEGE, COR_PRETO, 0, COR_PRETO, COR_VERMELHO, COR_VERMELHO, 
                COR_VERMELHO, COR_VERMELHO, COR_VERMELHO, COR_VERMELHO, COR_BEGE, 
                COR_BEGE, COR_BEGE, COR_PRETO, COR_PRETO, 0, COR_PRETO, 
                COR_CINZENTO, COR_PRETO, COR_PRETO, COR_PRETO, 0, 0, COR_PRETO, 
                COR_VERMELHO, COR_BEGE, COR_VERMELHO, COR_VERMELHO, COR_PRETO, 
                COR_BEGE, COR_BEGE, COR_PRETO, COR_BEGE, COR_PRETO, COR_PRETO, 
                COR_PRETO, COR_CINZENTO, COR_CINZENTO, COR_PRETO, COR_CINZENTO, 
                COR_PRETO, COR_PRETO, COR_PRETO, COR_PRETO, COR_VERMELHO, COR_BEGE,
                COR_VERMELHO, COR_BEGE, COR_PRETO, COR_BEGE, COR_BEGE, COR_PRETO,
                COR_BEGE, COR_PRETO, COR_PRETO, COR_CINZENTO, COR_CINZENTO, 
                COR_PRETO, COR_BEGE, COR_PRETO, COR_CINZENTO, COR_CINZENTO, 
                COR_PRETO, 0, COR_PRETO, COR_PRETO, COR_BEGE, COR_BEGE, COR_BEGE, 
                COR_BEGE, COR_BEGE, COR_BEGE, COR_BEGE, COR_PRETO, COR_CINZENTO, 
                COR_CINZENTO, COR_PRETO, COR_PRETO, COR_PRETO, 0, COR_PRETO, 
                COR_PRETO, COR_PRETO, COR_PRETO, COR_VERMELHO_CLARO, COR_PRETO, 
                COR_PRETO, COR_PRETO, COR_VERMELHO_CLARO, COR_VERMELHO_CLARO, 
                COR_VERMELHO_CLARO, COR_PRETO, COR_PRETO, COR_CINZENTO, 
                COR_CINZENTO, COR_PRETO, COR_BEGE, COR_BEGE, COR_PRETO, 0, 0, 0, 0 

DEF_PERSONAGEM_APAGADA:                 ; desenho da personagem apagada 11x20
	WORD        LARGURA_PERSONAGEM
	WORD        ALTURA_PERSONAGEM
	WORD        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

DEF_BOMBA:                              ; desenho da bomba 4x4
	WORD 		LARGURA_BOMBA
	WORD		ALTURA_BOMBA
	WORD		0, COR_PRETO, COR_PRETO, 0, COR_PRETO, COR_VERMELHO, COR_BRANCO, 
				COR_VERMELHO, COR_PRETO, COR_BRANCO, COR_CINZENTO, COR_PRETO, 0, 
				COR_PRETO, COR_PRETO, 0

DEF_BOMBA_MINERAVEL:
	WORD 		LARGURA_BOMBA
	WORD		ALTURA_BOMBA
	WORD		0, COR_PRETO, COR_PRETO, 0, COR_PRETO, COR_VERDE, COR_BRANCO, 
				COR_VERDE, COR_PRETO, COR_BRANCO, COR_CINZENTO, COR_PRETO, 0, 
				COR_PRETO, COR_PRETO, 0

DEF_BOMBA_APAGADA:                      ; desenho da bomba apagada 4x4
	WORD 		LARGURA_BOMBA
	WORD		ALTURA_BOMBA
	WORD        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

DEF_MISSIL:                             ; desenho do missil 1x1
	WORD		LARGURA_MISSIL
	WORD		ALTURA_MISSIL
	WORD		COR_AMARELO

DEF_MISSIL_APAGADO:                     ; desenho do missil apagado 1x1
	WORD		LARGURA_MISSIL
	WORD		ALTURA_MISSIL
	WORD		0

DEF_ARMA_APAGADA:                       ; desenho da arma apagada 5x9
	WORD		LARGURA_ARMA
	WORD   		ALTURA_ARMA
	WORD		COR_PRETO, 0, 0, COR_PRETO, 0, COR_PRETO, COR_PRETO, COR_PRETO, 0,
				COR_PRETO, 0, COR_PRETO, 0, 0, COR_PRETO, 0, COR_PRETO, COR_PRETO,
				COR_PRETO, COR_PRETO, 0, 0, COR_PRETO, COR_BEGE, COR_PRETO, 0, 0,
				COR_PRETO, 0, 0, COR_PRETO, COR_PRETO, COR_PRETO, 0, COR_PRETO, 
                COR_PRETO, 0, 0, COR_PRETO, COR_BEGE, COR_BEGE, COR_PRETO, 0, 0, 0

DEF_ARMA_BRANCA:                        ; desenho da arma branca 5x9
	WORD		LARGURA_ARMA
	WORD   		ALTURA_ARMA
	WORD		COR_PRETO, 0, 0, COR_PRETO, COR_BRANCO, COR_PRETO, COR_PRETO, 
                COR_PRETO, 0, COR_PRETO, 0, COR_PRETO, COR_BRANCO, COR_BRANCO, 
                COR_PRETO, COR_BRANCO, COR_PRETO, COR_PRETO, COR_PRETO, COR_PRETO, 
                COR_BRANCO, COR_BRANCO, COR_PRETO, COR_BEGE, COR_PRETO, COR_BRANCO, 
                COR_BRANCO, COR_PRETO, COR_BRANCO, COR_BRANCO, COR_PRETO, 
                COR_PRETO, COR_PRETO, 0, COR_PRETO, COR_PRETO, COR_BRANCO, 
                COR_BRANCO, COR_PRETO, COR_BEGE, COR_BEGE, COR_PRETO, 0, 0, 0


DEF_ARMA_CINZENTA:                      ; desenho da arma cinzenta 5x9
	WORD		LARGURA_ARMA
	WORD   		ALTURA_ARMA
	WORD		COR_PRETO, 0, 0, COR_PRETO, COR_CINZENTO, COR_PRETO, COR_PRETO, COR_PRETO, 0,
				COR_PRETO, 0, COR_PRETO, COR_CINZENTO, COR_CINZENTO, COR_PRETO, COR_CINZENTO, 
                COR_PRETO, COR_PRETO, COR_PRETO, COR_PRETO, COR_CINZENTO, COR_CINZENTO, 
                COR_PRETO, COR_BEGE, COR_PRETO, COR_CINZENTO, COR_CINZENTO, COR_PRETO, 
                COR_CINZENTO, COR_CINZENTO, COR_PRETO, COR_PRETO, COR_PRETO, 0, COR_PRETO, 
                COR_PRETO, COR_CINZENTO, COR_CINZENTO, COR_PRETO, COR_BEGE, COR_BEGE, COR_PRETO, 
                0, 0, 0

; *********************************************************************************
; * Código
; *********************************************************************************
	PLACE   0							; o código começa em 0000H

inicio:
	MOV  SP, topo_pilha        			; inicializar o pointeiro de stack
    MOV  BTE, tabela_interrupções       ; inicializa BTE
    MOV  [APAGA_AVISO], R1				; apaga o aviso de nenhum cenário 
                                        ; selecionado 
    MOV  [APAGA_ECRA], R1				; apaga todos os pixels já desenhados 
	MOV	 R1, 1							; cenário de fundo número 0
    MOV  [SELECIONA_CENARIO], R1		; seleciona o cenário de fundo inicial	

    EI0                         ; permite interrupções 0
  	EI1                         ; permite interrupções 1
 	EI2                         ; permite interrupções 2
 	EI3                         ; permite interrupções 3
 	EI                          ; permite interrupções (geral)

CALL desenha_rapaz                      ; desenha personagem inicial (rapaz)

ciclo:
	CALL teclado                        ; verifica se alguma tecla foi carregada
	CALL chama_comando                  ; chama o comando consoante tecla teclada
	CALL move_bombas
	JMP ciclo

; *********************************************************************************
; chama_comando - Verifica se a tecla carregada corresponde a algum comando. Se 
;                 sim, chama a rotina adequada.
;
; Comandos:
; 0: descer bomba na sua diagonal direita
; 4: subir missil na sua diagonal esquerda
; 3: subir digito
; 7: descer digito
; C: começar jogo
; E: alterar personagem
; F: terminar jogo
; *********************************************************************************
chama_comando:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7
    MOV R0, [DEF_TECLA]                 ; obtem tecla carregada       
	MOV R2, [DEF_TECLA+2] 	            ; obtem tecla anterior à carregada
	CMP R2, R0 				            ; vê se é a mesma tecla
	JZ fim_chama_comando 	            ; se for, não chama nenhum comando
	
	MOV R3, [ESTADO_JOGO]               ; obtem estado do jogo
	MOV R4, JOGO_ACABADO                
	CMP R4, R3                          ; vê se o jogo está acabado 
	JZ comandos_jogo_acabado            ; se sim, verifica os comandos associados 
                                        ; a esse estado

	MOV R4, JOGO_EM_CURSO               
	CMP R3, R4                          ; vê se o jogo está em curso
	JZ comandos_decorrer_jogo           ; se sim, verifica os comandos associados 
                                        ; a esse estado

comandos_jogo_acabado:
	MOV R1, 12				            ; compara tecla primida com a tecla C
	CMP R1, R0 
    JNZ salto_1				       
	JMP comeca_jogo                     ; se forem iguais, começa o jogo
    salto_1:

	MOV R1, 14				            ; compara tecla primida com a tecla E
	CMP	R1, R0				            ; se forem iguais, muda a personagem
	JZ muda_personagem
	JMP fim_chama_comando

comandos_decorrer_jogo:
	MOV R1, 0
	CMP R1, R0							; compara a tecla com a tecla 0
	JNZ testa_missil_direita
	JMP atira_missil_esquerda			; se forem iguais, atira um missil
										; para a esquerda	            
 
 testa_missil_direita:
	MOV R1, 2
	CMP R1, R0							; compara a tecla com a tecla 0
	JNZ testa_move_misseis
	JMP atira_missil_direita			; se forem iguais, atira um missil
										; para a direita
testa_move_misseis:
    MOV R1, 4				            
	CMP R1, R0  			            ; compara tecla primida com a tecla 4 
	JNZ testa_missil_cima
	JMP move_misseis			        ; se forem iguais, move o missil

testa_missil_cima:
	MOV R1, 5
	CMP R1, R0							; compara a tecla com a tecla 0
	JNZ testa_aumenta_energia
	JMP atira_missil_cima				; se forem iguais, atira um missil
										; para cima
testa_aumenta_energia:
	MOV R1, 3
	CMP R1, R0                          ; compara tecla primida com a tecla 3   
	JNZ testa_reduz_energia
	JMP aumentar_energia                 ; se forem iguais, aumenta a energia

testa_reduz_energia:
	MOV R1, 7
	CMP R1, R0                          ; compara tecla primida com a tecla 7
	JNZ testa_acaba_jogo
	JMP reduzir_energia                  ; se forem iguais, diminui a energia

testa_acaba_jogo:
	MOV R1, 15  
	CMP R1, R0                          ; compara tecla primida com a tecla F
	JNZ fim_chama_comando 
	JMP acaba_jogo                      ; se forem iguais, acaba o jogo

fim_chama_comando:
	POP R7
	POP R6
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET

; ******************************************************************************
; rot_int_arma - Rotina da interrupção 0 (mudar cor da arma).
; ******************************************************************************
rot_int_arma:
    CALL muda_cor_arma
    RFE
    
; ******************************************************************************
; rot_int_1 - Rotina de atendimento da interrupção 1.
; ******************************************************************************
rot_int_1:
	CALL assinala_int_bombas
    RFE

; ******************************************************************************
; rot_int_2 - Rotina de atendimento da interrupção 2,
; ******************************************************************************
rot_int_2:
    RFE
    
; ******************************************************************************
; rot_int_3 - Rotina de atendimento da interrupção 3.
; ******************************************************************************
rot_int_3:
    RFE

; ******************************************************************************
; assinala_int_bombas - Assinala uma interrupção .
;
; Argumentos: R0 - Variável INT_BOMBAS que varia entre 0 e 1.
; ******************************************************************************

assinala_int_bombas:
	PUSH R0
    PUSH R1
    MOV  R0, INT_BOMBAS
    MOV  R1, 1                   ; assinala que houve uma interrupção
    MOV  [R0], R1
    POP  R1
    POP  R0
	RET

; ******************************************************************************
; reduzir_energia - Diminui um digito da energia (display).
; ******************************************************************************
reduzir_energia:
    PUSH R0
    PUSH R1
    MOV R0, INT_ENERGIA         
    MOV R1, ENERGIA_BONECO              ; obtem energia atual do boneco
    MOV R0, [R1]           
    CMP R0, 0                           ; verifica se a energia é igual a zero
    JZ sai_reduzir_energia              ; se for zero, sai sem decrementar a 
                                        ; energia
    SUB R0, 1                           ; decrementa a energia da nave
    CALL atualiza_energia               ; atualiza o valor na variável e nos 
                                        ; displays
    JMP sai_reduzir_energia

sai_reduzir_energia:
    POP  R1
    POP  R0
    JMP fim_chama_comando

; ******************************************************************************
; aumentar_energia - Aumenta um digito da energia (display).
; ******************************************************************************
aumentar_energia:
    PUSH R0
    PUSH R1
    MOV  R0, INT_ENERGIA
    MOV  R1, ENERGIA_BONECO             ; obtem energia atual do boneco
    MOV  R0, [R1]              
    ADD  R0, 1                          ; decrementa a energia da nave
    CALL atualiza_energia               ; atualiza o valor na variável e nos 
                                        ; displays
    CMP  R0, 0                          ; verifica se a energia ficou a 0
    JNZ  sai_aumentar_energia           ; se não, sai

sai_aumentar_energia:
    POP R1
    POP R0
    JMP fim_chama_comando

; ******************************************************************************
; atualiza_energia - Actualiza a energia da nave,
;                     mostrando-a também nos displays (em decimal).
;
; Argumentos: R0 - novo valor da energia da nave
; ******************************************************************************
atualiza_energia:
    PUSH R0
    PUSH R1
    PUSH R2
    PUSH R3
    PUSH R4
    MOV  R3, ENERGIA_BONECO
    MOV  [R3], R0                       ; atualiza valor da energia
    MOV  R1, 100                        ; primeiro valor do fator
    MOV  R2, 10                         ; para dividir o fator
    MOV  R3, 0                          ; valor a enviar para os displays

converte:                               ; converte o valor da energia
    MOV  R4, R0                         ; copia o valor
    DIV  R4, R1                         ; divide o valor pelo fator
    MOD  R0, R1                         ; o valor passa a ser o resto
    DIV  R1, R2                         ; divide o fator
    SHL  R3, 4                          ; desloca o valor a enviar
    OR   R3, R4                         ; junta o novo dígito (4 bits)
    CMP  R1, 0                          ; o fator ficou 0 após a divisão
                                        ; ver se era 1 antes de ser dividido
    JNZ  converte                       ; se não, continua a converter
    MOV  R4, DISPLAYS                   ; endereço do periférico dos displays
    MOV  [R4], R3                       ; escreve o valor convertido nos displays
    POP  R4
    POP  R3
    POP  R2
    POP  R1
    POP  R0
    RET

; ******************************************************************************
; muda_personagem - Altera a personagem de rapaz para rapariga e vice-versa.
; ******************************************************************************
muda_personagem: 			
	MOV R0, [ESTADO_PERSONAGEM]         ; obtem personagem atual
	MOV R1, RAPAZ   
	CMP R1, R0                          ; verifica se é o rapaz
	JZ muda_rapaz                       ; se sim, muda-o para a rapariga
	MOV R3, SOM_PERSONAGEM		        ; obtem som de mudar personagem
	CALL reproduz_som                   ; reproduz som de mudar personagem
	
muda_rapariga:                          ; muda a rapariga para o rapaz
	CALL apaga_personagem               ; apaga personagem atual         
	CALL desenha_rapaz                  ; desenha nova personagem (rapaz)
	MOV R2, RAPAZ                       
	MOV [ESTADO_PERSONAGEM], R2         ; atualiza estado da personagem
	JMP fim_chama_comando

muda_rapaz:
	CALL apaga_personagem               ; apaga personagem atual
	CALL desenha_rapariga               ; desenha nova personagem (rapariga)
	MOV R2, RAPARIGA
	MOV [ESTADO_PERSONAGEM], R2         ; atualiza estado da personagem
	JMP fim_chama_comando

; ******************************************************************************
; atualiza_posicao_missil - Atualiza a posição do missel consoante a sua direção, 
;					 	   devolve a sua nova linha (R1) e a sua nova coluna (R2)
;
; Argumentos: R1 - valor da linha atual 
;			  R2 - valor da coluna atual
;			  R3 - direção em que vai subir
; ******************************************************************************
atualiza_posicao_missil:
	MOV R5, -1
	CMP R5, R3
	JZ fim_atualiza_posicao
	MOV R5, ESQUERDA
	CMP R5, R3
	JZ move_esquerda_missil
	MOV R5, MEIO
	CMP R5, R3
	JZ move_meio_missil
	MOV R5, DIREITA
	CMP R5, R3
	JZ move_direita_missil
	RET

move_esquerda_missil:
	SUB R1, 1
	SUB R2, 2
	RET

move_meio_missil:
	SUB R1, 1
	RET

move_direita_missil:
	SUB R1, 1
	ADD R2, 2
	RET

fim_atualiza_posicao:
	RET
; ******************************************************************************
; atira_missil - Ativa os misseis, passando-os de um estado parado (0) para 
;				 movimento, de acordo com a direção escolhida.
; ******************************************************************************
atira_missil_esquerda:
	MOV R5, ESQUERDA			; valor a colocar caso haja algum missil parado
	JMP procura_missil_parado

atira_missil_cima:
	MOV R5, MEIO				; valor a colocar caso haja algum missil parado
	JMP procura_missil_parado	
	
atira_missil_direita:
	MOV R5, DIREITA				; valor a colocar caso haja algum missil parado
	JMP procura_missil_parado

procura_missil_parado:
	MOV R1, -1					; estado parado a comparar
	MOV R3, [POS_MISSIL_1+4]
	CMP R1, R3					; compara estado atual do missil 1
	JZ ativa_missil_1			; caso esteja parado (0), ativa-o

	MOV R1, -1
	MOV R3, [POS_MISSIL_2+4]
	CMP R1, R3					; compara estado atual do missil 2
	JZ ativa_missil_2			; caso esteja parado, ativa-o

	MOV R1, -1
	MOV R3, [POS_MISSIL_3+4]
	CMP R1, R3					; compara estado atual do missil 3
	JZ ativa_missil_3			; caso esteja parado, ativa-o

	MOV R1, LINHA_MISSIL
	MOV R2, COLUNA_MISSIL

	JMP fim_chama_comando		; se nenhum missil estiver ativo, vai para 
								; o fim do comando

ativa_missil_1:
	MOV [POS_MISSIL_1+4], R5	; atualiza direção com valor escolhido
	JMP fim_chama_comando

ativa_missil_2:
	MOV [POS_MISSIL_2+4], R5	; atualiza direção com valor escolhido
	JMP fim_chama_comando

ativa_missil_3:
	MOV [POS_MISSIL_3+4], R5	; atualiza direção com valor escolhido
	JMP fim_chama_comando

; ******************************************************************************
; testa_limites_missil - Testa a posição do missil atual e vê se ultrapassou os
;						 limites do ecrã ou se ocorreu um choque.
;
; Argumentos: R1 - valor da linha atual do missil
;			  R2 - valor da coluna atual do missil
;			  R3 - direção em que o missil vai subir
; ******************************************************************************
testa_limites_missil:
	MOV R6, -1					; valor do  limite esquerdo	
	CMP R6, R2					; ver se o missil ultrapassou esse limite		
	JZ reset_missil				; se sim, repõe-o

	MOV R6, 64					; valor do limite direito	
	CMP R6, R2					; ver se o missil ultrapassou esse limite		
	JZ reset_missil				; se sim, repõe-o

	MOV R6, 0					; valor do limite superios
	CMP R6, R1					; ver se o missil ultrapassou esse limite		
	JZ reset_missil				; se sim, repõe-o
	
testa_choque_1:					; testa choque com a bomba 1
	MOV R5, [POS_BOMBA_1]		; obtem linha bomba 1 (limite superior)
	MOV R6, R5
	ADD R6, 3					; obtem limite inferior da bomba 1
	MOV R7, [POS_BOMBA_1+2]		; obtem coluna bomba 1 (limite esquerdo)
	MOV R8, R7					
	ADD R8, 3					; obtem limite direito da bomba 1

	; ver se o missil está dentro dos limites da linha da bomba
	CMP R5, R1					
	JGT testa_choque_2
	CMP R6, R1
	JLT testa_choque_2

	; ver se o missil esta dentro dos limites da coluna da bomba
	CMP R7, R2
	JGT testa_choque_2
	CMP R8, R2
	JLT testa_choque_2			; se não estiver, testa-se o choque com a bomba 2

	CALL apaga_bomba_1			; apaga a bomba que sofreu um choque
	CALL apaga_missil_1			; apaga o missil que sofreu o choque

	MOV R4, LINHA_BOMBA_MEIO	; repoe linha da bomba
	MOV R5, COLUNA_BOMBA_MEIO	; repoe coluna da bomba
	MOV R1, LINHA_MISSIL		; repoe linha do missil
	MOV R2, COLUNA_MISSIL		; repoe coluna do missil
	MOV R3, -1

	MOV [POS_BOMBA_1], R4		; atualiza linha bomba
	MOV [POS_BOMBA_1+2], R5		; atualiza coluna bomba
	RET

testa_choque_2:					; testa choque com a bomba 2
	MOV R5, [POS_BOMBA_2]		; obtem linha bomba 2
	MOV R6, R5
	ADD R6, 3					; obtem limite inferior da bomba 2
	MOV R7, [POS_BOMBA_2+2]		; obtem coluna bomba 2
	MOV R8, R7
	ADD R8, 3					; obtem limite direito da bomba 2

	; ver se o missil está dentro dos limites da linha da bomba
	CMP R5, R1
	JGT testa_choque_3
	CMP R6, R1
	JLT testa_choque_3

	; ver se o missil esta dentro dos limites da coluna da bomba
	CMP R7, R2
	JGT testa_choque_3
	CMP R8, R2
	JLT testa_choque_3			; se não estiver, testa-se o choque com a bomba 3

	CALL apaga_bomba_2
	CALL apaga_missil_1

	MOV R4, LINHA_BOMBA_MEIO
	MOV R5, COLUNA_BOMBA_MEIO
	MOV R1, LINHA_MISSIL
	MOV R2, COLUNA_MISSIL
	MOV R3, -1

	MOV [POS_BOMBA_2], R4
	MOV [POS_BOMBA_2+2], R5
	RET

testa_choque_3:					; testa choque com a bomba 3
	MOV R5, [POS_BOMBA_3]		; obtem linha bomba 3
	MOV R6, R5
	ADD R6, 3					; obtem limite inferior da bomba 3
	MOV R7, [POS_BOMBA_3+2]		; obtem coluna bomba 3
	MOV R8, R7
	ADD R8, 3					; obtem limite direito da bomba 3

	; ver se o missil está dentro dos limites da linha da bomba
	CMP R5, R1
	JGT testa_choque_4
	CMP R6, R1
	JLT testa_choque_4

	; ver se o missil esta dentro dos limites da coluna da bomba
	CMP R7, R2
	JGT testa_choque_4
	CMP R8, R2
	JLT testa_choque_4			; se não estiver, testa-se o choque com a bomba 4

	CALL apaga_bomba_3

	MOV R4, LINHA_BOMBA_MEIO
	MOV R5, COLUNA_BOMBA_MEIO
	MOV R1, LINHA_MISSIL
	MOV R2, COLUNA_MISSIL
	MOV R3, -1

	MOV [POS_BOMBA_3], R4
	MOV [POS_BOMBA_3+2], R5
	RET

testa_choque_4:					; testa choque com a bomba 4
	MOV R5, [POS_BOMBA_4]		; obtem linha bomba 4
	MOV R6, R5
	ADD R6, 3					; obtem limite inferior da bomba 4
	MOV R7, [POS_BOMBA_4+2]		; obtem coluna bomba 4
	MOV R8, R7
	ADD R8, 3					; obtem limite direito da bomba 4

	; ver se o missil está dentro dos limites da linha da bomba
	CMP R5, R1
	JGT fim_limites_missil
	CMP R6, R1
	JLT fim_limites_missil

	; ver se o missil esta dentro dos limites da coluna da bomba
	CMP R7, R2
	JGT fim_limites_missil		
	CMP R8, R2
	JLT fim_limites_missil		; se não estiver, ja se testou todos os limites 

	CALL apaga_bomba_4

	MOV R4, LINHA_BOMBA_MEIO
	MOV R5, COLUNA_BOMBA_MEIO
	MOV R1, LINHA_MISSIL
	MOV R2, COLUNA_MISSIL
	MOV R3, -1

	MOV [POS_BOMBA_4], R4
	MOV [POS_BOMBA_4+2], R5
	RET

fim_limites_missil:
	RET

reset_missil:
	MOV R1, LINHA_MISSIL		; repor linha do missil 
	MOV R2, COLUNA_MISSIL		; repor coluna do missil
	MOV R3, -1					; repor estado do missil a parado (-1)
	RET

; ******************************************************************************
; move_missil - Move os misseis ativos uma linha para cima consoante a sua 
;				direção:
;				- Direita: Uma linha para cima e duas colunas para a direita
;				- Esquerda: Uma linha para cima e duas colunas para a esquerda
;				- Meio: Uma linha para cima
; ******************************************************************************
move_misseis:
	CALL apaga_missil_1                 ; apaga o missil na posição antiga
	MOV R1, [POS_MISSIL_1]				; obtem linha atual
	MOV R2, [POS_MISSIL_1+2]            ; obtem coluna atual
	MOV R3, [POS_MISSIL_1+4]            ; obtem direção do missil

	CALL atualiza_posicao_missil		; obtem nova posição

	MOV [POS_MISSIL_1], R1              ; atualiza valor da linha
	MOV [POS_MISSIL_1+2], R2            ; atualiza valor da colunas

	CALL reproduz_som	                ; reproduz som do missil

	CALL testa_limites_missil

	MOV [POS_MISSIL_1], R1              ; atualiza valor da linha
	MOV [POS_MISSIL_1+2], R2            ; atualiza valor da colunas
	MOV [POS_MISSIL_1+4], R3            ; atualiza estado do missil

	CALL desenha_missil_1               ; desenha missil na nova posição

move_missel_2:
	CALL apaga_missil_2                 ; apaga o missil na posição antiga
	MOV R1, [POS_MISSIL_2]				; obtem linha atual
	MOV R2, [POS_MISSIL_2+2]            ; obtem coluna atual
	MOV R3, [POS_MISSIL_2+4]            ; obtem direção do missil

	CALL atualiza_posicao_missil		; obtem nova posição

	MOV [POS_MISSIL_2], R1              ; atualiza valor da linha
	MOV [POS_MISSIL_2+2], R2            ; atualiza valor da colunas

	CALL reproduz_som	                ; reproduz som do missil

	CALL testa_limites_missil

	MOV [POS_MISSIL_2], R1              ; atualiza valor da linha
	MOV [POS_MISSIL_2+2], R2            ; atualiza valor da colunas
	MOV [POS_MISSIL_2+4], R3            ; atualiza estado do missil

	CALL desenha_missil_2               ; desenha missil na nova posição

move_missel_3:
	CALL apaga_missil_3                 ; apaga o missil na posição antiga
	MOV R1, [POS_MISSIL_3]				; obtem linha atual
	MOV R2, [POS_MISSIL_3+2]            ; obtem coluna atual
	MOV R3, [POS_MISSIL_3+4]            ; obtem direção do missil

	CALL atualiza_posicao_missil		; obtem nova posição

	MOV [POS_MISSIL_3], R1              ; atualiza valor da linha
	MOV [POS_MISSIL_3+2], R2            ; atualiza valor da colunas

	CALL reproduz_som	                ; reproduz som do missil

	CALL testa_limites_missil

	MOV [POS_MISSIL_3], R1              ; atualiza valor da linha
	MOV [POS_MISSIL_3+2], R2            ; atualiza valor da colunas
	MOV [POS_MISSIL_3+4], R3            ; atualiza estado do missil

	CALL desenha_missil_3               ; desenha missil na nova posição

sai_move_misseis:
	JMP fim_chama_comando

; ******************************************************************************
; move_bombas - Move as bombas consoante a sua direção atual:
;				- Direita: desce uma linha e avança duas colunas para a direita.
;				- Esquerda: desce uma linha e avança duas colunas 
; 				  para a esquerda.
;				- Meio: desce uma linha.
; ******************************************************************************
move_bombas:
	PUSH R0
    PUSH R1
	MOV R0, [ESTADO_JOGO]				; obtem estado de jogo
	MOV R1, JOGO_EM_CURSO
	CMP R0, R1							; verifica se jogo está em curso
	JNZ sai_move_bombas					; se não, sai 

    MOV R0, INT_BOMBAS    				; verifica se houve interrupção para mover as bombas
	MOV R0, [R0]
	CMP R0, 0
	JZ sai_move_bombas					; se não, sai

	MOV R0, INT_BOMBAS					;assinala a interrupção de volta a zero
	MOV R1, 0
	MOV [R0], R1
	CALL apaga_bomba_1                  ; apaga a bomba na posição antiga
	MOV R1, [POS_BOMBA_1]				; obtem linha atual
	MOV R2, [POS_BOMBA_1+2]             ; obtem coluna atual
	MOV R3, [POS_BOMBA_1+4]             ; obtem direção da bomba

	CALL atualiza_posicao				; obtem nova posição

	MOV [POS_BOMBA_1], R1               ; atualiza valor da linha
	MOV [POS_BOMBA_1+2], R2             ; atualiza valor da colunas

	CALL reproduz_som	                ; reproduz som da bomba
	
	CALL testa_limites_bomba			; vê se a nova polsição ultrapassa limites
	MOV [POS_BOMBA_1], R1               ; atualiza valor da linha
	MOV [POS_BOMBA_1+2], R2             ; atualiza valor da colunas
	MOV [POS_BOMBA_1+4], R3 			

	CALL desenha_bomba_1                ; desenha bomba na nova posição

move_bomba_2:
	CALL apaga_bomba_2                  ; apaga a bomba na posição antiga
	MOV R1, [POS_BOMBA_2]				; obtem linha atual
	MOV R2, [POS_BOMBA_2+2]             ; obtem coluna atual
	MOV R3, [POS_BOMBA_2+4]             ; obtem direção da bomba

	CALL atualiza_posicao				; obtem nova posição

	MOV [POS_BOMBA_2], R1               ; atualiza valor da linha
	MOV [POS_BOMBA_2+2], R2             ; atualiza valor da colunas
	MOV [POS_BOMBA_2+4], R3 

	CALL reproduz_som	                ; reproduz som da bomba


	CALL testa_limites_bomba			; vê se a nova polsição ultrapassa limites
	MOV [POS_BOMBA_2], R1               ; atualiza valor da linha
	MOV [POS_BOMBA_2+2], R2             ; atualiza valor da colunas
	MOV [POS_BOMBA_2+4], R3 			

	CALL desenha_bomba_2                ; desenha bomba na nova posição

move_bomba_3:
	CALL apaga_bomba_3                  ; apaga a bomba na posição antiga
	MOV R1, [POS_BOMBA_3]				; obtem linha atual
	MOV R2, [POS_BOMBA_3+2]             ; obtem coluna atual
	MOV R3, [POS_BOMBA_3+4]             ; obtem direção da bomba

	CALL atualiza_posicao				; obtem nova posição

	MOV [POS_BOMBA_3], R1               ; atualiza valor da linha
	MOV [POS_BOMBA_3+2], R2             ; atualiza valor da colunas
	MOV [POS_BOMBA_3+4], R3 

	CALL reproduz_som	                ; reproduz som da bomba

	CALL testa_limites_bomba			; vê se a nova polsição ultrapassa limites
	MOV [POS_BOMBA_3], R1               ; atualiza valor da linha
	MOV [POS_BOMBA_3+2], R2             ; atualiza valor da colunas
	MOV [POS_BOMBA_3+4], R3 			

	CALL desenha_bomba_3                ; desenha bomba na nova posição
move_bomba_4:
	CALL apaga_bomba_4                  ; apaga a bomba na posição antiga
	MOV R1, [POS_BOMBA_4]				; obtem linha atual
	MOV R2, [POS_BOMBA_4+2]             ; obtem coluna atual
	MOV R3, [POS_BOMBA_4+4]             ; obtem direção da bomba

	CALL atualiza_posicao				; obtem nova posição

	MOV [POS_BOMBA_4], R1               ; atualiza valor da linha
	MOV [POS_BOMBA_4+2], R2             ; atualiza valor da colunas
	MOV [POS_BOMBA_4+4], R3 

	CALL reproduz_som	                ; reproduz som da bomba

	CALL testa_limites_bomba			; vê se a nova polsição ultrapassa limites
	MOV [POS_BOMBA_4], R1               ; atualiza valor da linha
	MOV [POS_BOMBA_4+2], R2             ; atualiza valor da colunas
	MOV [POS_BOMBA_4+4], R3 			

	CALL desenha_bomba_4                ; desenha bomba na nova posição

sai_move_bombas:
	POP R1 
	POP R0 
	RET

; ******************************************************************************
; testa_limites_bombas - Avalia a posição das bombas e vê se ultrapassou os 
;						 limites do ecrã ou se atingiu a personagem.
;
; Argumentos: R1 - valor da linha atual 
;			  R2 - valor da coluna atual
;			  R3 - direção em que vai descer
; ******************************************************************************
testa_limites_bomba:
	MOV R6, ESQUERDA					; limites de bombas que caminham 
										; na direção esquerda
										
	CMP R6, R3
	JNZ limites_direitos
	MOV R5, 0							; testar limite inferior direito
	CMP R5, R2
	JZ reset_bomba						; caso tenha ultrapassado, 
										; dá reset à posição da bomba
	MOV R5, 33
	CMP R5, R2							; testar choque com personagem 
	JZ reset_bomba
	JMP fim_limites_bomba

limites_direitos:						; limites de bombas que caminham 
										; na direção direita
	MOV R6, DIREITA
	CMP R6, R3
	JNZ limites_meio	
	MOV R5, 60							; testar limite inferior direito
	CMP R5, R2
	JZ reset_bomba
	MOV R5, 18							; testar choque com personagem
	CMP R5, R1							; ver se ultrapassou a linha da personagem
	JNZ fim_limites_bomba				; se não, avança
	MOV R5, 20							; testa coluna da bomba para saber se houve
										; choque
	CMP R5, R2
	JNZ fim_limites_bomba
	JMP reset_bomba						; se sim, dá reset à bomba
	JMP fim_limites_bomba

limites_meio:							; limites de bombas que caminham para baixo
	MOV R5, 18							; testar choque com personagem
	CMP R5, R1
	JZ reset_bomba

fim_limites_bomba:
	RET

; ******************************************************************************
; reset_bomba - Devolve a bomba ao topo do ecrã quando esta ultrapassa os
; 				limites do ecrã. É colocada numa posição aleatória (canto
;				esquerdo, meio ou direito).
;
; Argumentos: R1 - valor da linha atual 
;			  R2 - valor da coluna atual
;			  R3 - direção em que vai descer
; ******************************************************************************
reset_bomba:
	MOV R4, 2 						; número do valor aleatório que define 
									; a posição (0, 1 ou 2)
	CMP R4, ESQUERDA				; ver se a posição aleatória é a esquerda
	JNZ testa_meio					; se não for, vai testar o meio
	MOV R1, LINHA_BOMBA_ESQ			; atualiza a linha e coluna da bomba para
	MOV R2, COLUNA_BOMBA_ESQ		; a inicial
	MOV R3, DIREITA
	JMP fim_reset_bomba

testa_meio:					
	CMP R4, MEIO					; vê se a posição aleatória é a do meio
	JNZ testa_direita				; se não for, resta a posição à direita
	MOV R1, LINHA_BOMBA_MEIO		; atualiza a linha e coluna da bomba para
	MOV R2, COLUNA_BOMBA_MEIO		; a inicial
	JMP fim_reset_bomba

testa_direita:
	MOV R1, LINHA_BOMBA_DIR			; atualiza a linha e coluna da bomba para
	MOV R2, COLUNA_BOMBA_DIR		; a inicial
	MOV R3, ESQUERDA

fim_reset_bomba:
	RET

; ******************************************************************************
; atualiza_posicao - Atualiza a posição da bomba consoante a sua direção, 
;					 devolve a sua nova linha (R1) e a sua nova coluna (R2)
;
; Argumentos: R1 - valor da linha atual 
;			  R2 - valor da coluna atual
;			  R3 - direção em que vai descer
; ******************************************************************************
atualiza_posicao:
	MOV R5, ESQUERDA
	CMP R5, R3							; ver se desce para a esquerda, se sim
										; atualiza valores
	JNZ move_meio				
	ADD R1, 1							; diminui	 uma linha
	SUB R2, 1							; diminui duas coluna
	RET

move_meio:
	MOV R5, MEIO						; ver se desce para o meio; se sim
										; atualiza valores, se não, vai para a
										; direita 
	CMP R5, R3
	JNZ move_direita					
	ADD R1, 1							; diminui uma linha
	RET 

move_direita:
	ADD R1, 1                           ; aumenta uma linha
	ADD R2, 1                           ; aumenta duas colunas
	RET

; ******************************************************************************
; comeca_jogo - Começa o jogo, mudando o estado de jogo e desenhando os objetos
;               associados ao decorrer do jogo.
; ******************************************************************************
comeca_jogo:

	MOV R4, JOGO_EM_CURSO
	MOV [ESTADO_JOGO], R4		        ; muda o estado de jogo para em curso

	CALL desenha_missil_1
	CALL desenha_missil_2
	CALL desenha_missil_3
	CALL desenha_bomba_1			    ; desenha bomba 1 no ecrã
	CALL desenha_bomba_2
	CALL desenha_bomba_3
	CALL desenha_bomba_4
	MOV R1, 0
	MOV  [SELECIONA_CENARIO], R1        ; altera para cenário do jogo

	JMP fim_chama_comando

; ******************************************************************************
; acaba_jogo - Acaba o jogo, mudando o estado de jogo, apagando os objetos do
;              do jogo e repondo-os na sua posição inicial.
; ******************************************************************************
acaba_jogo:
	MOV R4, JOGO_ACABADO
	MOV [ESTADO_JOGO], R4		        ; muda o estado de jogo para acabadp
	CALL apaga_bombas			        ; apaga as bombas do ecrã
	CALL apaga_misseis			        ; apaga o missil do ecrã
	MOV R1, 1

	MOV R3, LINHA_BOMBA_ESQ		
	MOV [POS_BOMBA_1], R3				; repor linha bomba 1 à linha inicial
	MOV R2, COLUNA_BOMBA_ESQ
	MOV [POS_BOMBA_1+2], R2				; repor coluna bomba 1 à coluna inicial

	MOV R3, LINHA_BOMBA_MEIO		
	MOV [POS_BOMBA_2], R3				; repor linha bomba 2 à linha inicial
	MOV R2, COLUNA_BOMBA_MEIO
	MOV [POS_BOMBA_2+2], R2				; repor coluna bomba 2 à coluna inicial

	MOV R3, LINHA_BOMBA_MEIO			
	MOV [POS_BOMBA_3], R3				; repor linha bomba 3 à linha inicial
	MOV R2, COLUNA_BOMBA_MEIO
	MOV [POS_BOMBA_3+2], R2				; repor coluna bomba 4 à coluna inicial

	MOV R3, LINHA_BOMBA_DIR			
	MOV [POS_BOMBA_4], R3				; repor linha bomba 3 à linha inicial
	MOV R2, COLUNA_BOMBA_DIR
	MOV [POS_BOMBA_4+2], R2				; repor coluna bomba 4 à coluna inicial

	MOV R3, LINHA_MISSIL		
	MOV R2, COLUNA_MISSIL

	MOV [POS_MISSIL_1], R3				; repor linha missil 1 à linha inicial
	MOV [POS_MISSIL_1+2], R2			; repor coluna missil 1 à coluna inicial
	
	MOV [POS_MISSIL_2], R3				; repor linha missil 1 à linha inicial
	MOV [POS_MISSIL_2+2], R2			; repor coluna missil 1 à coluna inicial
	
	MOV [POS_MISSIL_3], R3				; repor linha missil 1 à linha inicial
	MOV [POS_MISSIL_3+2], R2			; repor coluna missil 1 à coluna inicial

	CALL reset_energia

    MOV R1, 1
    MOV [SELECIONA_CENARIO], R1
	JMP fim_chama_comando

; ******************************************************************************
; reset_energia - Repõe energia a zeros após o jogo ter acabado.
; ******************************************************************************
reset_energia:
	PUSH R0
	PUSH R1
	MOV R0, INT_ENERGIA  
	MOV R1, ENERGIA_BONECO
	MOV R0, [R1]				        ; lê a energia do boneco
	MOV R0, 0					        ; muda a energia para zero
	call atualiza_energia		        ; atualiza valor na variavel e displays
	CMP R0, 0					        ; compara energia do boneco a zero
	JZ fim_reset_energia		        ; se zero, sai

	
fim_reset_energia:
	POP R1
	POP R0
	RET

; ******************************************************************************
; reproduz_som - Reproduz um dado som.
; Argumentos - R0 - Número do som a reproduzir
; ******************************************************************************
reproduz_som:
    PUSH R0
    PUSH R1
    MOV R1, REPRODUZ_SOM
    MOV [R1], R0
    POP R1
    POP R0
    RET

; ******************************************************************************
; apaga_missil - Apaga o missil na sua posição atual.
; ******************************************************************************
apaga_misseis:
	CALL apaga_missil_1
	CALL apaga_missil_2
	CALL apaga_missil_3
	RET

apaga_missil_1:
	MOV R1, [POS_MISSIL_1] 		        ; obtem linha atual do missil
	MOV R2, [POS_MISSIL_1+2] 		    ; obtem coluna atual do missil
	MOV R4, DEF_MISSIL_APAGADO	        ; definição do missil apagado (tudo a 0)
	CALL desenha_boneco
	RET

apaga_missil_2:
	MOV R1, [POS_MISSIL_2] 		        ; obtem linha atual do missil
	MOV R2, [POS_MISSIL_2+2] 		    ; obtem coluna atual do missil
	MOV R4, DEF_MISSIL_APAGADO	        ; definição do missil apagado (tudo a 0)
	CALL desenha_boneco
	RET

apaga_missil_3:
	MOV R1, [POS_MISSIL_3] 		        ; obtem linha atual do missil
	MOV R2, [POS_MISSIL_3+2] 		    ; obtem coluna atual do missil
	MOV R4, DEF_MISSIL_APAGADO	        ; definição do missil apagado (tudo a 0)
	CALL desenha_boneco
	RET

; ******************************************************************************
; apaga_bomba -  Apaga a bomba indicada na sua posição atual.
; ******************************************************************************
apaga_bombas:
	CALL apaga_bomba_1
	CALL apaga_bomba_2
	CALL apaga_bomba_3
	CALL apaga_bomba_4
	RET

apaga_bomba_1:
	MOV R1, [POS_BOMBA_1] 		        ; obtem linha atual da bomba
	MOV R2, [POS_BOMBA_1+2] 		        ; obtem coluna atual da bomba
	MOV R4, DEF_BOMBA_APAGADA           ; definição da bomba apagada 
	CALL desenha_boneco
	RET

apaga_bomba_2:
	MOV R1, [POS_BOMBA_2] 		        ; obtem linha atual da bomba
	MOV R2, [POS_BOMBA_2+2] 		        ; obtem coluna atual da bomba
	MOV R4, DEF_BOMBA_APAGADA           ; definição da bomba apagada 
	CALL desenha_boneco
	RET

apaga_bomba_3:
	MOV R1, [POS_BOMBA_3] 		        ; obtem linha atual da bomba
	MOV R2, [POS_BOMBA_3+2] 		        ; obtem coluna atual da bomba
	MOV R4, DEF_BOMBA_APAGADA           ; definição da bomba apagada 
	CALL desenha_boneco
	RET

apaga_bomba_4:
	MOV R1, [POS_BOMBA_4] 		        ; obtem linha atual da bomba
	MOV R2, [POS_BOMBA_4+2] 		        ; obtem coluna atual da bomba
	MOV R4, DEF_BOMBA_APAGADA           ; definição da bomba apagada 
	CALL desenha_boneco
	RET

; ******************************************************************************
; apaga_personagem - Apaga a personagem na sua posição atual.
; ******************************************************************************
apaga_personagem:
	MOV R1, [POS_PERSONAGEM] 		    ; obtem linha da personagem
	MOV R2, [POS_PERSONAGEM+2] 		    ; obtem coluna da personagem
	MOV R4, DEF_PERSONAGEM_APAGADA	    ; definição da personagem apagada 
	CALL desenha_boneco
	RET

; ******************************************************************************
; apaga_arma - Apaga a arma na sua posição atual.
; ******************************************************************************
apaga_arma:
	MOV R1, [POS_ARMA] 		            ; obtem linha da arma
	MOV R2, [POS_ARMA+2] 		        ; obtem coluna da arma
	MOV R4, DEF_ARMA_APAGADA	        ; definição da arma apagada
	CALL desenha_boneco
	RET

; ******************************************************************************
; desenha_rapaz - Desenha o rapaz na sua posição definida.
; ******************************************************************************
desenha_rapaz:
	MOV R1, [POS_PERSONAGEM] 		    ; obtem linha do rapaz
	MOV R2, [POS_PERSONAGEM+2] 		    ; obtem coluna do rapaz
	MOV R4, DEF_RAPAZ			        ; definição do rapaz
	CALL desenha_boneco
	RET

; ******************************************************************************
; desenha_rapariga - Desenha a rapariga na sua posição definida.
; ******************************************************************************
desenha_rapariga:
	MOV R1, [POS_PERSONAGEM] 		    ; obtem linha da rapariga
	MOV R2, [POS_PERSONAGEM+2] 		    ; obtem coluna da rapariga
	MOV R4, DEF_RAPARIGA			    ; definição da rapariga
	CALL desenha_boneco
	RET

; ******************************************************************************
; desenha_missil - Desenha o missil na sua posição definida.
; ******************************************************************************
desenha_missil_1:
	MOV R1, [POS_MISSIL_1] 		        ; obtem linha atual do missil
	MOV R2, [POS_MISSIL_1+2] 		    ; obtem coluna atual do missil
	MOV R4, DEF_MISSIL			        ; definição do missil
	CALL desenha_boneco
	RET

desenha_missil_2:
	MOV R1, [POS_MISSIL_2] 		        ; obtem linha atual do missil
	MOV R2, [POS_MISSIL_2+2] 		    ; obtem coluna atual do missil
	MOV R4, DEF_MISSIL			        ; definição do missil
	CALL desenha_boneco
	RET

desenha_missil_3:
	MOV R1, [POS_MISSIL_3] 		        ; obtem linha atual do missil
	MOV R2, [POS_MISSIL_3+2] 		    ; obtem coluna atual do missil
	MOV R4, DEF_MISSIL			        ; definição do missil
	CALL desenha_boneco
	RET

; ******************************************************************************
; desenha_bomba - Desenha a bomba na sua posição definida.
; ******************************************************************************
desenha_bomba_1:
	MOV R1, [POS_BOMBA_1] 		        ; obtem linha atual da bomba
	MOV R2, [POS_BOMBA_1+2] 		        ; obtem coluna atual da bomba
	MOV R4, DEF_BOMBA			        ; definição da bomba 
	CALL desenha_boneco
	RET

desenha_bomba_2:
	MOV R1, [POS_BOMBA_2] 		        ; obtem linha atual da bomba
	MOV R2, [POS_BOMBA_2+2] 		        ; obtem coluna atual da bomba
	MOV R4, DEF_BOMBA			        ; definição da bomba 
	CALL desenha_boneco
	RET

desenha_bomba_3:
	MOV R1, [POS_BOMBA_3] 		        ; obtem linha atual da bomba
	MOV R2, [POS_BOMBA_3+2] 		        ; obtem coluna atual da bomba
	MOV R4, DEF_BOMBA_MINERAVEL			        ; definição da bomba 
	CALL desenha_boneco
	RET

desenha_bomba_4:
	MOV R1, [POS_BOMBA_4] 		        ; obtem linha atual da bomba
	MOV R2, [POS_BOMBA_4+2] 		    ; obtem coluna atual da bomba
	MOV R4, DEF_BOMBA					; definição da bomba 
	CALL desenha_boneco
	RET

; ******************************************************************************
; desenha_arma - Desenha a arma na sua posição e estado, se esta estiver
;                cinzenta, desenha-a a branco e vice-versa.
; ******************************************************************************
desenha_arma:
	MOV R1, CINZENTO    
	mov R2, [COR_ARMA]                  
	CMP R2, R1                          ; ver se a cor atual da arma é cinzenta
	JZ muda_arma_branco                 ; se for, muda para branco
                                        ; se não, muda para cinzento
	MOV R1, [POS_ARMA]                  ; obtem linha da arma
	MOV R2, [POS_ARMA+2]                ; obtem coluna da arma
	MOV R4, DEF_ARMA_CINZENTA           ; obtem definição da arma cinzenta
	CALL desenha_boneco

    MOV R1, CINZENTO                    
    MOV [COR_ARMA], R1                  ; atualiza a cor da arma para cinzento

fim_desenha_arma:
	RET

muda_arma_branco:       
	MOV R1, [POS_ARMA]                  ; obtem linha da arma
	MOV R2, [POS_ARMA+2]                ; obtem coluna da arma
	MOV R4, DEF_ARMA_BRANCA             ; obtem definição da arma branca
	CALL desenha_boneco
    MOV R1, BRANCO                  
    MOV [COR_ARMA], R1                  ; atualiza a cor da arma para branco
	JMP fim_desenha_arma

; ******************************************************************************
; muda_cor_arma - Muda a cor da arma de cinzento para branco, verificando
;                 primeiro se o jogo está em curso
; ******************************************************************************
muda_cor_arma:
    PUSH R1
    PUSH R2
    PUSH R3
    PUSH R4
    MOV R1, JOGO_EM_CURSO
    MOV R2, [ESTADO_JOGO]
    CMP R1, R2
    JNZ fim_muda_cor_arma
	CALL desenha_arma
fim_muda_cor_arma:
    POP R4
    POP R3
    POP R2
    POP R1
	RET
; ******************************************************************************
; teclado - Detecta quando se carrega numa tecla do teclado.
; ******************************************************************************
teclado:
    PUSH R0
    PUSH R1
    PUSH R2
    PUSH R3
    PUSH R5
    PUSH R6
    PUSH R7
    PUSH R8
    PUSH R9
    PUSH R10

    MOV  R2, TEC_LIN                    ; endereço do periférico das linhas
    MOV  R3, TEC_COL                    ; endereço do periférico das colunas
    MOV  R5, MASCARA                    ; para isolar os bits de menor peso
    MOV  R7, 0
    MOV  R8, 0
    MOV  R9, 4

ciclo_tecla:
    MOV  R1, 0                          
    MOV  R6, LINHA_TEC                  ; inserir linha que será testada

espera_tecla:                           ; espera até uma tecla ser pressionada
    MOV  R1, R6                         ; testa a linha
    MOVB [R2], R1                       ; escrever no periférico de saída (linhas)
    MOVB R0, [R3]                       ; ler do periférico de entrada (colunas)
    AND  R0, R5                         ; elimina bits para além dos bits 0-3
    CMP  R0, 0                          ; ver se há uma tecla pressionada
    JZ   teste_tecla                    ; se não houver, testa outra
                       

transforma_linha_tecla:                 ; transforma o numero da linha em 0,1,2,3
    SHR R1, 1                           ; andar 1 para trás na ordem 1,2,4,8
    CMP R1, 0              
    JNZ transforma_linha_tecla_aux
    JMP transforma_coluna_tecla

transforma_coluna_tecla:                ; transforma o numero da coluna em 0,1,2,3
    SHR R0, 1                           ; andar 1 para trás na ordem 1,2,4,8
    CMP R0, 0                           
    JNZ transforma_coluna_tecla_aux

valor_tecla:
    MOV R10, [DEF_TECLA]                
    MOV [DEF_TECLA+2], R10              
    MUL R7, R9                          ; multiplica o valor da linha por 4
    ADD R7, R8                          ; adiciona a coluna
    MOV [DEF_TECLA], R7                 ; atualiza o valor da tecla
    JMP final_tecla

transforma_linha_tecla_aux:             ; ciclo para obter valor da linha
    ADD R7, 1                           
    JMP transforma_linha_tecla

transforma_coluna_tecla_aux:            ; ciclo para obter valor da coluna
    ADD R8, 1                           
    JMP transforma_coluna_tecla

teste_tecla:
    CMP R6, 7                           ; verifica se chegámos à ultima linha 
    JGT reset_tecla 
    SHL R6, 1                           ; testa proxima linha 
    JMP espera_tecla

reset_tecla:                            ; repõe valor da tecla
    MOV R10, -1
    MOV [DEF_TECLA + 2], R10            
    MOV [DEF_TECLA], R10

final_tecla:
    POP R10
    POP R9
    POP R8
    POP R7
    POP R6
    POP R5
    POP R3
    POP R2
    POP R1
    POP R0
    RET

; *********************************************************************************
; desenha_boneco - Desenha um boneco, consoante a sua posição, altura e largura.
;
; Argumentos: R1 - linha do boneco
;             R2 - coluna do boneco
;             R4 - definição do boneco
; *********************************************************************************
desenha_boneco:
	PUSH R1 								; obtem linha do boneco
	PUSH R2 								; obtem coluna do boneco
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R8

	MOV	R5, [R4]							; obtém a largura do boneco
	ADD	R4, 2								; endereço da cor do 1º pixel
	MOV R6, [R4] 							; contador de linhas
	MOV R7, R2   							; valor fixo da coluna
	MOV R8, R5								; valor fixo da largura
	ADD R4, 2								; obtem cor do primeiro pixel

desenha_pixel:       						; ciclo para desenhar os pixeis do boneco
	CMP R6, 0								; vê se ultrapassou limites
	JZ desenha_pixel_fim
	MOV	R3, [R4]							; cor do próximo pixel do boneco
	MOV [DEFINE_LINHA], R1					; seleciona a linha
	MOV [DEFINE_COLUNA], R2					; seleciona a coluna
	MOV [DEFINE_PIXEL], R3					; altera a cor do pixel 
	ADD	R4, 2								; endereço da cor do próximo pixel
    ADD R2, 1             					; próxima coluna
    SUB R5, 1								; menos uma coluna para tratar
	CMP R5, 0
	JZ aumenta_linha_desenhada
	JMP desenha_pixel

desenha_pixel_fim:
	POP R8
	POP R7
	POP R6
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	RET

aumenta_linha_desenhada:
	SUB R6, 1
	ADD R1, 1								; aumenta a linha
	MOV R2, R7								; repõe a coluna à coluna inicial
	MOV R5, R8								; repõe o contador da largura do boneco
	JMP desenha_pixel

; *********************************************************************************
; perde_jogo - Perde o jogo, mudando o estado de jogo, apagando os objetos do
;              do jogo e repondo-os na sua posição inicial. Muda o cenário.
; *********************************************************************************
perde_jogo:
    MOV R4, JOGO_ACABADO
	MOV [ESTADO_JOGO], R4		        ; muda o estado de jogo para acabado
	CALL apaga_bombas			        ; apaga a bomba do ecrã
	CALL apaga_misseis			        ; apaga o missil do ecrã
	MOV R1, 1

	MOV R3, LINHA_BOMBA_ESQ		
	MOV [POS_BOMBA_1], R3				; repor linha bomba 1 à linha inicial
	MOV R2, COLUNA_BOMBA_ESQ
	MOV [POS_BOMBA_1+2], R2				; repor coluna bomba 1 à coluna inicial

	MOV R3, LINHA_BOMBA_MEIO		
	MOV [POS_BOMBA_2], R3				; repor linha bomba 2 à linha inicial
	MOV R2, COLUNA_BOMBA_MEIO
	MOV [POS_BOMBA_2+2], R2				; repor coluna bomba 2 à coluna inicial

	MOV R3, LINHA_BOMBA_MEIO			
	MOV [POS_BOMBA_3], R3				; repor linha bomba 3 à linha inicial
	MOV R2, COLUNA_BOMBA_MEIO
	MOV [POS_BOMBA_3+2], R2				; repor coluna bomba 4 à coluna inicial

	MOV R3, LINHA_BOMBA_DIR			
	MOV [POS_BOMBA_4], R3				; repor linha bomba 3 à linha inicial
	MOV R2, COLUNA_BOMBA_DIR
	MOV [POS_BOMBA_4+2], R2				; repor coluna bomba 4 à coluna inicial

	MOV R3, LINHA_MISSIL		
	MOV R2, COLUNA_MISSIL

	MOV [POS_MISSIL_1], R3				; repor linha missil 1 à linha inicial
	MOV [POS_MISSIL_1+2], R2			; repor coluna missil 1 à coluna inicial
	
	MOV [POS_MISSIL_2], R3				; repor linha missil 1 à linha inicial
	MOV [POS_MISSIL_2+2], R2			; repor coluna missil 1 à coluna inicial
	
	MOV [POS_MISSIL_3], R3				; repor linha missil 1 à linha inicial
	MOV [POS_MISSIL_3+2], R2			; repor coluna missil 1 à coluna inicial

	CALL reset_energia

    MOV R1, 2                           ; muda o cenário para final de jogo
                                        ; quando perdido
    MOV [SELECIONA_CENARIO], R1
    POP R7
	POP R6
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	JMP ciclo
