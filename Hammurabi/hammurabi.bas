'--------------------------------------
' HAMURABI - Simulacion economica en 
' Sumeria.
' Original (FOCAL,1968) por Doug Dyment
' Version BASIC por David Ahl (1973)
' Traducido al espanol y adaptado a 
' PicoCalc BASIC por Ariel Palazzesi

'--------------------------------------
MenuInicial:
  CLS
  Titulo("HAMURABI - SUMERIA")
  PRINT "1. COMENZAR UNA NUEVA PARTIDA"
  PRINT "2. AYUDA DEL JUEGO"
  PRINT "3. SALIR"
  PRINT
  PRINT "SELECCIONE UNA OPCION (1-3)";
  INPUT opcion

  SELECT CASE opcion
    CASE 1, 0
      GOTO Inicio
    CASE 2
      GOSUB Ayuda
      GOTO MenuInicial
    CASE 3
      DRIVE "B:"
      CHDIR "B:/bas/juegost/"
      RUN "menu.bas"
      END
    CASE ELSE
      PRINT "OPCION INVALIDA."
      PresionarTecla
      GOTO MenuInicial
  END SELECT




Inicio:
  CLS
  COLOR RGB(white)
  PRINT CENTRAR$("PRUEBA GOBERNAR LA")
  PRINT CENTRAR$("ANTIGUA SUMERIA CON EXITO")
  PRINT CENTRAR$("DURANTE UNA DECADA.")
  COLOR RGB(green)

  ' Variables iniciales
  D1 = 0      ' Muertos acumulados
  P1 = 0      ' Porcentaje de muertos promedio
  Z = 0       ' Anio
  P = 95      ' Poblacion inicial
  S = 2800    ' Cantidad de grano en silos
  H = 3000    ' Cosecha
  E = H - S   ' Grano comido por ratas
  Y = 3       ' Rendimiento por acre
  A = H / Y   ' Acres de tierra
  I = 5       ' Inmigrantes iniciales
  Q = 1       ' Variable de entrada de usuario

  GOTO ReporteAnual

'--------------------------------------
ReporteAnual:
  PRINT
  Titulo("ESTADO ACTUAL")
  PRINT "HAMURABI: PERMITAME INFORMARLE,"
  Z = Z + 1
  D = 0
  PRINT "EN EL PERIODO"; Z; ","; D; " PERSONAS MURIERON"
  PRINT "DE HAMBRE, Y";I; " LLEGARON A LA CIUDAD."
  P = P + I

  IF Q > 0 THEN GOTO NoPlaga
    P = INT(P / 2)
    PRINT
    PRINT "UNA HORRIBLE PESTE AZOTO LA REGION!"
    PRINT "LA MITAD DEL PUEBLO MURIO."

NoPlaga:
  PRINT
  PRINT "LA POBLACION AHORA ES DE"; P; " ALMAS."
  PRINT "LA CIUDAD POSEE"; A; " ACRES DE TIERRA."
  PRINT "USTED COSECHO"; Y; " FANEGAS POR ACRE."
  PRINT "LAS RATAS COMIERON"; E; " FANEGAS."
  PRINT "LE QUEDAN"; S; " FANEGAS ALMACENADAS."

  IF Z = 11 THEN EvaluacionFinal
  'GOSUB MostrarEstado
  GOTO MercadoDeTierras

'--------------------------------------
MostrarEstado:
  PRINT
  Titulo("ESTADO ACTUAL")
  PRINT "PERIODO.........:"; Z
  PRINT "POBLACION.......:"; P; " PERSONAS"
  PRINT "TIERRAS.........:"; A; " ACRES"
  PRINT "GRANO EN SILOS..:"; S; " FANEGAS"
  PRINT "RENDIMIENTO ACRE:"; Y
  PRINT
RETURN
'--------------------------------------

MercadoDeTierras:
  SubTitulo("MERCADO DE TIERRAS")

  C = INT(10 * RND(1))
  Y = C + 17

  PRINT "EL PRECIO DE LA TIERRA ES"; Y; " FANEGAS"
  PRINT "POR ACRE."
  PRINT

  INPUT "CUANTOS ACRES DESEA COMPRAR";Q
  IF Q < 0 THEN GOTO ErrorOrden
  IF Y * Q <= S THEN GOTO AcresComprados
    GOSUB SinTrigo
    GOTO MercadoDeTierras
AcresComprados:
  IF Q = 0 THEN GOTO VenderTierra
  A = A + Q
  S = S - Y * Q
  C = 0
  GOTO AlimentarPueblo

VenderTierra:
  INPUT "CUANTOS ACRES DESEA VENDER";Q
  IF Q < 0 THEN GOTO ErrorOrden
  IF Q < A THEN GOTO AcresVendidos
    GOSUB SinTierra
    GOTO VenderTierra
AcresVendidos:
  A = A - Q
  S = S + Y * Q
  C = 0

  GOTO AlimentarPueblo

