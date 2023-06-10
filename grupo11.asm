; *********************************************************************************
; Projeto IAC 2022/23 - IST - Versão Final
; Alunos: Maria Ramos(105875), Guilherme Campos(106909), Maria Pereira(105905)
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
PIN 	   EQU 0E002H
TEC_LIN    EQU 0C000H                   ; endereço das linhas do teclado
TEC_COL    EQU 0E000H                   ; endereço das colunas do teclado 
LINHA_TEC  EQU 1                        ; 1ª linha a testar (0001b)
MASCARA    EQU 0FH                      ; para isolar os bits de menor peso

; VALORES ASSOCIADOS AO TECLADO
TECLA 		EQU -1                           ; valor inicial do valor da tecla
TECLA_0 	EQU 0							; valor da tecla 0
TECLA_2 	EQU 2							; valor da tecla 2
TECLA_5 	EQU 5							; valor da tecla 5
TECLA_C 	EQU 12							; valor da tecla C
TECLA_D 	EQU 13							; valor da tecla D
TECLA_E 	EQU 14						    ; valor da tecla E
TECLA_F 	EQU 15						    ; valor da tecla F
ANTERIOR 	EQU -1                          ; valor inicial do valor da tecla anterior

; VALORES ASSOCIADOS AOS OBJETOS DO JOGO
RAPAZ 					EQU 0           ; 1ª opção de personagem
RAPARIGA				EQU 1           ; 2ª opção de personagem

LINHA_PERSONAGEM		EQU  21         ; linha inicial da personagem     	
COLUNA_PERSONAGEM		EQU  15         ; coluna inicial da pesonagem
LARGURA_PERSONAGEM		EQU	 20		    ; largura do desenho da personagem
ALTURA_PERSONAGEM		EQU  11			; altura do desenho da personagem

CINZENTO 				EQU 0          	; 1ª cor possivel para a arma
BRANCO 					EQU 1           ; 2ª cor possivel para a arma
VERMELHO				EQU	2			; 3ª cor possivel para a arma

LINHA_ARMA				EQU	27          ; linha inicial da arma
COLUNA_ARMA				EQU	25          ; coluna inicial da arma
LARGURA_ARMA			EQU	9           ; largura do desenho da arma
ALTURA_ARMA				EQU	5           ; altura do desenho da arma

LINHA_BOMBA_ESQ			EQU	 0          ; linha inicial da bomba à direita
COLUNA_BOMBA_ESQ		EQU	 2          ; coluna inicial da bomba à direita

LINHA_BOMBA_DIR			EQU	 0          ; linha inicial da bomba à esquerda
COLUNA_BOMBA_DIR		EQU	 58         ; coluna inicial da bomba à esquerda

LINHA_BOMBA_MEIO		EQU	 0          ; linha inicial da bomba no meio
COLUNA_BOMBA_MEIO		EQU	 30         ; coluna inicial da bomba no meio

LARGURA_BOMBA		 	EQU	 4          ; largura do desenho da bomba
ALTURA_BOMBA			EQU	 4          ; altura do desenho da bomba

LIMITE_BOMBA 			EQU  3			; limites da bomba consoante largura

LINHA_MISSIL		  	EQU  21 	    ; linha inicial do missil
COLUNA_MISSIL		 	EQU  33 	    ; coluna inicial do missil
LARGURA_MISSIL		 	EQU  1          ; largura do desenho do missil
ALTURA_MISSIL		 	EQU  1          ; altura do desenho do missil
; VALOR ASSOCIADO AO ESTADO DO MISSIL
DESATIVADO 				EQU -1			; estado desativado do missil

; VALORES ASSOCIADOS AOS LIMITES DAS BOMBAS COM O ECRÃ E COM A PERSONAGEM
LIM_COL_PERSONAGEM_ESQ	EQU 34			; limite coluna bomba com personagem
LIM_COL_PERSONAGEM_DIR EQU 20			; limite coluna bomba com personagem
LIM_COL_ESQ	EQU 0						; limite coluna bomba com ecrã	
LIM_COL_DIR	EQU	60						; limite coluna bomba com ecrã
LIM_LIN_PERSONAGEM_DIR EQU 18			; limite linha bomba com personagem
LIM_LIN_PERSONAGEM_MEIO EQU 17			; limite linha bomba com personagem

; VALORES ASSOCIADOS AO ESTADO DAS BOMBAS
NAO_MINERAVEL			EQU  0			; valor associado às bombas não mineraveis
MINERAVEL				EQU	 1			; valor associado às bombas mineraveis

; VALOREES ASSOCIADOS À DIREÇÃO DAS BOMBAS E MISSEIS
DIREITA 				EQU 0			
ESQUERDA				EQU 1
MEIO					EQU 2
; VALORES ASSOCIADOS AOS LIMITES DO ECRÃ

LIMITE_DIREITO 			EQU 64			; limite direito das colunas do ecrã
LIMITE_ESQUERDO 		EQU 0			; limite esquerdo das colunas do ecrã
LIMITE_SUPERIOR			EQU -1			; limite superior das linhas do ecrã

; VALORES ASSOCIADOS AOS SONS
SOM_PERSONAGEM		EQU 0               ; som quando muda personagem 
SOM_MISSIL			EQU 1               ; som quando o missil se ativa
SOM_EXPLOSAO 		EQU 2				; som quando se atinge uma bomba não minerável
SOM_TECLADO 		EQU 3				; som quando se pressiona certas teclas
SOM_ENERGIA			EQU 4				; som quando se atinge bomba minerável
SOM_PERDER 			EQU 5               ; som quando se perde o jogo
REPRODUZ_SOM		EQU COMANDOS + 5AH	; endereço do comando para tocar um som

;VALORES POSSIVEIS PARA A VARIAVEL ESTADO_JOGO
JOGO_ACABADO		EQU 0               ; estado de quando o jogo ainda não começou
JOGO_EM_CURSO		EQU 1               ; estado enquanto o jogo está a decorrer
JOGO_PAUSADO		EQU 2               ; estado de quando o jogo está pausado
;VALOR ASSOSSIADO À ENERGIA
ENERGIA_INICIAL		EQU 100				; energia inicial da personagem

; VALORES ASSICIADOS AOS CENÁRIOS DE JOGO

CENARIO_JOGO 		EQU 0				; valor do cenário de jogo em curso

CENARIO_INICIO		EQU 1				; valor do cenário de início

CENARIO_PERDER 		EQU 2				; valor do cenário de perder

CENARIO_PAUSADO		EQU 3				; valor do cenário de jogo pausado


; *********************************************************************************
; * Zona de Dados
; *********************************************************************************
    PLACE		1000H	
    pilha:      STACK 100H              ; espaço reservado para a pilha 
    topo_pilha:                         ; (200H bytes)

tabela_interrupções:      
    WORD rot_int_arma		            ; interrupção 0 - relógio muda cor da arma e anima explosão
    WORD rot_int_bombas                 ; interrupção 1 - relógio que move bombas
    WORD rot_int_missil                 ; interrupção 2 - relógio que move misséis 
    WORD rot_int_energia                ; interrupção 3	- relógio que decrementa energia

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

POS_PERSONAGEM:                         ; variável que armazena a posição atual
                                        ; da personagem
	WORD LINHA_PERSONAGEM               ; valor da linha atual da personagem
	WORD COLUNA_PERSONAGEM              ; valor da coluna atual da personagem

POS_BOMBA_1:                            ; variável que armazena a posição atual
                                        ; da bomba 1
	WORD LINHA_BOMBA_ESQ	            ; valor da linha atual da bomba
	WORD COLUNA_BOMBA_ESQ	            ; valor da coluna atual da bomba
	WORD DIREITA						; valor inicial da direção da bomba 1
	WORD NAO_MINERAVEL					; valor da bomba não minerável

POS_BOMBA_2:                            ; variável que armazena a posição atual
                                        ; da bomba 2
	WORD LINHA_BOMBA_MEIO	            ; valor da linha atual da bomba
	WORD COLUNA_BOMBA_MEIO	            ; valor da coluna atual da bomba
	WORD ESQUERDA						; valor inicial da direção da bomba 2
	WORD NAO_MINERAVEL					; valor da bomba não minerável

POS_BOMBA_3:                            ; variável que armazena a posição atual
                                        ; da bomba 3
	WORD LINHA_BOMBA_MEIO	            ; valor da linha atual da bomba
	WORD COLUNA_BOMBA_MEIO	            ; valor da coluna atual da bomba
	WORD DIREITA						; valor inicial da direção da bomba 3
	WORD MINERAVEL						; valor da bomba minerável


POS_BOMBA_4:                            ; variável que armazena a posição atual
                                        ; da bomba 3
	WORD LINHA_BOMBA_DIR	            ; valor da linha atual da bomba
	WORD COLUNA_BOMBA_DIR	            ; valor da coluna atual da bomba
	WORD ESQUERDA						; valor inicial da direção da bomba 3
	WORD NAO_MINERAVEL					; valor da bomba não minerável

POS_MISSIL_1:                           ; variável que armazena a posição atual
                                        ; do missil
	WORD LINHA_MISSIL  		            ; valor da linha atual do missil
	WORD COLUNA_MISSIL	                ; valor da coluna atual do missil
	WORD DESATIVADO								; valor associado à direção do missil

POS_MISSIL_2:                           ; variável que armazena a posição atual
                                        ; do missil 2
	WORD LINHA_MISSIL	                ; valor da linha atual do missil
	WORD COLUNA_MISSIL	                ; valor da coluna atual do missil
	WORD DESATIVADO								; valor associado à direção do missil

POS_MISSIL_3:                           ; variável que armazena a posição atual
                                        ; do missil 3
	WORD LINHA_MISSIL	                ; valor da linha atual do missil
	WORD COLUNA_MISSIL	                ; valor da coluna atual do missil
	WORD DESATIVADO						; valor associado à direção do missil

POS_ARMA:								; variável que armazena posição da arma
	WORD LINHA_ARMA
	WORD COLUNA_ARMA

POS_CHOQUE:
	WORD 0								; armazena linha do ultimo choque
	WORD 0								; armzena coluna do ultimo choque

ESTADO_PERSONAGEM:                      ; variável que armazena qual das
                                        ; personagens foi selecionada para o jogo
	WORD RAPAZ 			                ; valor da personagem atual

ENERGIA_PERSONAGEM:                         ; valor associado à energia (display)
	WORD 0         	 	                ; valor atual da energia

INT_ARMA:                           	; variável que indica se se tem de
                                        ; mudar a cor da arma
	WORD 0                              ; 1 - sim, 0 - não

INT_ENERGIA:                            ; variável que indica se se tem de
                                        ; diminuir a energia da nave
	WORD 0                              ; 1 - sim, 0 - não

INT_BOMBAS:								; variável que indica se se tem de
                                        ; mover as bombas
	WORD 0                              ; 1 - sim, 0 - não

INT_MISSIL:								; variável que indica se se tem de
                                        ; mover os mísseis
	WORD 0                              ; 1 - sim, 0 - não
COR_ARMA:                               ; variável que armazena qual a cor atual 
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
                COR_BEGE, COR_BEGE, COR_PRETO, 0, 0, COR_PRETO, 
                COR_CINZENTO, COR_PRETO, COR_PRETO, COR_PRETO, 0, 0, COR_PRETO, 
                COR_VERMELHO, COR_BEGE, COR_VERMELHO, COR_VERMELHO, COR_PRETO, 
                COR_BEGE, COR_BEGE, COR_PRETO, COR_BEGE, COR_PRETO, 0, 
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

DEF_BOMBA_EXPLODIDA:                     ; desenho da bomba 4x4
	WORD 		LARGURA_BOMBA
	WORD		ALTURA_BOMBA
	WORD		0, COR_VERMELHO, COR_VERMELHO, 0, COR_VERMELHO, COR_VERMELHO, COR_VERMELHO, 
				COR_VERMELHO, COR_VERMELHO, COR_VERMELHO, COR_VERMELHO, COR_VERMELHO, 0, COR_VERMELHO, 
				COR_VERMELHO, 0

DEF_BOMBA_MINERAVEL:
	WORD 		LARGURA_BOMBA
	WORD		ALTURA_BOMBA
	WORD		0, COR_PRETO, COR_PRETO, 0, COR_PRETO, COR_VERDE, COR_BRANCO, 
				COR_VERDE, COR_PRETO, COR_BRANCO, COR_CINZENTO, COR_PRETO, 0, 
				COR_PRETO, COR_PRETO, 0

DEF_BOMBA_MINERAVEL_EXP:                  ; desenho da bomba 4x4
	WORD 		LARGURA_BOMBA
	WORD		ALTURA_BOMBA
	WORD		0, COR_VERDE, COR_VERDE, 0, COR_VERDE, COR_VERDE, COR_VERDE, 
				COR_VERDE, COR_VERDE, COR_VERDE, COR_VERDE, COR_VERDE, 0, COR_VERDE, 
				COR_VERDE, 0

DEF_BOMBA_APAGADA:                       ; desenho da bomba apagada 4x4
	WORD 		LARGURA_BOMBA
	WORD		ALTURA_BOMBA
	WORD        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

DEF_MISSIL:                              ; desenho do missil 1x1
	WORD		LARGURA_MISSIL
	WORD		ALTURA_MISSIL
	WORD		COR_AMARELO

DEF_MISSIL_APAGADO:                      ; desenho do missil apagado 1x1
	WORD		LARGURA_MISSIL
	WORD		ALTURA_MISSIL
	WORD		0

DEF_ARMA_APAGADA:                        ; desenho da arma apagada 5x9
	WORD		LARGURA_ARMA
	WORD   		ALTURA_ARMA
	WORD		COR_PRETO, 0, 0, COR_PRETO, 0, COR_PRETO, COR_PRETO, COR_PRETO, 0,
				COR_PRETO, 0, COR_PRETO, 0, 0, COR_PRETO, 0, COR_PRETO, COR_PRETO,
				COR_PRETO, COR_PRETO, 0, 0, COR_PRETO, COR_BEGE, COR_PRETO, 0, 0,
				COR_PRETO, 0, 0, COR_PRETO, COR_PRETO, COR_PRETO, 0, COR_PRETO, 
                COR_PRETO, 0, 0, COR_PRETO, COR_BEGE, COR_BEGE, COR_PRETO, 0, 0, 0

DEF_ARMA_BRANCA:                         ; desenho da arma branca 5x9
	WORD		LARGURA_ARMA
	WORD   		ALTURA_ARMA
	WORD		COR_PRETO, 0, 0, COR_PRETO, COR_BRANCO, COR_PRETO, COR_PRETO, 
                COR_PRETO, 0, COR_PRETO, 0, COR_PRETO, COR_BRANCO, COR_BRANCO, 
                COR_PRETO, COR_BRANCO, COR_PRETO, COR_PRETO, COR_PRETO, COR_PRETO, 
                COR_BRANCO, COR_BRANCO, COR_PRETO, COR_BEGE, COR_PRETO, COR_BRANCO, 
                COR_BRANCO, COR_PRETO, COR_BRANCO, COR_BRANCO, COR_PRETO, 
                COR_PRETO, COR_PRETO, 0, COR_PRETO, COR_PRETO, COR_BRANCO, 
                COR_BRANCO, COR_PRETO, COR_BEGE, COR_BEGE, COR_PRETO, 0, 0, 0


DEF_ARMA_CINZENTA:                       ; desenho da arma cinzenta 5x9
	WORD		LARGURA_ARMA
	WORD   		ALTURA_ARMA
	WORD		COR_PRETO, 0, 0, COR_PRETO, COR_CINZENTO, COR_PRETO, COR_PRETO, COR_PRETO, 0,
				COR_PRETO, 0, COR_PRETO, COR_CINZENTO, COR_CINZENTO, COR_PRETO, COR_CINZENTO, 
                COR_PRETO, COR_PRETO, COR_PRETO, COR_PRETO, COR_CINZENTO, COR_CINZENTO, 
                COR_PRETO, COR_BEGE, COR_PRETO, COR_CINZENTO, COR_CINZENTO, COR_PRETO, 
                COR_CINZENTO, COR_CINZENTO, COR_PRETO, COR_PRETO, COR_PRETO, 0, COR_PRETO, 
                COR_PRETO, COR_CINZENTO, COR_CINZENTO, COR_PRETO, COR_BEGE, COR_BEGE, COR_PRETO, 
                0, 0, 0


DEF_ARMA_VERMELHA:                       ; desenho da arma vermelha 5x9
	WORD		LARGURA_ARMA
	WORD   		ALTURA_ARMA
	WORD		COR_PRETO, 0, 0, COR_PRETO, COR_VERMELHO, COR_PRETO, COR_PRETO, COR_PRETO, 0,
				COR_PRETO, 0, COR_PRETO, COR_VERMELHO, COR_VERMELHO, COR_PRETO, COR_VERMELHO, 
                COR_PRETO, COR_PRETO, COR_PRETO, COR_PRETO, COR_VERMELHO, COR_VERMELHO, 
                COR_PRETO, COR_BEGE, COR_PRETO, COR_VERMELHO, COR_VERMELHO, COR_PRETO, 
                COR_VERMELHO, COR_VERMELHO, COR_PRETO, COR_PRETO, COR_PRETO, 0, COR_PRETO, 
                COR_PRETO, COR_VERMELHO, COR_VERMELHO, COR_PRETO, COR_BEGE, COR_BEGE, COR_PRETO, 
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
	MOV	 R1, CENARIO_INICIO				; cenário de fundo número 0
    MOV  [SELECIONA_CENARIO], R1		; seleciona o cenário de fundo inicial	

    EI0                         		; permite interrupções 0
  	EI1                         		; permite interrupções 1
 	EI2                        			; permite interrupções 2
 	EI3                         		; permite interrupções 3
 	EI                          		; permite interrupções (geral)

	CALL desenha_rapaz                  ; desenha personagem inicial (rapaz)

ciclo:
	CALL teclado                        ; verifica se alguma tecla foi carregada
	CALL chama_comando                  ; chama o comando consoante tecla teclada
	CALL move_bombas					; move todas as bombas no ecrã
	CALL move_misseis					; move todos os misséis no ecrã
	CALL reduzir_energia				; decrementa periodicamente energia do boneco
	CALL muda_cor_arma					; muda a cor da arma da personagem
	JMP ciclo

; *********************************************************************************
; chama_comando - Verifica se a tecla carregada corresponde a algum comando. Se 
;                 sim, chama a rotina adequada.
;
; Comandos:
; 0: atirar missil para a esquerda
; 2: atirar missil para a direita
; 5: atirar missil para cima
; D: pausar jogo
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
	PUSH R8
	PUSH R9
	PUSH R10
	PUSH R11
    MOV R0, [DEF_TECLA]                 ; tecla carregada       
	MOV R2, [DEF_TECLA+2] 	            ; tecla anterior à carregada
	CMP R2, R0 				            ; vê se é a mesma tecla
	JZ fim_chama_comando 	            ; se for, não chama nenhum comando
	
	MOV R3, [ESTADO_JOGO]               ; estado do jogo
	MOV R4, JOGO_ACABADO                
	CMP R4, R3                          ; vê se o jogo está acabado 
	JZ comandos_jogo_acabado            ; se sim, verifica os comandos associados 
                                        ; a esse estado

	MOV R4, JOGO_EM_CURSO               
	CMP R3, R4                          ; vê se o jogo está em curso
	JZ comandos_decorrer_jogo           ; se sim, verifica os comandos associados 
                                        ; a esse estado

	MOV R4, JOGO_PAUSADO               
	CMP R3, R4                          ; vê se o jogo está pausado
	JZ comandos_jogo_pausado            ; se sim, verifica os comandos associados 
                                        ; a esse estado

comandos_jogo_acabado:
	MOV R7, SOM_TECLADO					; obtém som do teclado

	MOV R1, TECLA_C				         
	CMP R1, R0 							; compara tecla primida com a tecla C
    JNZ testa_muda_personagem			
	CALL reproduz_som       
	JMP comeca_jogo                     ; se forem iguais, começa o jogo

testa_muda_personagem:
	MOV R1, TECLA_E				         
	CMP	R1, R0				             ; compara tecla primida com a tecla E
	JNZ fim_chama_comando
	JMP muda_personagem					 ; se forem iguais, muda a personagem

comandos_jogo_pausado:
	MOV R7, SOM_TECLADO					; obtém som do teclado

	MOV R1, TECLA_F  
	CMP R1, R0                           ; compara tecla primida com a tecla F
	JNZ testa_recomeca_jogo 
	CALL reproduz_som
	JMP acaba_jogo    					 ; se forem iguais, acaba o jogo

testa_recomeca_jogo:
	MOV R1, TECLA_C				         ; compara tecla primida com a tecla C
	CMP	R1, R0				             
	JNZ fim_chama_comando
	CALL reproduz_som
	JMP recomeca_jogo					 ; se forem iguais, recomeca_jogo

comandos_decorrer_jogo:
	MOV R7, SOM_TECLADO					 ; obtém som do teclado

	MOV R1, TECLA_0
	CMP R1, R0							 ; compara a tecla com a tecla 0
	JNZ testa_missil_direita
	JMP atira_missil_esquerda			 ; se forem iguais, atira um missil
										 ; para a esquerda	            
 testa_missil_direita:
	MOV R1, TECLA_2
	CMP R1, R0							 ; compara a tecla com a tecla 2
	JNZ testa_missil_cima
	JMP atira_missil_direita			 ; se forem iguais, atira um missil
										 ; para a direita
testa_missil_cima:
	MOV R1, TECLA_5
	CMP R1, R0						     ; compara a tecla com a tecla 5
	JNZ testa_pausa_jogo
	JMP atira_missil_cima				 ; se forem iguais, atira um missil
										 ; para cima
testa_pausa_jogo:
	MOV R1, TECLA_D
	CMP R1, R0							 ; compara a tecla com a tecla D
	JNZ testa_acaba_jogo
	CALL reproduz_som
	JMP pausa_jogo						 ; se forem iguais, pausa o jogo

testa_acaba_jogo:
	MOV R1, TECLA_F  
	CMP R1, R0                           ; compara tecla primida com a tecla F
	JNZ fim_chama_comando 
	CALL reproduz_som
	JMP acaba_jogo                       ; se forem iguais, acaba o jogo