'--------------------------------------
AlimentarPueblo:
  SubTitulo("ALIMENTAR AL PUEBLO")
  PRINT "CUANTAS FANEGAS DE GRANO DESEA DAR A SU"
  INPUT "PUEBLO";Q
  IF Q < 0 THEN GOTO ErrorOrden

  IF Q <= S THEN GOTO AsignarGrano
    GOSUB SinTrigo
    GOTO AlimentarPueblo

AsignarGrano:
  S = S - Q
  C = 1
  PRINT

  GOTO SembrarCampos


'--------------------------------------
SembrarCampos:
  SubTitulo("SEMBRAR CAMPOS")
  PRINT "CUANTOS ACRES DESEA SEMBRAR CON"
  INPUT "SEMILLA"; D
  IF D = 0 THEN GOTO IrACosecha
  IF D < 0 THEN GOTO ErrorOrden

  IF D <= A THEN GOTO VerificarSemillas
    GOSUB SinTierra
    GOTO SembrarCampos

VerificarSemillas:
  IF INT(D / 2) < S THEN GOTO VerificarManoObra
    GOSUB SinTrigo
    GOTO SembrarCampos

VerificarManoObra:
  IF D < 10 * P THEN GOTO TierraOk
    PRINT "PERO SOLO TIENE"; P; " PERSONAS PARA"
    PRINT "TRABAJAR LOS CAMPOS. VUELVA A INTENTAR."
    GOTO SembrarCampos

TierraOk:
  S = S - INT(D / 2)

IrACosecha:
  GOTO Cosecha

'--------------------------------------
Cosecha:
  GOSUB RandomFactor
  Y = C
  H = D * Y
  E = 0

  GOSUB RandomFactor
  IF INT(C / 2) = C / 2 THEN
    E = INT(S / C)
    PRINT "LAS RATAS HAN DEVORADO"; E; " FANEGAS!"
  ENDIF
  S = S - E + H

  GOSUB RandomFactor
  I = INT(C * (20 * A + S) / P / 100 + 1)
  PRINT I; " NUEVAS PERSONAS HAN NACIDO."
  C = INT(Q / 20)

  Q = INT(10 * (2 * RND(1) - .3))
  IF Q <= 0 THEN
    P = INT(P / 2)
    PRINT "UNA PESTE AZOTO LA CIUDAD!"
    PRINT "LA POBLACION SE REDUJO A"; P
  ENDIF


  IF P < C THEN GOTO ReporteAnual

  D = P - C
  IF D > .45 * P THEN GOTO Destituido

  ' --- Se actualizan estadisticas ---
  P1 = ((Z - 1) * P1 + D * 100 / P) / Z
  P = C
  D1 = D1 + D

  GOTO ReporteAnual

'--------------------------------------
Destituido:
  PRINT
  PRINT "HAMURABI!!!"
  PRINT "USTED DEJO MORIR DE HAMBRE A"; D
  PRINT "PERSONAS EN UN SOLO PERIODO."
  PRINT "POR ESTA GESTION TAN NEFASTA, HA SIDO"
  PRINT "DESTITUIDO, EXPULSADO DEL GOBIERNO Y"
  PRINT "DECLARADO 'GRAN INFAME'."
  GOTO FinJuego


'--------------------------------------
EvaluacionFinal:
  PRINT
  PRINT "EN CADA UNO DE SUS 10 PERIODOS DE"
  PRINT "GOBIERNO, UN PROMEDIO DE"; P1 ;" POR"
  PRINT "CIENTO DE LA POBLACION MURIO DE HAMBRE."
  PRINT "EN TOTAL,"; D1; " PERSONAS MURIERON."
  L = A / P
  PRINT "AL INICIO TENIA 10 ACRES POR PERSONA Y"
  PRINT "AL FINAL QUEDARON"; L; " ACRES POR"
  PRINT "PERSONA."
  PRINT

  ' Evaluación del desempeño
  IF P1 > 33 THEN GOTO MalGobierno
  IF L < 7 THEN GOTO MalGobierno

  IF P1 > 10 THEN GOTO GobiernoDuro
  IF L < 9 THEN GOTO GobiernoDuro

  IF P1 > 3 THEN GOTO GobiernoAceptable
  IF L < 10 THEN GOTO GobiernoAceptable

  GOTO GobiernoExcelente

'--------------------------------------
GobiernoExcelente:
  PRINT "UNA GESTION FANTASTICA!"
  PRINT "CARLOMAGNO, DISRAELI Y JEFFERSON JUNTOS"
  PRINT "NO LO HABRIAN HECHO MEJOR."
  GOTO FinJuego

GobiernoDuro:
  PRINT "SU GOBIERNO AUTORITARIO RECUERDA A NERON"
  PRINT "O IVAN EL TERRIBLE."
  PRINT "EL PUEBLO SOBREVIVIENTE LO DETESTA Y"
  PRINT "ODIA PROFUNDAMENTE."
  GOTO FinJuego