fim_chama_comando:
	POP R11
	POP R10
	POP R9
	POP R8
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
; rot_int_arma - Rotina de atendimento da interrupção 1 em respeito ao 
;				 relógio cor da arma.
;                Altera INT_ARMA para 1 quando há interrupção.
; ******************************************************************************
rot_int_arma:
    PUSH R0
    PUSH R1
    MOV  R0, INT_ARMA
    MOV  R1, 1                  	    ; assinala que houve uma interrupção
    MOV  [R0], R1						; na variável INT_ARMA
    POP  R1
    POP  R0			
    RFE

    
; ******************************************************************************
; rot_int_bombas - Rotina de atendimento da interrupção 1 em respeito ao
;				   relógio bombas.
;			  	   Altera INT_BOMBAS para 1 quando há interrupção.
; ******************************************************************************
rot_int_bombas:
	PUSH R0
    PUSH R1
    MOV  R0, INT_BOMBAS
    MOV  R1, 1                   		; assinala que houve uma interrupção
    MOV  [R0], R1				 		; na variável INT_BOMBAS
    POP  R1
    POP  R0
    RFE

; ******************************************************************************
; rot_int_missil - Rotina de atendimento da interrupção 2 em respeito ao
;				 	relógio misseis.
;			       Altera INT_MISSIL para 1 quando há interrupção.
; ******************************************************************************
rot_int_missil:
	PUSH R0
    PUSH R1
    MOV  R0, INT_MISSIL
    MOV  R1, 1                   		; assinala que houve uma interrupção
    MOV  [R0], R1						; na variável INT_MISSIL
    POP  R1	
    POP  R0
    RFE
    
; ******************************************************************************
; rot_int_energia - Rotina de atendimento da interrupção 3 em respeito ao
;				    relógio energia.
;					Altera INT_ENERGIA para 1 quando há interrupção.
; ******************************************************************************
rot_int_energia:
	PUSH R0
    PUSH R1
    MOV  R0, INT_ENERGIA
    MOV  R1, 1                   		; assinala que houve uma interrupção
    MOV  [R0], R1				 		; na variável INT_ENERGIA
    POP  R1
    POP  R0
    RFE


; ******************************************************************************
; atualiza_energia_inicial - Muda a energia da personagem para 100.
; ******************************************************************************
atualiza_energia_inicial:
    PUSH R0
    PUSH R1
    PUSH R2
    PUSH R3
    PUSH R4
	MOV  R0, ENERGIA_INICIAL			; obtém a energia inicial 
    MOV  R3, ENERGIA_PERSONAGEM		    ; obtém a energia da personagem
    MOV  [R3], R0                       ; atualiza valor da energia
    MOV  R1, 100                        ; primeiro valor do fator
    MOV  R2, 10                         ; para dividir o fator
    MOV  R3, 0                          ; valor a enviar para os displays
	JMP converte						; converte o valor de hexadecimal para decimal
    RET

; ******************************************************************************
; reduzir_energia - Diminui 3 Na energia da personagem (display).
; ******************************************************************************
reduzir_energia:
    PUSH R0
    PUSH R1
	MOV R0, [ESTADO_JOGO]				; obtém estado de jogo
	MOV R1, JOGO_EM_CURSO
	CMP R0, R1							; verifica se jogo está em curso
	JNZ sai_reduzir_energia				; se não, sai 

    MOV R0, INT_ENERGIA					; verifica se houve interrupção
	MOV R0, [R0]
	CMP R0, 0
	JZ sai_reduzir_energia				; se não, sai  


	MOV R0, INT_ENERGIA					; altera interrupção de volta a 0
	MOV R1, 0
	MOV [R0], R1
    MOV R1, ENERGIA_PERSONAGEM          ; obtém energia atual do boneco
    MOV R0, [R1]           
    CMP R0, 0                           ; verifica se a energia é igual a zero
    JZ sai_reduzir_energia              ; se for zero, sai sem decrementar a 
                                        ; energia
    SUB R0, 3                           ; decrementa 3 à energia da nave
    CALL atualiza_energia               ; atualiza o valor na variável e nos 
                                        ; displays

	CMP R0, 0							; verifica se a energia chegou a zero
	JGT sai_reduzir_energia				; se for maior que zero, sai
	JMP perde_jogo						; se for menor ou igual a zero, perde jogo
sai_reduzir_energia:
    POP  R1
    POP  R0
    RET

; ******************************************************************************
; aumentar_energia - Aumenta 25 na energia da personagem (display).
; ******************************************************************************
aumentar_energia:
    PUSH R0
    PUSH R1 
	PUSH R7
	MOV R7, SOM_ENERGIA
	CALL reproduz_som
    MOV  R0, ENERGIA_PERSONAGEM         ; energia atual da personagem
    MOV  R0, [R0]              			; lê energia do da personagem
	MOV  R1, 25
    ADD  R0, R1                         ; incrementa 25 na energia da nave
    CALL atualiza_energia               ; atualiza o valor na variável e nos 
                                        ; displays

sai_aumentar_energia:
	POP R7
    POP R1
    POP R0
    RET

; ********************************************************************************
; diminuir_energia_missil - Diminui a energia da personagem com cada disparo. 
; ********************************************************************************
diminuir_energia_missil:
    PUSH R0
    PUSH R1
    MOV  R1, ENERGIA_PERSONAGEM         ; obtém energia atual da personagem
    MOV  R0, [R1]              			; lê energia 
    SUB  R0, 5                          ; decrementa 5 à energia da nave
    CALL atualiza_energia               ; atualiza o valor na variável e nos 
                                        ; displays
    CMP  R0, 0                          ; verifica se a energia ficou a 0
	JNZ sai_diminuir_energia_missil		; se não, sai
	JMP perde_jogo						; se sim, perde jogo

sai_diminuir_energia_missil:
    POP R1
    POP R0
    RET

; ******************************************************************************
; atualiza_energia - Atualiza a energia da nave, mostrando-a nos displays
;                    após a converter em decimal em decimal.
;
; Argumentos: R3 - Novo valor da energia da nave
; ******************************************************************************
atualiza_energia:
    PUSH R0
    PUSH R1
    PUSH R2
    PUSH R3
    PUSH R4
    MOV  R3, ENERGIA_PERSONAGEM             ; obtém energia da personagem
    MOV  [R3], R0                           ; atualiza valor da energia
    MOV  R1, 100                            ; primeiro valor do fator
    MOV  R2, 10                             ; para dividir o fator
    MOV  R3, 0                              ; valor a enviar para os displays

converte:                                   ; converte o valor da energia 
    MOV  R4, R0                             ; copia o valor
    DIV  R4, R1                             ; divide o valor pelo fator
    MOD  R0, R1                             ; o valor passa a ser o resto
    DIV  R1, R2                             ; divide o fator
    SHL  R3, 4                              ; desloca o valor a enviar
    OR   R3, R4                             ; junta o novo dígito (4 bits)
    CMP  R1, 0                              ; o fator ficou 0 após a divisão
                                            ; ver se era 1 antes de ser dividido
    JNZ  converte                           ; se não, continua a converter
    MOV  R4, DISPLAYS                 	    ; endereço do periférico dos displays
    MOV  [R4], R3                           ; escreve o valor convertido nos displays
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
	PUSH R0
	PUSH R1		
	PUSH R5
	MOV R0, [ESTADO_PERSONAGEM]  		    ; obtém personagem atual
	MOV R1, RAPAZ   
	CMP R1, R0                  		    ; verifica se é o rapaz
	JZ muda_rapaz              			    ; se sim, muda-o para a rapariga
	MOV R7, SOM_PERSONAGEM			        ; som de mudar personagem
	CALL reproduz_som           		    ; reproduz som de mudar personagem
	
muda_rapariga:                              ; muda a rapariga para o rapaz
	CALL apaga_personagem                   ; apaga personagem atual         
	CALL desenha_rapaz                		; desenha nova personagem (rapaz)
	MOV R2, RAPAZ                       
	MOV [ESTADO_PERSONAGEM], R2        		; atualiza estado da personagem
	POP R5
	POP R1
	POP R0
	JMP fim_chama_comando

muda_rapaz:
	CALL apaga_personagem              		; apaga personagem atual
	CALL desenha_rapariga              		; desenha nova personagem (rapariga)
	MOV R2, RAPARIGA
	MOV [ESTADO_PERSONAGEM], R2        	 	; atualiza estado da personagem
	POP R3
	POP R1
	POP R0
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
	PUSH R5
	MOV R5, -1								; verifica se missil está desativado
	CMP R5, R3								
	JZ fim_atualiza_posicao					; se sim, sai	

	MOV R5, ESQUERDA						; verifica se o missíl se move para a esquerda
	CMP R5, R3
	JZ move_esquerda_missil					; se sim, atualiza posição consoante a direção (esquerda)		

	MOV R5, MEIO							; verifica se o missíl se move para o meio
	CMP R5, R3
	JZ move_meio_missil						; se sim. atualiza posição consoante direção (meio)

	MOV R5, DIREITA							; verifica se o missíl se move para a direita
	CMP R5, R3
	JZ move_direita_missil					; se sim, atualiza posição consoante a direção (direita)
	RET

move_esquerda_missil:
	SUB R1, 1								; decrementa 1 na linha atual
	SUB R2, 2								; decrementa 2 na coluna atual
	POP R5
	RET

move_meio_missil:
	SUB R1, 1								; decrementa 1 na linha atual
	POP R5
	RET

move_direita_missil:						
	SUB R1, 1								; decrementa 1 na linha atual
	ADD R2, 2								; incrementa 2 na coluna atual
	POP R5
	RET

fim_atualiza_posicao:
	POP R5
	RET
; ******************************************************************************
; atira_missil - Ativa os mísseis, passando-os de um estado parado (-1) para 
;				 movimento, de acordo com a direção escolhida.
; ******************************************************************************
atira_missil_esquerda:
	PUSH R5
	MOV R5, ESQUERDA						; valor a colocar caso haja algum missil parado
	JMP procura_missil_parado

atira_missil_cima:
	PUSH R5
	MOV R5, MEIO							; valor a colocar caso haja algum missil parado
	JMP procura_missil_parado	
	
atira_missil_direita:
	PUSH R5
	MOV R5, DIREITA							; valor a colocar caso haja algum missil parado
	JMP procura_missil_parado

procura_missil_parado:
	PUSH R1
	PUSH R3
	PUSH R3
	PUSH R7

	MOV R7, SOM_MISSIL

	MOV R1, -1								; estado parado a comparar
	MOV R3, [POS_MISSIL_1+4]
	CMP R1, R3								; compara estado atual do missil 1
	JZ ativa_missil_1						; caso esteja parado, ativa-o

	MOV R1, -1
	MOV R3, [POS_MISSIL_2+4]
	CMP R1, R3								; compara estado atual do missil 2
	JZ ativa_missil_2						; caso esteja parado, ativa-o

	MOV R1, -1
	MOV R3, [POS_MISSIL_3+4]
	CMP R1, R3								; compara estado atual do missil 3
	JZ ativa_missil_3						; caso esteja parado, ativa-o

	MOV R1, LINHA_MISSIL
	MOV R2, COLUNA_MISSIL

	JMP fim_ativa_missil					; se nenhum missil estiver ativo, vai para 
											; o fim do comando

ativa_missil_1:
	CALL reproduz_som						; reproduz som do missil disparado
	CALL diminuir_energia_missil			; decrementa energia ao ativar míssil 1
	MOV [POS_MISSIL_1+4], R5				; atualiza direção com valor escolhido
	JMP fim_ativa_missil

ativa_missil_2:
	CALL reproduz_som						; reproduz som do missil disparado
	CALL diminuir_energia_missil			; decrementa energia ao ativar míssil 2
	MOV [POS_MISSIL_2+4], R5				; atualiza direção com valor escolhido
	JMP fim_ativa_missil

ativa_missil_3:
	CALL reproduz_som						; reproduz som do missil disparado
	CALL diminuir_energia_missil			; decrementa energia ao ativar míssil 3
	MOV [POS_MISSIL_3+4], R5				; atualiza direção com valor escolhido

fim_ativa_missil:
	POP R7
	POP R3
	POP R2
	POP R1
	POP R5
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
	PUSH R5
	PUSH R6
	MOV R6, LIMITE_ESQUERDO					; valor do  limite esquerdo	(-1)
	CMP R6, R2								; ver se o missil ultrapassou esse limite	
	JNZ	limite_direito
	JMP reset_missil						; se sim, repõe-o

limite_direito:
	MOV R6, LIMITE_DIREITO					; valor do limite direito (64)
	CMP R6, R2								; ver se o missil ultrapassou esse limite	
	JNZ limite_superior	
	JMP reset_missil						; se sim, repõe-o

limite_superior:
	MOV R6, LIMITE_SUPERIOR					; valor do limite superior (-1)
	CMP R6, R1								; ver se o missil ultrapassou esse limite	
	JNZ testa_choque_1						; se não, verifica se houve choque
	JMP reset_missil						; se sim, repõe-o

	
testa_choque_1:								; testa choque com a bomba 1
	MOV R5, [POS_BOMBA_1]					; obtém linha bomba 1 (limite superior)
	MOV R6, R5
	ADD R6, LIMITE_BOMBA					; determina limite inferior da bomba 1
	MOV R7, [POS_BOMBA_1+2]					; obtém coluna bomba 1 (limite esquerdo)
	MOV R8, R7					
	ADD R8, LIMITE_BOMBA					; determmina limite direito da bomba 1

	; ver se o missil está dentro dos limites da linha da bomba 1
	CMP R5, R1					
	JGT testa_choque_2
	CMP R6, R1
	JLT testa_choque_2

	; ver se o missil esta dentro dos limites da coluna da bomba 1
	CMP R7, R2
	JGT testa_choque_2
	CMP R8, R2
	JLT testa_choque_2						; se não estiver, testa-se o choque com a bomba 2

	CALL apaga_bomba_1						; apaga a bomba que sofreu um choque
	CALL apaga_explosao						; apaga explosao anterior se existir


	MOV R1, [POS_BOMBA_1]
	MOV R2, [POS_BOMBA_1+2]
	MOV [POS_CHOQUE], R1					; armazena linha do choque
	MOV [POS_CHOQUE+2], R2					; armazena coluna do choque

	MOV R5, [POS_BOMBA_1+6]					; obtém estado da bomba
	CALL desenha_explosao     				; desenha explosão de acordo com estado

	CMP R5, MINERAVEL						; verifica se a bomba atingida é minerável
	JNZ reset_1
	MOV R4, DEF_BOMBA_MINERAVEL_EXP			; obtém a definição de uma bomba minerável explodida
	CALL aumentar_energia					; incrementa na energia 

reset_1:									; repõe bomba e míssil atingidos
	CALL reset_bomba_1

	MOV R1, LINHA_MISSIL					; repõe linha do míssil 
	MOV R2, COLUNA_MISSIL					; repõe coluna do míssil
	MOV R3, DESATIVADO						; repõe estado do míssil para desativado
	POP R6
	POP R5
	RET

testa_choque_2:								; testa choque com a bomba 2
	MOV R5, [POS_BOMBA_2]					; obtém linha bomba 2
	MOV R6, R5
	ADD R6, LIMITE_BOMBA					; determina limite inferior da bomba 2
	MOV R7, [POS_BOMBA_2+2]					; obtém coluna bomba 2
	MOV R8, R7
	ADD R8, LIMITE_BOMBA					; determina limite direito da bomba 2

	; ver se o missil está dentro dos limites da linha da bomba 2
	CMP R5, R1
	JGT testa_choque_3
	CMP R6, R1
	JLT testa_choque_3

	; ver se o missil esta dentro dos limites da coluna da bomba 2
	CMP R7, R2
	JGT testa_choque_3
	CMP R8, R2
	JLT testa_choque_3						; se não estiver, testa-se o choque com a bomba 3

	CALL apaga_bomba_2						; apaga a bomba que sofreu um choque
	CALL apaga_explosao						; apaga explosao anterior se existir

	MOV R1, [POS_BOMBA_2]
	MOV R2, [POS_BOMBA_2+2]
	MOV [POS_CHOQUE], R1					; armazena linha do choque
	MOV [POS_CHOQUE+2], R2					; armazena coluna do choque

	MOV R5, [POS_BOMBA_2+6]					; obtém estado da bomba
	CALL desenha_explosao     				; desenha explosão de acordo com estado

	CMP R5, MINERAVEL						; verifica se a bomba é minerável
	JNZ reset_2								; se sim, incrementa energia
	MOV R4, DEF_BOMBA_MINERAVEL_EXP			; obtém a definição de uma bomba minerável explodida
	CALL aumentar_energia					

reset_2:									; repoe bomba e missil atingidos
	CALL reset_bomba_2

	MOV R1, LINHA_MISSIL					; repõe linha do míssil 
	MOV R2, COLUNA_MISSIL					; repõe coluna do míssil
	MOV R3, DESATIVADO						; repõe estado do míssil para desativado
	POP R6
	POP R5
	RET

testa_choque_3:								; testa choque com a bomba 3
	MOV R5, [POS_BOMBA_3]					; obtém linha bomba 3
	MOV R6, R5								
	ADD R6, LIMITE_BOMBA					; determina limite inferior da bomba 3
	MOV R7, [POS_BOMBA_3+2]					; obtém coluna bomba 3
	MOV R8, R7
	ADD R8, LIMITE_BOMBA					; determina limite direito da bomba 3

	; ver se o missil está dentro dos limites da linha da bomba
	CMP R5, R1
	JGT testa_choque_4
	CMP R6, R1
	JLT testa_choque_4

	; ver se o missil esta dentro dos limites da coluna da bomba
	CMP R7, R2
	JGT testa_choque_4
	CMP R8, R2
	JLT testa_choque_4						; se não estiver, testa-se o choque com a bomba 4

	CALL apaga_bomba_3						; apaga a bomba que sofreu o choque
	CALL apaga_explosao						; apaga explosao anterior se existir

	MOV R1, [POS_BOMBA_3]
	MOV R2, [POS_BOMBA_3+2]
	MOV [POS_CHOQUE], R1					; armazena linha do choque
	MOV [POS_CHOQUE+2], R2					; armazena coluna do choque

	MOV R5, [POS_BOMBA_3+6]					; obtém estado da bomba
	CALL desenha_explosao					; desenha explosão consoante estado da bomba

	CMP R5, MINERAVEL						; verifica se a bomba é minerável
	JNZ reset_3								; se sim, incrementa energia
	MOV R4, DEF_BOMBA_MINERAVEL_EXP			; obtém a definição de uma bomba minerável explodida
	CALL aumentar_energia					

reset_3:									; repõe bomba e missil atingidos
	CALL reset_bomba_3

	MOV R1, LINHA_MISSIL					; repõe linha do míssil
	MOV R2, COLUNA_MISSIL					; repõe coluna do míssil
	MOV R3, DESATIVADO						; repõe estado do míssil para desativado
	POP R6
	POP R5
	RET

testa_choque_4:								; testa choque com a bomba 4
	MOV R5, [POS_BOMBA_4]					; linha bomba 4
	MOV R6, R5
	ADD R6, LIMITE_BOMBA					; limite inferior da bomba 4
	MOV R7, [POS_BOMBA_4+2]					; coluna bomba 4
	MOV R8, R7
	ADD R8, LIMITE_BOMBA					; limite direito da bomba 4

	; ver se o missil está dentro dos limites da linha da bomba
	CMP R5, R1
	JGT fim_limites_missil
	CMP R6, R1
	JLT fim_limites_missil

	; ver se o missil esta dentro dos limites da coluna da bomba
	CMP R7, R2
	JGT fim_limites_missil		
	CMP R8, R2
	JLT fim_limites_missil					; se não estiver, já se testou todos os limites 

	CALL apaga_bomba_4						; apaga a bomba que sofreu um choque
	CALL apaga_explosao						; apaga explosao anterior se existir

	MOV R1, [POS_BOMBA_4]
	MOV R2, [POS_BOMBA_4+2]
	MOV [POS_CHOQUE], R1					; armazena linha do choque
	MOV [POS_CHOQUE+2], R2					; armazena coluna do choque
	MOV [POS_CHOQUE+2], R2

	MOV R5, [POS_BOMBA_4+6]					; obtém estado da bomba
	CALL desenha_explosao					; desenha explosão consoante estado da bomba


	CMP R5, MINERAVEL 						; verifica se a bomba é minerável
	JNZ reset_4								; se sim, incrementa energia
	MOV R4, DEF_BOMBA_MINERAVEL_EXP			; obtém a definição de uma bomba minerável explodida
	CALL aumentar_energia

reset_4:									; repõe bomba e missil atingidos
	CALL reset_bomba_4

	MOV R1, LINHA_MISSIL					; repõe linha do míssil 
	MOV R2, COLUNA_MISSIL					; repõe coluna do míssil
	MOV R3, DESATIVADO						; repõe estado do míssil
	POP R6
	POP R5
	RET

fim_limites_missil:
	POP R6
	POP R5
	RET

reset_missil:
	MOV R1, LINHA_MISSIL					; repõe linha do missil 
	MOV R2, COLUNA_MISSIL					; repõe coluna do missil
	MOV R3, DESATIVADO						; repõe estado do missil a parado (-1)
	POP R6
	POP R5
	RET

; ******************************************************************************
; desenha_explosao - Desenha uma explosão após choque de um míssil com bomba. 
; ******************************************************************************
desenha_explosao:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R7
	MOV R1, [POS_CHOQUE]					; obtém linha do último choque
	MOV R2, [POS_CHOQUE+2]					; obtém coluna do último choque 
	MOV R4, DEF_BOMBA_EXPLODIDA				; obtém a definição de bomba explodida
	MOV R3, MINERAVEL
	CMP R5, R3								; verifica se a bomba é minerável
	JNZ desenha_explosao_fim				; se sim, obtém definição de bomba minerável explodida
	MOV R4, DEF_BOMBA_MINERAVEL_EXP	
desenha_explosao_fim:
	CALL desenha_boneco						; desenha explosão consoante estado
	MOV R7, SOM_EXPLOSAO					; obtém som de explosão
	CALL reproduz_som						; reproduz som de explosão
	POP R7
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	RET

; ******************************************************************************
; apaga_explosao - Apaga uma explosão após choque de um míssil com bomba. 
; ******************************************************************************
apaga_explosao:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	MOV R1, [POS_CHOQUE]					; obtém linha do último choque
	MOV R2, [POS_CHOQUE+2]					; obtém coluna do último choque 

	MOV R4, DEF_BOMBA_APAGADA				; obtém definição de bomba apagada
	CALL desenha_boneco						; desenha bomba apagada