GobiernoAceptable:
  PRINT "SU GESTION PUDO HABER SIDO MEJOR, PERO"
  PRINT "EN REALIDAD NO FUE TAN MALA."
  PRINT INT(P * .8 * RND(1)); " PERSONAS HUBIERAN PREFERIDO VERLO"
  PRINT "ASESINADO, PERO TENEMOS PROBLEMAS MAS"
  PRINT "IMPORTANTES."
  GOTO FinJuego

MalGobierno:
  PRINT "USTED HA SIDO UN DESASTRE COMO LIDER."
  PRINT "EL PUEBLO LO HA DESTITUIDO Y PASARA A"
  PRINT "LA HISTORIA COMO UN GOBERNANTE INFAME."
  GOTO FinJuego


FinJuego:
  Beep
  Beep
  PRINT
  SubTitulo("EL JUEGO HA TERMINADO.")
  FINAL_DEL_JUEGO



'--------------------------------------
SinTrigo:
  PRINT "HAMURABI: PIENSALO DE NUEVO."
  PRINT "SOLO TIENES"; S; " FANEGAS DE GRANO."
  RETURN

SinTierra:
  PRINT "HAMURABI: PIENSALO DE NUEVO."
  PRINT "SOLO POSEES"; A; " ACRES DE TIERRA."
  RETURN

ErrorOrden:
  PRINT
  PRINT "HAMURABI: NO PUEDO HACER LO QUE PIDES."
  PRINT "CONSIGUETE OTRO ADMINISTRADOR!!!"
  GOTO EvaluacionFinal



RandomFactor:
  C = INT(RND(1) * 5) + 1
  RETURN

'--------------------------------------
SUB FINAL_DEL_JUEGO:
  SubTitulo("INTENTAR OTRA VEZ? (S/N)")
  LINE INPUT a1$
  ValidarSioNo
  IF SiNo = 0 THEN
    RUN "hammurabi.bas"
  ELSE
    DRIVE "B:"
    CHDIR "B:/bas/juegost/"
    RUN "menu.bas"
    END
  END IF
END SUB

'--------------------------------------
Ayuda:
  CLS
  Titulo("AYUDA DEL JUEGO 1/2")
  PRINT
  PRINT "Usted es HAMURABI, gobernador de Sumeria"
  PRINT "Debe administrar la tierra, el grano y"
  PRINT "la poblacion durante un mandato de 10"
  PRINT "periodos anuales."
  PRINT
  PRINT "Reglas basicas:"
  PRINT "- Cada persona necesita 20 fanegas de"
  PRINT "  grano por periodo para vivir."
  PRINT "- Cada acre sembrado requiere 1/2 fanega"
  PRINT "  de grano como semilla."
  PRINT "- Una persona puede trabajar hasta 10"
  PRINT "  acres de tierra."
  PRINT "- El rendimiento por acre varia entre 17"
  PRINT "  y 22 fanegas."
  PRINT "- Las malditas ratas a veces comen parte"
  PRINT "  del grano almacenado."
  PRINT "- Puede comprar o vender tierras, segun"
  PRINT "  el precio anual."
  PresionarTecla
  
  CLS
  Titulo("AYUDA DEL JUEGO 2/2")
  PRINT
  PRINT "Objetivo:"
  PRINT "- Mantener a la poblacion viva y satis-"
  PRINT "  fecha, y conservar suficientes tierras"
  PRINT "  para prosperar."
  PresionarTecla
RETURN


'--------------------------------------
'Centrar cadena en 40 columnas
FUNCTION CENTRAR$(T$)
  LOCAL L, IZQ, DER, OUTx$
  L = LEN(T$)
  IF L > 40 THEN
    ' Si es mas largo, se recorta
    T$ = LEFT$(T$,40)
    L = 40
  ENDIF
  IZQ = (40 - L) \ 2
  DER = 40 - L - IZQ
  OUTx$ = STRING$(IZQ," ") + T$ + STRING$(DER," ")
  CENTRAR$ = OUTx$
END FUNCTION

'--------------------------------------
SUB PresionarTecla
  PRINT
  PRINT "PULSA UNA TECLA PARA CONTINUAR.";
  DO WHILE LEN(INKEY$) = 0 
  LOOP
  PRINT
END SUB

'--------------------------------------
SUB Beep
  play tone 500,500
  pause 500
  play stop
END SUB

'--------------------------------------
SUB Titulo(T$):
  COLOR RGB(gold)
  PRINT STRING$(40,"=")
  PRINT CENTRAR$(T$)
  PRINT STRING$(40,"=")
  COLOR RGB(green)
END SUB

SUB SubTitulo(T$):
  PRINT
  COLOR RGB(white)
  PRINT CENTRAR$(T$)
  COLOR RGB(green)
  PRINT
END SUB

'--------------------------------------
SUB ValidarSioNo:
  DO
    a1$=UCASE$(a1$)
    IF a1$ = "SI" OR a1$ = "S" THEN
        SiNo = 0 
        RETURN
    END IF
    IF a1$ = "N" or a1$ = "NO" THEN
        SiNo = 1 
        RETURN
    END IF
    Beep
    INPUT a1$
  LOOP  
END SUB