apaga_explosao_fim:							
	MOV R1, -1								
	MOV R2, -1
	MOV [POS_CHOQUE], R1					; repõe a linha do último choque 
	MOV [POS_CHOQUE+2], R2  				; repõe a coluna do último choque 
	POP R4
	POP R3
	POP R2
	POP R1
	RET

; ******************************************************************************
; move_missil - Move os mísseis ativos uma linha para cima consoante a sua 
;				direção:
;				- Direita: Uma linha para cima e duas colunas para a direita
;				- Esquerda: Uma linha para cima e duas colunas para a esquerda
;				- Meio: Uma linha para cima
; ******************************************************************************
move_misseis:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R8
	PUSH R9
	MOV R0, [ESTADO_JOGO]				; obtém o estado do jogo
	MOV R1, JOGO_EM_CURSO
	CMP R0, R1 							;  se estiver em curso, continua
	JNZ sai_move_misseis				;  se não, sai

	MOV  R0, INT_MISSIL
    MOV  R0, [R0]
    CMP  R0, 1                  		; houve uma interrupção para mover o míssil?
    JNZ  sai_move_misseis	    		; se não, sai

	MOV R0, INT_MISSIL					; assinala a interrupção de volta a zero
	MOV R1, 0
	MOV [R0], R1

	CALL apaga_missil_1                 ; apaga o missil na posição antiga
	MOV R1, [POS_MISSIL_1]				; obtém linha atual
	MOV R2, [POS_MISSIL_1+2]            ; obtém coluna atual
	MOV R3, [POS_MISSIL_1+4]            ; obtém direção do missil

	CALL atualiza_posicao_missil		; atualiza posição do míssil

	MOV [POS_MISSIL_1], R1              ; atualiza valor da linha
	MOV [POS_MISSIL_1+2], R2            ; atualiza valor da colunas

	CALL testa_limites_missil			; vê se o míssil ultrapassou os limites
						 				; do ecrã ou se ocorreu um choque.

	MOV [POS_MISSIL_1], R1              ; atualiza valor da linha
	MOV [POS_MISSIL_1+2], R2            ; atualiza valor da colunas
	MOV [POS_MISSIL_1+4], R3            ; atualiza estado do missil

	CALL desenha_missil_1               ; desenha míssil na nova posição

move_missil_2:
	CALL apaga_missil_2                 ; apaga o missil na posição antiga
	MOV R1, [POS_MISSIL_2]				; obtém a linha atual do míssil
	MOV R2, [POS_MISSIL_2+2]            ; obtém coluna atual do míssil
	MOV R3, [POS_MISSIL_2+4]            ; obtém direção do missil

	CALL atualiza_posicao_missil		; atualiza a posição do míssil

	MOV [POS_MISSIL_2], R1              ; atualiza valor da linha do míssil
	MOV [POS_MISSIL_2+2], R2            ; atualiza valor da colunas do míssil

	CALL testa_limites_missil			; vê se o míssil ultrapassou os limites
						 				; do ecrã ou se ocorreu um choque.

	MOV [POS_MISSIL_2], R1              ; atualiza valor da linha do míssil
	MOV [POS_MISSIL_2+2], R2            ; atualiza valor da colunas do míssil
	MOV [POS_MISSIL_2+4], R3            ; atualiza estado do missil

	CALL desenha_missil_2               ; desenha missil na nova posição

move_missil_3:
	CALL apaga_missil_3                 ; apaga o missil na posição antiga
	MOV R1, [POS_MISSIL_3]				; obtém linha atual do míssil
	MOV R2, [POS_MISSIL_3+2]            ; obtém coluna atual do míssil
	MOV R3, [POS_MISSIL_3+4]            ; obtém direção do missil

	CALL atualiza_posicao_missil		; atualiza posição do míssil

	MOV [POS_MISSIL_3], R1              ; atualiza valor da linha do míssil
	MOV [POS_MISSIL_3+2], R2            ; atualiza valor da colunas	do míssil

	CALL testa_limites_missil			; vê se o míssil ultrapassou os limites
;						 				; do ecrã ou se ocorreu um choque.

	MOV [POS_MISSIL_3], R1              ; atualiza valor da linha do míssil
	MOV [POS_MISSIL_3+2], R2            ; atualiza valor da colunas do míssil
	MOV [POS_MISSIL_3+4], R3            ; atualiza estado do missil

	CALL desenha_missil_3               ; desenha missil na nova posição

sai_move_misseis:
	POP R9
	POP R8
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
; move_bombas - Move as bombas consoante a sua direção atual:
;				- Direita: desce uma linha e avança duas colunas para a direita.
;				- Esquerda: desce uma linha e avança duas colunas 
; 				  para a esquerda.
;				- Meio: desce uma linha.
; ******************************************************************************
move_bombas:
	PUSH R0
    PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R8
	PUSH R9
	MOV R0, [ESTADO_JOGO]				; obtém estado de jogo
	MOV R1, JOGO_EM_CURSO
	CMP R0, R1							; verifica se jogo está em curso
	JNZ sai_move_bombas					; se não, sai 

    MOV R0, INT_BOMBAS    				; verifica se houve interrupção para mover as bombas
	MOV R0, [R0]
	CMP R0, 0
	JZ sai_move_bombas					; se não, sai

	MOV R0, INT_BOMBAS					; assinala a interrupção de volta a zero
	MOV R1, 0
	MOV [R0], R1
	CALL apaga_bomba_1                  ; apaga a bomba na posição antiga
	MOV R1, [POS_BOMBA_1]				; obtém linha atual da bomba 1
	MOV R2, [POS_BOMBA_1+2]             ; obtém coluna atual da bomba 1
	MOV R3, [POS_BOMBA_1+4]             ; obtém direção da bomba 1
	MOV R4, [POS_BOMBA_1+6]             ; obtém estado da bomba 1
	MOV R9, R4							; armazena estado em R9

	CALL atualiza_posicao				; atualiza posição da bomba 1
	
	CALL testa_limites_bomba			; vê se a nova posição ultrapassa limites do ecrã
	MOV [POS_BOMBA_1], R1               ; atualiza valor da linha
	MOV [POS_BOMBA_1+2], R2             ; atualiza valor da colunas
	MOV [POS_BOMBA_1+4], R3 			; atualiza direção
	MOV [POS_BOMBA_1+6], R9				; atualiza estado				

	CALL desenha_bomba_1                ; desenha bomba na nova posição

move_bomba_2:
	CALL apaga_bomba_2                  ; apaga a bomba na posição antiga
	MOV R1, [POS_BOMBA_2]				; obtém linha atual da bomba 2
	MOV R2, [POS_BOMBA_2+2]             ; obtém coluna atual da bomba 2
	MOV R3, [POS_BOMBA_2+4]             ; obtém direção da bomba 2
	MOV R4, [POS_BOMBA_2+6]             ; obtém estado da bomba 2 
	MOV R9, R4							; armazena estado em R9

	CALL atualiza_posicao				; atualiza posição da bomba 2

	CALL testa_limites_bomba			; vê se a nova posição ultrapassa limites do ecrã
	MOV [POS_BOMBA_2], R1               ; atualiza valor da linha da bomba 2
	MOV [POS_BOMBA_2+2], R2             ; atualiza valor da colunas da bomba 2
	MOV [POS_BOMBA_2+4], R3 			; atualiza direção da bomba 2
	MOV [POS_BOMBA_2+6], R9				; atualiza estado da bomba 2

	CALL desenha_bomba_2                ; desenha bomba na nova posição

move_bomba_3:
	CALL apaga_bomba_3                  ; apaga a bomba na posição antiga
	MOV R1, [POS_BOMBA_3]				; obtém linha atual da bomba 3
	MOV R2, [POS_BOMBA_3+2]             ; obtém coluna atual da bomba 3
	MOV R3, [POS_BOMBA_3+4]             ; obtém direção da bomba 3
	MOV R4, [POS_BOMBA_3+6]             ; obtém direção da bomba 3
	MOV R9, R4							; armazena estado em R9

	CALL atualiza_posicao				; atualiza posição da bomba 3

	CALL testa_limites_bomba			; vê se a nova polsição ultrapassa limites
	MOV [POS_BOMBA_3], R1               ; atualiza valor da linha da bomba 3
	MOV [POS_BOMBA_3+2], R2             ; atualiza valor da colunas da bomba 3
	MOV [POS_BOMBA_3+4], R3 			; atualiza direção da bomba 3
	MOV [POS_BOMBA_3+6], R9				; atualiza estado da bomba 3
				
	CALL desenha_bomba_3                ; desenha bomba na nova posição
move_bomba_4:
	CALL apaga_bomba_4                  ; apaga a bomba na posição antiga
	MOV R1, [POS_BOMBA_4]				; obtém linha atual da bomba 4
	MOV R2, [POS_BOMBA_4+2]             ; obtém coluna atual da bomba 4
	MOV R3, [POS_BOMBA_4+4]             ; obtém direção da bomba 4
	MOV R4, [POS_BOMBA_4+6]             ; obtém estado da bomba 4
	MOV R9, R4							; armazena estado em R9

	CALL atualiza_posicao				; atualiza posição da bomba 4

	CALL testa_limites_bomba			; vê se a nova polsição ultrapassa limites
	MOV [POS_BOMBA_4], R1               ; atualiza valor da linha da bomba 4
	MOV [POS_BOMBA_4+2], R2             ; atualiza valor da colunas da bomba 4
	MOV [POS_BOMBA_4+4], R3 			; atualiza direção da bomba 4
	MOV [POS_BOMBA_4+6], R9				; atualiza estado da bomba 4
	
	CALL desenha_bomba_4                ; desenha bomba na nova posição

sai_move_bombas:
	POP R9
	POP R8
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
										
	CMP R6, R3							; vê se a bomba tem direção esquerda
	JNZ limites_direitos				; se não, testa direção direita

	MOV R5, LIM_COL_ESQ					; testar limite inferior esquerdo
	CMP R5, R2							
	JZ reset_bomba						; caso tenha ultrapassado, 
										; repõe a posição da bomba
	MOV R5, LIM_COL_PERSONAGEM_ESQ
	CMP R5, R2							; testar choque com personagem 
	JNZ fim_limites_bomba
	JMP perde_jogo						; se chocou, perde o jogo
	
limites_direitos:						; limites de bombas que caminham 
										; na direção direita

	MOV R6, DIREITA						; vê se a bomba tem direção direita
	CMP R6, R3
	JNZ limites_meio					; se não, testa direção meio

	MOV R5, LIM_COL_DIR					; testar limite inferior direito
	CMP R5, R2							; caso tenha ultrapassado,
	JZ reset_bomba						; repõe a bomba
	
	MOV R5, LIM_LIN_PERSONAGEM_DIR		; testar choque com personagem
	CMP R5, R1							; ver se ultrapassou a linha da personagem
	JNZ fim_limites_bomba				; se não, avança

	MOV R5, LIM_COL_PERSONAGEM_DIR		; testa coluna da bomba para saber se houve								
	CMP R5, R2							; choque com personagem
	JNZ fim_limites_bomba
	JMP perde_jogo						; se sim, perde o jogo

limites_meio:							; limites de bombas que caminham pelo meio
	MOV R5, LIM_LIN_PERSONAGEM_MEIO		; testar choque com personagem
	CMP R5, R1							; testa linha da bomba com limite
	JNZ fim_limites_bomba				
	JMP perde_jogo						; se chocou, perde o jogo

fim_limites_bomba:
	RET

; ******************************************************************************
; reset_bomba - Devolve a bomba ao topo do ecrã quando esta ultrapassa os
; 				limites do ecrã ou ocorre um choque. É colocada numa posição 
;				aleatória (canto esquerdo, meio ou direito com uma direção 
;				também aleatória).
;
; Argumentos: R1 - valor da linha atual 
;			  R2 - valor da coluna atual
;			  R3 - direção em que vai descer
; ******************************************************************************
reset_bomba_1:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R9
	CALL reset_bomba				; gera a posição, direção e estado da bomba 1
	MOV [POS_BOMBA_1], R1			; define a linha da bomba 1 como a inicial gerada
	MOV [POS_BOMBA_1+2], R2			; define a coluna da bomba 1 como a inicial gerada
	MOV [POS_BOMBA_1+4], R3			; define a direção da bomba 1 como a gerada
	MOV [POS_BOMBA_1+6], R9			; define o estado da bomba 1 como o gerado
	POP R9
	POP R3
	POP R2
	POP R1
	RET
	
reset_bomba_2:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R7
	PUSH R9
	CALL reset_bomba				; gera a posição, direção e estado da bomba 2
	MOV [POS_BOMBA_2], R1			; define a linha da bomba 2 como a inicial gerada
	MOV [POS_BOMBA_2+2], R2			; define a coluna da bomba 2 como a inicial gerada
	MOV [POS_BOMBA_2+4], R3			; define a direção da bomba 2 como a gerada
	MOV [POS_BOMBA_2+6], R9			; define o estado da bomba 2 como o gerado
	POP R9
	POP R7
	POP R3
	POP R2
	POP R1
	RET

reset_bomba_3:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R9
	CALL reset_bomba				; gera a posição, direção e estado da bomba 3
	MOV [POS_BOMBA_3], R1			; define a linha da bomba 3 como a inicial gerada
	MOV [POS_BOMBA_3+2], R2			; define a coluna da bomba 3 como a inicial gerada
	MOV [POS_BOMBA_3+4], R3			; define a direção da bomba 3 como a gerada
	MOV [POS_BOMBA_3+6], R9			; define o estado da bomba 3 como o gerado
	POP R9
	POP R3
	POP R2
	POP R1
	RET

reset_bomba_4:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R9
	CALL reset_bomba				; gera a posição, direção e estado da bomba 4
	MOV [POS_BOMBA_4], R1			; define a linha da bomba 4 como a inicial gerada
	MOV [POS_BOMBA_4+2], R2			; define a coluna da bomba 4 como a inicial gerada
	MOV [POS_BOMBA_4+4], R3			; define a direção da bomba 4 como a gerada
	MOV [POS_BOMBA_4+6], R9			; define o estado da bomba 4 como o gerado
	POP R9
	POP R3
	POP R2
	POP R1
	RET

reset_bomba:
	PUSH R4
	PUSH R10
	PUSH R11
	CALL gerador_posicao			; gera um número pseudo-aleatório em R11
									; entre 0 e 4, correspondente a 5 direções possíveis 
	testa_esquerda:								
	CMP R11, 0						; verifica se a posição aleatória é a esquerda
	JNZ testa_meio_esquerdo			; se não for, vai testar o meio esquerdo.
	MOV R1, LINHA_BOMBA_ESQ			; atualiza a linha, coluna e direção da bomba 
	MOV R2, COLUNA_BOMBA_ESQ		; para a inicial
	MOV R3, DIREITA					
	JMP	define_estado				; escolhe se a bomba é minerável ou não

testa_meio_esquerdo:					
	CMP R11, 1						; vê se a posição aleatória é a do meio
	JNZ testa_meio_baixo			; com direção para a esquerda.
	MOV R1, LINHA_BOMBA_MEIO		; atualiza a linha, coluna e direção da bomba 
	MOV R2, COLUNA_BOMBA_MEIO		; para a inicial
	MOV R3, ESQUERDA
	JMP	define_estado				; escolhe se a bomba é minerável ou não

testa_meio_baixo:				
	CMP R11, 2						; vê se a posição aleatória é a do meio
	JNZ testa_meio_direita			; com direção para a direita.
	MOV R1, LINHA_BOMBA_MEIO		; atualiza a linha e coluna da bomba para
	MOV R2, COLUNA_BOMBA_MEIO		; a inicial
	MOV R3, MEIO
	JMP	define_estado				; escolhe se a bomba é minerável ou não

testa_meio_direita:
	CMP R11, 3						; vê se a posição aleatória é a do meio
	JNZ testa_direita				; com direção para a direita
	MOV R1, LINHA_BOMBA_MEIO		; atualiza a linha e coluna da bomba para
	MOV R2, COLUNA_BOMBA_MEIO		; a inicial
	MOV R3, DIREITA
	JMP	define_estado				; escolhe se a bomba é minerável ou não

testa_direita:
	MOV R1, LINHA_BOMBA_DIR			; atualiza a linha e coluna da bomba para
	MOV R2, COLUNA_BOMBA_DIR		; a inicial
	MOV R3, ESQUERDA

define_estado:
	CALL gerador_mineravel			; gera um número aleatório de 0-3 em R10	
	MOV R9, NAO_MINERAVEL		
	CMP R10, 1						; se o número for 1, a bomba é mineravel
	JNZ fim_reset_bomba
	MOV R9, MINERAVEL				; caso contrário, a bomba é não minerável
fim_reset_bomba:
	POP R11
	POP R10
	POP R4
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
	JNZ move_meio						; se não testa se desce para o meio
	ADD R1, 1							; diminui uma linha
	SUB R2, 1							; diminui uma coluna
	RET

move_meio:
	MOV R5, MEIO						; ver se desce para o meio, se sim
	CMP R5, R3							; atualiza valores
										; se não testa se desce para a direita
	JNZ move_direita					
	ADD R1, 1							; diminui uma linha
	RET 

move_direita:							; atualiza posição quando desce para a direita
	ADD R1, 1                           ; aumenta uma linha
	ADD R2, 1                           ; aumenta duas colunas
	RET

; ******************************************************************************
; comeca_jogo - Começa o jogo, mudando o estado de jogo e desenhando os objetos
;               associados ao decorrer do jogo.
; ******************************************************************************
comeca_jogo:
	PUSH R4
	PUSH R1
	MOV R4, JOGO_EM_CURSO
	MOV [ESTADO_JOGO], R4		        ; muda o estado de jogo para em curso

	CALL atualiza_energia_inicial		; muda energia da personagem para 100
	CALL desenha_missil_1				; desenha o míssil 1 no ecrã
	CALL desenha_missil_2				; desenha o míssil 2 no ecrã
	CALL desenha_missil_3				; desenha o míssil 3 no ecrã
	CALL desenha_bomba_1			    ; desenha bomba 1 no ecrã
	CALL desenha_bomba_2				; desenha bomba 2 no ecrã
	CALL desenha_bomba_3				; desenha bomba 3 no ecrã
	CALL desenha_bomba_4				; desenha bomba 4 no ecrã
	MOV R1, CENARIO_JOGO
	MOV  [SELECIONA_CENARIO], R1        ; altera para cenário do jogo
	POP R1
	POP R4

	JMP fim_chama_comando				

; ********************************************************************************
; recomeca_jogo - Recomeça o jogo após pausado, mudando o estado de jogo e cenário.
; ********************************************************************************
recomeca_jogo:
	PUSH R1
	PUSH R4
	MOV	 R1, CENARIO_JOGO					
    MOV  [SELECIONA_CENARIO], R1		; altera para o cenário de jogo
	MOV R4, JOGO_EM_CURSO
	MOV [ESTADO_JOGO], R4		        ; muda o estado de jogo para em curso
	POP R4
	POP R1
	JMP fim_chama_comando

; ******************************************************************************
; pausa_jogo - Pausa o jogo, mudando o estado de jogo e o cenário.
; ******************************************************************************
pausa_jogo:
	PUSH R1
	PUSH R4
	MOV	 R1, CENARIO_PAUSADO					
    MOV  [SELECIONA_CENARIO], R1		; seleciona o cenário de fundo inicial
	MOV R4, JOGO_PAUSADO
	MOV [ESTADO_JOGO], R4		        ; muda o estado de jogo para pausado
	POP R4
	POP R1
	JMP fim_chama_comando
	
; ******************************************************************************
; acaba_jogo - Acaba o jogo, mudando o estado de jogo, apagando os objetos do
;              do jogo e repondo-os na sua posição inicial.
; ******************************************************************************
acaba_jogo:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	CALL apaga_explosao					; apaga explosao anterior se existir
	MOV R4, JOGO_ACABADO
	MOV [ESTADO_JOGO], R4		        ; muda o estado de jogo para acabado
	CALL apaga_bombas			        ; apaga as bombas do ecrã
	CALL apaga_misseis			        ; apaga os míssil do ecrã

	CALL  repor_misseis_bombas			; repõe os misseis e as bombas
										; às posições iniciais

	CALL reset_energia					; repõe energia do boneco a zero
	CALL apaga_ecra						; limpa o ecrã
	MOV R0, [ESTADO_PERSONAGEM]         ; obtém personagem atual
	MOV R2, RAPAZ   
	CMP R2, R0                          ; verifica se é o rapaz
	JNE testa_rapariga            		; se não, desenha rapariga 
	CALL desenha_rapaz            		; se sim, desenha rapaz
	JMP fim_acaba_jogo                      

	testa_rapariga:
	CALL desenha_rapariga        		; desenha rapariga

	fim_acaba_jogo:

    MOV R1, CENARIO_INICIO							
    MOV [SELECIONA_CENARIO], R1			; seleciona cenário início de jogo	
	POP R4
	POP R3
	POP R2
	POP R1
	JMP fim_chama_comando

; ******************************************************************************
; reset_energia - Repõe energia a zeros após o jogo ter acabado.
; ******************************************************************************
reset_energia:
	PUSH R0
	PUSH R1
	MOV R0, INT_ENERGIA  
	MOV R1, ENERGIA_PERSONAGEM 			; obtém energia da personagem
	MOV R0, [R1]				        ; lê a energia do boneco
	MOV R0, 0					        ; muda a energia para zero
	call atualiza_energia		        ; atualiza valor na variável e displays
	CMP R0, 0					        ; compara energia do boneco a zero
	JZ fim_reset_energia		        ; se zero, sai

fim_reset_energia:
	POP R1
	POP R0
	RET

; ******************************************************************************
; reproduz_som - Reproduz um dado som.
; Argumentos - R7 - Número do som a reproduzir
; ******************************************************************************
reproduz_som:
    PUSH R1
    MOV R1, REPRODUZ_SOM				; obtém endereço comando que reproduz som
    MOV [R1], R7						; reproduz som selecionado em R7
    POP R1
    RET

; ******************************************************************************
; gerador_mineravel - Gera valores pseudo-aleatórios para escolher se uma bomba
;					  é minerável ou não. (0,2,3 - não minerável ; 1 - minerável).
;					  Usa PIN que bits "no ar".
; Argumentos - R10 - Número pseudo-aleatório entre 0 e 3
; ******************************************************************************
gerador_mineravel:
	PUSH R0 
	PUSH R1
	MOV R0, PIN								; carrega endereço do periférico PIN 						
	MOV R10, [R0]							; lê valor do periférico e guarda 

	MOV R0, 15								; define o valor 15 (1111 em binário)
	SHR R10, 4								; descarta os 4 bits de menor peso
	AND R10, R0								; mantém apenas os bits de menor peso
	ADD R10, 1								; adiciona 1 para garantir um valor entre 1 e 4

	MOV R1, 4								; divide valor por 4
	MOD R10, R1								; guarda o resto da divisão por 4 (0 a 3)
	
	fim_gerador_mineravel:
		POP R1 
		POP R0
		RET
; ******************************************************************************
; gerador_posicao - gera valores pseudo-aleatórios para escolher a posicao de uma
;					bomba.
;					(0- esquerda 1- meio esquerda  2- meio baixo 3- meio direta 
;					 4-	direita)
; Argumentos - R11 - Número pseudo-aleatório entre 0 e 4
; ******************************************************************************
gerador_posicao:
	PUSH R0 
	PUSH R6
	MOV R0, PIN 							; carrega endereço do periférico PIN 						
	MOV R11, [R0]							; lê valor do periférico e guarda

	MOV R0, 15								; define o valor 7 (0111 em binário) em R0
	SHR R11, 4								; descarta os 4 bits de menor peso
	AND R11, R0								; mantém apenas os bits de menor peso
	ADD R11, 1								; adiciona 1 para garantir valor entre 1 e 5

	MOV R6, 5								; divide o valor por 5
	MOD R11, R6								; guarda resto da divisao por 5 (0 a 4)
	
fim_gerador_posicao:
	POP R6 
	POP R0
	RET

; ******************************************************************************
; apaga_misseis - Apaga todos os mísseis no ecrã.
; apaga_missil - Apaga o missil na sua posição atual.
; ******************************************************************************
apaga_misseis:	
	CALL apaga_missil_1					; apaga míssil 1
	CALL apaga_missil_2					; apaga míssil 2
	CALL apaga_missil_3					; apaga míssil 3
	RET

apaga_missil_1:
	PUSH R1
	PUSH R2
	PUSH R4
	MOV R1, [POS_MISSIL_1] 		        ; obtém linha atual do missil 1
	MOV R2, [POS_MISSIL_1+2] 		    ; obtém coluna atual do missil 1
	MOV R4, DEF_MISSIL_APAGADO	        ; obtém definição do missil apagado 
	CALL desenha_boneco					; desenha míssil apagado
	POP R4
	POP R2
	POP R1
	RET

apaga_missil_2:
	PUSH R1
	PUSH R2
	PUSH R4
	MOV R1, [POS_MISSIL_2] 		        ; obtém linha atual do missil 2
	MOV R2, [POS_MISSIL_2+2] 		    ; obtém coluna atual do missil 2
	MOV R4, DEF_MISSIL_APAGADO	        ; obtém definição do missil apagado 
	CALL desenha_boneco					; desenha míssil apagado
	POP R4
	POP R2 
	POP R1
	RET

apaga_missil_3:
	PUSH R1
	PUSH R2
	PUSH R4
	MOV R1, [POS_MISSIL_3] 		        ; obtém linha atual do missil 3
	MOV R2, [POS_MISSIL_3+2] 		    ; obtém coluna atual do missil 3
	MOV R4, DEF_MISSIL_APAGADO	        ; obtém definição do missil apagado 
	CALL desenha_boneco					; desenha míssil apagado
	POP R4
	POP R2
	POP R1
	RET

; ******************************************************************************
; apaga_bombas - Apaga todas as bombas do ecrã.
; apaga_bomba -  Apaga a bomba indicada na sua posição atual.
; ******************************************************************************
apaga_bombas:
	CALL apaga_bomba_1					; apaga bomba 1
	CALL apaga_bomba_2					; apaga bomba 2
	CALL apaga_bomba_3					; apaga bomba 3
	CALL apaga_bomba_4					; apaga bomba 4
	RET

apaga_bomba_1:
	PUSH R1
	PUSH R2
	PUSH R4
	MOV R1, [POS_BOMBA_1] 		        ; obtém linha atual da bomba 1
	MOV R2, [POS_BOMBA_1+2] 		    ; obtém coluna atual da bomba 1
	MOV R4, DEF_BOMBA_APAGADA           ; obtém definição da bomba apagada 
	CALL desenha_boneco					; desenha bomba apagada
	POP R4
	POP R2
	POP R1
	RET

apaga_bomba_2:
	PUSH R1
	PUSH R2
	PUSH R4
	MOV R1, [POS_BOMBA_2] 		        ; obtém linha atual da bomba 2
	MOV R2, [POS_BOMBA_2+2] 		    ; obtém coluna atual da bomba 2
	MOV R4, DEF_BOMBA_APAGADA           ; obtém definição da bomba apagada 
	CALL desenha_boneco					; desenha bomba apagada
	POP R4
	POP R2
	POP R1
	RET

apaga_bomba_3:
	PUSH R1
	PUSH R2
	PUSH R4
	MOV R1, [POS_BOMBA_3] 		        ; obtém linha atual da bomba 3
	MOV R2, [POS_BOMBA_3+2] 		    ; obtém coluna atual da bomba 3
	MOV R4, DEF_BOMBA_APAGADA           ; obtém definição da bomba apagada 
	CALL desenha_boneco					; desenha bomba apagada
	POP R4
	POP R2
	POP R1
	RET

apaga_bomba_4:
	PUSH R1
	PUSH R2
	PUSH R4
	MOV R1, [POS_BOMBA_4] 		        ; obtém linha atual da bomba 4
	MOV R2, [POS_BOMBA_4+2] 		    ; obtém coluna atual da bomba 4
	MOV R4, DEF_BOMBA_APAGADA           ; obtém definição da bomba apagada 
	CALL desenha_boneco					; desenha bomba apagada
	POP R4
	POP R2
	POP R1
	RET

; ******************************************************************************
; apaga_personagem - Apaga a personagem.
; ******************************************************************************
apaga_personagem:
	PUSH R1
	PUSH R2
	PUSH R4
	MOV R1, [POS_PERSONAGEM] 		    ; obtém linha da personagem
	MOV R2, [POS_PERSONAGEM+2] 		    ; obtém coluna da personagem
	MOV R4, DEF_PERSONAGEM_APAGADA	    ; obtém definição da personagem apagada 
	CALL desenha_boneco
	POP R4
	POP R2
	POP R1
	RET

; ******************************************************************************
; desenha_rapaz - Desenha o rapaz na sua posição definida.
; ******************************************************************************
desenha_rapaz:
	PUSH R1
	PUSH R2
	PUSH R4
	MOV R1, [POS_PERSONAGEM] 		    ; obtém linha do rapaz
	MOV R2, [POS_PERSONAGEM+2] 		    ; obtém coluna do rapaz
	MOV R4, DEF_RAPAZ			        ; obtém definição do rapaz
	CALL desenha_boneco					; desenha rapaz
	POP R4
	POP R2
	POP R1
	RET

; ******************************************************************************
; desenha_rapariga - Desenha a rapariga na sua posição definida.
; ******************************************************************************
desenha_rapariga:
	PUSH R1
	PUSH R2
	PUSH R4
	MOV R1, [POS_PERSONAGEM] 		    ; obtém linha da rapariga
	MOV R2, [POS_PERSONAGEM+2] 		    ; obtém coluna da rapariga
	MOV R4, DEF_RAPARIGA			    ; obtém definição da rapariga
	CALL desenha_boneco					; desenha rapariga
	POP R4
	POP R2
	POP R1
	RET

; ******************************************************************************
; desenha_missil - Desenha o missil na sua posição definida.
; ******************************************************************************
desenha_missil_1:
	PUSH R1
	PUSH R2
	PUSH R4
	MOV R1, [POS_MISSIL_1] 		        ; obtém linha atual do missil 1
	MOV R2, [POS_MISSIL_1+2] 		    ; obtém coluna atual do missil 1
	MOV R4, DEF_MISSIL			        ; obtém definição do missil 1
	CALL desenha_boneco					; desenha míssil 1
	POP R4
	POP R2
	POP R1
	RET

desenha_missil_2:
	PUSH R1
	PUSH R2
	PUSH R4
	MOV R1, [POS_MISSIL_2] 		        ; obtém linha atual do missil 2
	MOV R2, [POS_MISSIL_2+2] 		    ; obtém coluna atual do missil 2
	MOV R4, DEF_MISSIL			        ; obtém definição do missil 2
	CALL desenha_boneco					; desenha míssil 2
	POP R4
	POP R2
	POP R1
	RET

desenha_missil_3:
	PUSH R1
	PUSH R2
	PUSH R4
	MOV R1, [POS_MISSIL_3] 		        ; obtém linha atual do missil 3
	MOV R2, [POS_MISSIL_3+2] 		    ; obtém coluna atual do missil 3
	MOV R4, DEF_MISSIL			        ; obtém definição do missil 3
	CALL desenha_boneco					; desenha míssil 3
	POP R4
	POP R2
	POP R1
	RET

; ******************************************************************************
; desenha_bomba - Desenha a bomba na sua posição definida.
; ******************************************************************************
desenha_bomba_1:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	MOV R1, [POS_BOMBA_1] 		        ; obtém linha atual da bomba 1
	MOV R2, [POS_BOMBA_1+2] 		    ; obtém coluna atual da bomba 1
	MOV R4, DEF_BOMBA					; obtém definição da bomba 1
	MOV R3, NAO_MINERAVEL				
	MOV R5, [POS_BOMBA_1+6]				; obtém estado da bomba 1
	CMP R3, R5							; verifica se é não minerável
	JZ fim_bomba_1
	MOV R4, DEF_BOMBA_MINERAVEL			; se for mineravel, muda a definição

fim_bomba_1:
	CALL desenha_boneco					; desenha bomba 1
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	RET

desenha_bomba_2:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	MOV R1, [POS_BOMBA_2] 		        ; obtém linha atual da bomba 2
	MOV R2, [POS_BOMBA_2+2] 		    ; obtém coluna atual da bomba 2
	MOV R4, DEF_BOMBA					; obtém definição da bomba 2
	MOV R3, NAO_MINERAVEL				
	MOV R5, [POS_BOMBA_2+6]				; obtém estado da bomba 2
	CMP R3, R5							; verifica se é não minerável
	JZ fim_bomba_2
	MOV R4, DEF_BOMBA_MINERAVEL			; se for mineravel, muda a definição

fim_bomba_2:
	CALL desenha_boneco
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	RET
desenha_bomba_3:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	MOV R1, [POS_BOMBA_3] 		        ; obtém linha atual da bomba 3
	MOV R2, [POS_BOMBA_3+2] 		    ; obtém coluna atual da bomba 3
	MOV R4, DEF_BOMBA					; obtém definição da bomba 3
	MOV R3, NAO_MINERAVEL				
	MOV R5, [POS_BOMBA_3+6]				; obtém estado da bomba 3
	CMP R3, R5							; verifica se é não minerável
	JZ fim_bomba_3
	MOV R4, DEF_BOMBA_MINERAVEL			; se for mineravel, muda a definição

fim_bomba_3:
	CALL desenha_boneco
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	RET

desenha_bomba_4:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	MOV R1, [POS_BOMBA_4] 		        ; obtém linha atual da bomba 4
	MOV R2, [POS_BOMBA_4+2] 		    ; obtém coluna atual da bomba 4
	MOV R4, DEF_BOMBA					; obtém definição da bomba 4
	MOV R3, NAO_MINERAVEL				
	MOV R5, [POS_BOMBA_4+6]				; obtém estado da bomba 4
	CMP R3, R5							; verifica se é não minerável
	JZ fim_bomba_4
	MOV R4, DEF_BOMBA_MINERAVEL			; se for mineravel, muda a definição

fim_bomba_4:
	CALL desenha_boneco
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	RET

; ******************************************************************************
; desenha_arma - Desenha a arma na sua posição e estado. Permite desenhá-la
;				 em branco, cinzento e vermelho.
; ******************************************************************************
desenha_arma:
	PUSH R1
	PUSH R2
	PUSH R3
	MOV R1, CINZENTO    				; obtém cinzento
	MOV R2, [COR_ARMA]                  ; obtém cor da arma
	CMP R1, R2                          ; ver se a cor atual da arma é cinzenta
	JZ muda_arma_branco                 ; se for, muda cor da arma para branco
                                        
	MOV R1, BRANCO						; obtém branco
	CMP R1, R2                          ; ver se a cor atual da arma é branca
	JZ muda_arma_vermelho				; se for, muda cor da arma para vermelho

	JMP muda_arma_cinzento				; se a cor for vernelho, muda para cinzento 

fim_desenha_arma:
	POP R4
	POP R2
	POP R1
	RET

muda_arma_cinzento:
	MOV R1, [POS_ARMA]                  ; obtém linha da arma
	MOV R2, [POS_ARMA+2]                ; obtém coluna da arma
	MOV R4, DEF_ARMA_CINZENTA           ; obtém definição da arma cinzenta
	CALL desenha_boneco					; desenha arma

    MOV R1, CINZENTO                    
    MOV [COR_ARMA], R1                  ; atualiza a cor da arma para cinzento
	JMP fim_desenha_arma

muda_arma_branco:       
	MOV R1, [POS_ARMA]                  ; obtém linha da arma
	MOV R2, [POS_ARMA+2]                ; obtém coluna da arma
	MOV R4, DEF_ARMA_BRANCA	            ; obtém definição da arma branca
	CALL desenha_boneco					; desenha arma
    MOV R1, BRANCO                  
    MOV [COR_ARMA], R1                  ; atualiza a cor da arma para branco
	JMP fim_desenha_arma

muda_arma_vermelho:       
	MOV R1, [POS_ARMA]                  ; obtém linha da arma
	MOV R2, [POS_ARMA+2]                ; obtém coluna da arma
	MOV R4, DEF_ARMA_VERMELHA           ; obtém definição da arma vermelha
	CALL desenha_boneco					; desenha arma
    MOV R1, VERMELHO                  
    MOV [COR_ARMA], R1                  ; atualiza a cor da arma para vermelho
	JMP fim_desenha_arma

; ******************************************************************************
; muda_cor_arma - Muda a cor da arma quando há uma iinterrupção no relógio da 
;				  arma quando o jogo está em curso.
; ******************************************************************************
muda_cor_arma:
    PUSH R1
    PUSH R2
    PUSH R3
    PUSH R4
    MOV R1, JOGO_EM_CURSO				
    MOV R2, [ESTADO_JOGO]				; obtém estado de jogo
	CMP R1, R2							; se estiver em curso, continua
    JNZ fim_muda_cor_arma				; se não, sai

	MOV R0, INT_ARMA    				; verifica se houve interrupção para mudar cor da arma
	MOV R0, [R0]
	CMP R0, 0
	JZ fim_muda_cor_arma				; se não, sai

	MOV R0, INT_ARMA					; assinala a interrupção de volta a zero
	MOV R1, 0
	MOV [R0], R1
	CALL desenha_arma					; desenha arma com a pŕoxima cor

	CALL apaga_explosao					; permite apagar explosoes no mesmo compasso que muda arma
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
    MOV  R5, MASCARA                    ; máscara para isolar os bits de menor peso
    MOV  R7, 0
    MOV  R8, 0
    MOV  R9, 4

ciclo_tecla:
    MOV  R1, 0                          
    MOV  R6, LINHA_TEC                  ; inserir linha que será testada em R6

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
    SHR R0, 1                           ; anda 1 para trás na ordem 1,2,4,8
    CMP R0, 0                           
    JNZ transforma_coluna_tecla_aux

valor_tecla:							; calcula valor da tecla
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
	PUSH R1 								; linha do boneco
	PUSH R2 								; coluna do boneco
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
	ADD R4, 2								; cor do primeiro pixel

desenha_pixel:       						; ciclo para desenhar os pixeis do boneco
	CMP R6, 0								; vê se ultrapassou limites
	JZ desenha_pixel_fim
	MOV	R3, [R4]							; cor do próximo pixel do boneco
	MOV [DEFINE_LINHA], R1					; obtém a linha 
	MOV [DEFINE_COLUNA], R2					; obtém coluna 
	MOV [DEFINE_PIXEL], R3					; altera a cor do pixel 
	ADD	R4, 2								; endereço da cor do próximo pixel
    ADD R2, 1             					; seleciona próxima coluna
    SUB R5, 1								; menos uma coluna para tratar
	CMP R5, 0								; verifica se já chegou ao fim da linha
	JZ aumenta_linha_desenhada				; se sim, muda para a próxima linha a desenhar
	JMP desenha_pixel						; se não, desenha próximo pixel

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
	SUB R6, 1								; menos uma linha no contador 
	ADD R1, 1								; aumenta a linha
	MOV R2, R7								; repõe a coluna à coluna inicial
	MOV R5, R8								; repõe o contador da largura do boneco
	JMP desenha_pixel
; *********************************************************************************
; apaga_ecra - Apaga todos os pixeis do ecrã. 
; *********************************************************************************
apaga_ecra:
	PUSH R0
	MOV R0, APAGA_ECRA						; obtém endereço comando que apaga ecrã
	MOV [R0], R0							; apaga ecrã 
	POP R0
	RET
; *********************************************************************************
; repor_misseis_bombas - Reinicia as posições de todos os mísseis e bombas.
; 						 É chamada sempre que o jogo é perdido ou acaba. 
; *********************************************************************************
repor_misseis_bombas:

	MOV R2, LINHA_BOMBA_ESQ		
	MOV [POS_BOMBA_1], R2				; repõe linha da bomba 1 à linha inicial
	MOV R2, COLUNA_BOMBA_ESQ
	MOV [POS_BOMBA_1+2], R2				; repõe coluna da bomba 1 à coluna inicial
	MOV R2, DIREITA
	MOV [POS_BOMBA_1+4], R2				; repõe doreção da bomba 1 a direita
	MOV R2, NAO_MINERAVEL				
	MOV [POS_BOMBA_1+6], R2				; repõe direção da bomba 1 a não minerável

	MOV R2, LINHA_BOMBA_MEIO		
	MOV [POS_BOMBA_2], R2				; repõe linha da bomba 2 à linha inicial
	MOV R2, COLUNA_BOMBA_MEIO
	MOV [POS_BOMBA_2+2], R2				; repõe coluna da bomba 2 à coluna inicial
	MOV R2, ESQUERDA
	MOV [POS_BOMBA_2+4], R2				; repõe doreção da bomba 1 a esquerda
	MOV R2, NAO_MINERAVEL
	MOV [POS_BOMBA_2+6], R2				; repõe direção da bomba 1 a não minerável

	MOV R2, LINHA_BOMBA_MEIO			
	MOV [POS_BOMBA_3], R2				; repõe linha da bomba 3 à linha inicial
	MOV R2, COLUNA_BOMBA_MEIO
	MOV [POS_BOMBA_3+2], R2				; repõe coluna da bomba 4 à coluna inicial
	MOV R2, DIREITA
	MOV [POS_BOMBA_3+4], R2				; repõe doreção da bomba 1 a direita
	MOV R2, MINERAVEL
	MOV [POS_BOMBA_3+6], R2				; repõe direção da bomba 1 a minerável

	MOV R3, LINHA_BOMBA_DIR			
	MOV [POS_BOMBA_4], R3				; repõe linha da bomba 3 à linha inicial
	MOV R2, COLUNA_BOMBA_DIR
	MOV [POS_BOMBA_4+2], R2				; repõe coluna da bomba 4 à coluna inicial
	MOV R2, ESQUERDA
	MOV [POS_BOMBA_4+4], R2				; repõe doreção da bomba 1 a esquerda
	MOV R2,NAO_MINERAVEL
	MOV [POS_BOMBA_4+6], R2				; repõe direção da bomba 1 a não minerável

	MOV R3, LINHA_MISSIL				; obtém linha inicial dos mísseis
	MOV R2, COLUNA_MISSIL				; obtém coluna inicial dos mísseis
	MOV R4, DESATIVADO					; obtém estado inicial dos mísseis

	MOV [POS_MISSIL_1], R3				; repõe linha do missil 1 à linha inicial
	MOV [POS_MISSIL_1+2], R2			; repõe coluna do missil 1 à coluna inicial
	MOV [POS_MISSIL_1+4], R4			; repõe estado do míssil 1 a desativado
	
	MOV [POS_MISSIL_2], R3				; repõe linha missil 2 à linha inicial
	MOV [POS_MISSIL_2+2], R2			; repõe coluna missil 2 à coluna inicial
	MOV [POS_MISSIL_2+4], R4			; repõe estado do míssil 2 a desativado

	MOV [POS_MISSIL_3], R3				; repõe linha missil 3 à linha inicial
	MOV [POS_MISSIL_3+2], R2			; repõe coluna missil 3 à coluna inicial
	MOV [POS_MISSIL_3+4], R4			; repõe estado do míssil 3 a desativado
	RET

; *********************************************************************************
; perde_jogo - Perde o jogo, mudando o estado de jogo, apagando os objetos do
;              do jogo e repondo-os na sua posição inicial. Muda o cenário.
; *********************************************************************************
perde_jogo:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R7

    MOV R4, JOGO_ACABADO				; obtém estado de jogo acabado 
	CALL apaga_explosao					; apaga explosao anterior se existir
	MOV [ESTADO_JOGO], R4		        ; muda o estado de jogo para acabado
	CALL apaga_bombas			        ; apaga as bombas do ecrã
	CALL apaga_misseis			        ; apaga os misseis do ecrã
	MOV R1, 1

	CALL repor_misseis_bombas			; repõe os misseis e bombas às 
										; posições iniciais

	CALL reset_energia					; reset da energia
	CALL apaga_ecra						; limpa o ecrã
	MOV R0, [ESTADO_PERSONAGEM]         ; personagem atual
	MOV R2, RAPAZ   
	CMP R2, R0                          ; verifica se é o rapaz
	JNE testa_rapariga_2            	; se não, desenha rapariga 
	CALL desenha_rapaz            		; se sim, desenha rapaz
	JMP fim_perde_jogo                      

	testa_rapariga_2:
	CALL desenha_rapariga        		 ; desenha rapariga

	fim_perde_jogo:

    MOV R1, CENARIO_PERDER             	; muda o cenário para final de jogo
                            
    MOV [SELECIONA_CENARIO], R1

	MOV R7, SOM_PERDER
	CALL reproduz_som

	POP R7
	POP R4
	POP R3
	POP R2
	POP R1
	JMP ciclo
