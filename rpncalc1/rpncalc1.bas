'--------------------------------------
' Calculadora RPN V1.0 For PicoCalc
' Ariel Palazzesi 2025
'--------------------------------------
OPTION BASE 1
FONT 7,2

  CONST MAX_PILA = 100
  DIM pila(MAX_PILA)
  DIM tope
  DIM ayuda$(60)
  DIM menu$(10)
  DIM submenuTrig$(12)
  DIM submenuLog$(10)
  DIM submenuInt$(10)
  DIM submenuConst$(10)
  DIM submenuConv$(6)
  DIM submenuConf$(11)
  DRG$ = "D"
  total_ayuda = 54
  FORMATO$ = "NORM"
  DECIM = 6  

  menu$(1) = "TRIGONOM.>"
  menu$(2) = "LOG/EXP  >"
  menu$(3) = "ENTEROS  >"
  menu$(4) = "ANGULOS  >"
  menu$(5) = "CONST.   >"
  menu$(6) = "CONFIG.  >"
  menu$(7) = "AYUDA     "
  total = 7

  submenuTrig$(1) = "SIN"
  submenuTrig$(2) = "COS"
  submenuTrig$(3) = "TAN"
  submenuTrig$(4) = "ASIN"
  submenuTrig$(5) = "ACOS"
  submenuTrig$(6) = "ATAN"
  submenuTrig$(7) = "SINH"
  submenuTrig$(8) = "COSH"
  submenuTrig$(9) = "TANH"
  submenuTrig$(10) = "ASINH"
  submenuTrig$(11) = "ACOSH"
  submenuTrig$(12) = "ATANH"  
  totalTrig = 12

  submenuLog$(1) = "LN"
  submenuLog$(2) = "LOG"
  submenuLog$(3) = "EXP"
  submenuLog$(4) = "10^X"
  totalLog = 4

  submenuInt$(1) = "ABS"
  submenuInt$(2) = "INT"
  submenuInt$(3) = "FRAC"
  submenuInt$(4) = "SGN"
  submenuInt$(5) = "FACT"
  submenuInt$(6) = "PRIMO"
  submenuInt$(7) = "MCD"
  submenuInt$(8) = "MCM"
  totalInt = 8

  submenuConv$(1) = "DEG > RAD"
  submenuConv$(2) = "RAD > DEG"
  submenuConv$(3) = "DEG > GRA"
  submenuConv$(4) = "GRA > DEG"
  submenuConv$(5) = "DEG > DMS"
  submenuConv$(6) = "DMS > DEG"
  totalConv = 6

  submenuConst$(1) = "PI"
  submenuConst$(2) = "E"
  submenuConst$(3) = "PHI"
  submenuConst$(4) = "C"
  submenuConst$(5) = "G"
  submenuConst$(6) = "H"
  submenuConst$(7) = "QE"
  totalConst = 7

  submenuConf$(1) = "DEG"
  submenuConf$(2) = "RAD"
  submenuConf$(3) = "GRA"
  submenuConf$(4) = "NORM"
  submenuConf$(5) = "FIX3"
  submenuConf$(6) = "FIX6"
  submenuConf$(7) = "FIX9"
  submenuConf$(8) = "SCI3"
  submenuConf$(9) = "SCI6"
  submenuConf$(10) = "SCI9"
  submenuConf$(11) = "ENG"
  totalConf = 11

pila_iniciar
cargar_ayuda
pila_mostrar

entrada$ = ""
mostrar_entrada()

DO
  k$ = INKEY$
  IF k$ <> "" THEN
    ' mapear CHR$(10) a CHR$(13)
    IF k$ = CHR$(10) THEN k$ = CHR$(13)
    
    SELECT CASE UCASE$(k$)
      CASE "0","1","2","3","4","5","6","7","8","9","."
        IF LEN(entrada$) < 16 THEN
          IF k$ = "." AND INSTR(entrada$, ".") > 0 THEN
            'Ignoro .
          ELSE          
            entrada$ = entrada$ + k$
            mostrar_entrada
          END IF
        END IF

      CASE CHR$(13)
        IF entrada$ <> "" THEN
          temp$ = entrada$
          IF LEFT$(temp$,1) = "_" THEN 
            temp$ = "-" + MID$(temp$,2)
          END IF
          pila_apilar VAL(temp$)
          entrada$ = ""
        ELSE
          pila_enter
        END IF
        pila_mostrar
        mostrar_entrada

      CASE "_"
        IF entrada$ = "" THEN
          entrada$ = "_"
          mostrar_entrada
        END IF  

      CASE "+","-","*","/"
        IF entrada$ <> "" THEN
          pila_apilar VAL(entrada$)
          entrada$ = ""
        END IF
        SELECT CASE k$
          CASE "+": op_suma
          CASE "-": op_resta
          CASE "*": op_mult
          CASE "/": op_div
        END SELECT
        pila_mostrar

      CASE "M"  
        SELECT CASE DRG$
          CASE "D": DRG$ = "R"
          CASE "R": DRG$ = "G"
          CASE "G": DRG$ = "D"
        END SELECT
        pila_mostrar

      CASE "D": pila_borrar_tope : pila_mostrar 
      CASE "U": pila_duplicar    : pila_mostrar
      CASE "S": pila_intercambiar: pila_mostrar
      CASE "X": pila_limpiar     : pila_mostrar
      CASE "P": op_pi : pila_mostrar
      CASE "E": op_e  : pila_mostrar
      CASE "!": op_factorial : pila_mostrar
      CASE "I": op_inversa   : pila_mostrar
      CASE "R": op_raiz      : pila_mostrar
      CASE "^": op_potencia  : pila_mostrar

      CASE "Q"
        EXIT DO

      CASE CHR$(8), CHR$(127)  
        IF LEN(entrada$) > 0 THEN
          entrada$ = LEFT$(entrada$, LEN(entrada$) - 1)
          mostrar_entrada
        END IF

      CASE CHR$(145) ' F1 
        opcion$ = menu_navegar$()
        SELECT CASE opcion$
          CASE "SIN":  op_sin   : pila_mostrar
          CASE "COS":  op_cos   : pila_mostrar
          CASE "TAN":  op_tan   : pila_mostrar
          CASE "ASIN": op_asin  : pila_mostrar
          CASE "ACOS": op_acos  : pila_mostrar
          CASE "ATAN": op_atan  : pila_mostrar
          CASE "SINH":  op_sinh : pila_mostrar
          CASE "COSH":  op_cosh : pila_mostrar
          CASE "TANH":  op_tanh : pila_mostrar
          CASE "ASINH": op_asinh: pila_mostrar
          CASE "ACOSH": op_acosh: pila_mostrar
          CASE "ATANH": op_atanh: pila_mostrar
          CASE "LN":   op_ln    : pila_mostrar 
          CASE "LOG":  op_log10 : pila_mostrar 
          CASE "EXP":  op_exp   : pila_mostrar 
          CASE "10^X": op_10x   : pila_mostrar 
          CASE "ABS":   op_abs  : pila_mostrar
          CASE "INT":   op_int  : pila_mostrar
          CASE "FRAC":  op_frac : pila_mostrar
          CASE "SGN":   op_sgn  : pila_mostrar
          CASE "FACT":  op_fact : pila_mostrar
          CASE "PRIMO": op_primo: pila_mostrar
          CASE "MCD":   op_mcd  : pila_mostrar
          CASE "MCM":   op_mcm  : pila_mostrar
          CASE "DEG > RAD":   op_d2r : pila_mostrar
          CASE "RAD > DEG":   op_r2d : pila_mostrar
          CASE "DEG > GRA":   op_d2g : pila_mostrar
          CASE "GRA > DEG":   op_g2d : pila_mostrar
          CASE "DEG > DMS": op_d2dms : pila_mostrar
          CASE "DMS > DEG": op_dms2d : pila_mostrar
          CASE "PI":   op_pi  : pila_mostrar
          CASE "E":    op_e   : pila_mostrar
          CASE "PHI":  op_phi : pila_mostrar
          CASE "C":    op_c   : pila_mostrar
          CASE "G":    op_G   : pila_mostrar
          CASE "H":    op_h   : pila_mostrar
          CASE "QE":   op_qe  : pila_mostrar
          CASE "DEG":   DRG$="D" : pila_mostrar
          CASE "RAD":   DRG$="R" : pila_mostrar
          CASE "GRA":  DRG$="G" : pila_mostrar
          CASE "NORM":  FORMATO$="NORM" : pila_mostrar
          CASE "FIX3":  FORMATO$="FIX": DECIM=3 : pila_mostrar
          CASE "FIX6":  FORMATO$="FIX": DECIM=6 : pila_mostrar
          CASE "FIX9":  FORMATO$="FIX": DECIM=9 : pila_mostrar
          CASE "SCI3":  FORMATO$="SCI": DECIM=3 : pila_mostrar
          CASE "SCI6":  FORMATO$="SCI": DECIM=6 : pila_mostrar
          CASE "SCI9":  FORMATO$="SCI": DECIM=9 : pila_mostrar
          CASE "ENG" :  FORMATO$="ENG": DECIM=3 : pila_mostrar
          CASE "AYUDA"
            ver_ayuda ayuda$(), total_ayuda
            pila_mostrar
        END SELECT 
        mostrar_entrada  
    END SELECT
  END IF
LOOP

END


'--------------------------------------
FUNCTION menu_navegar$()
  LOCAL nivel, sel, subsel
  LOCAL k$, i, y, redibujar

  nivel = 1 
  sel = 1
  subsel = 1
  redibujar = 1 
  DO
    IF redibujar THEN
      C_MenuTitulo
      filay = 0
      BOX 0, filay, 132, 20,0,RGB(WHITE),RGB(150,150,255)
      TEXT 5,filay+3,"MENU PPAL."
      C_MenuOp
      FOR i = 1 TO total
        filay = i*20
        IF sel = i THEN
          C_MenuOpSel
          BOX  0, filay, 132, 20,0,RGB(150,150,255),RGB(150,150,255)
          TEXT 5,filay+3,menu$(i)
          C_MenuOp
        ELSE
          BOX  0, filay, 132, 20,0,RGB(WHITE),RGB(WHITE)
          TEXT 5,filay+3,menu$(i)
        END IF
      NEXT
      IF nivel=2 THEN
      SELECT CASE sel
        CASE 1 
          C_MenuOp
          totalSub = totalTrig
          FOR i = 1 TO totalTrig
            filay = i*20
            IF subsel = i AND nivel=2 THEN
              C_MenuOpSel
              BOX  132, filay, 132, 20,0,RGB(150,150,255),RGB(150,150,255)
              TEXT 140,filay+3,submenuTrig$(i)
              C_MenuOp
            ELSE
              BOX  132, filay, 132, 20,0,RGB(WHITE),RGB(WHITE)
              TEXT 140,filay+3,submenuTrig$(i)
            END IF
          NEXT

        CASE 2 
          C_MenuOp
          totalSub = totalLog
          FOR i = 1 TO totalLog
            filay = i*20+20
            IF subsel = i AND nivel=2 THEN
              C_MenuOpSel
              BOX  132, filay, 132, 20,0,RGB(150,150,255),RGB(150,150,255)
              TEXT 140,filay+3,submenuLog$(i)
              C_MenuOp
            ELSE
              BOX  132, filay, 132, 20,0,RGB(WHITE),RGB(WHITE)
              TEXT 140,filay+3,submenuLog$(i)
            END IF
          NEXT

        CASE 3 
          C_MenuOp
          totalSub = totalInt
          FOR i = 1 TO totalInt
            filay = i*20+40
            IF subsel = i THEN
              C_MenuOpSel
              BOX  132, filay, 132, 20,0,RGB(150,150,255),RGB(150,150,255)
              TEXT 140,filay+3,submenuInt$(i)
              C_MenuOp
            ELSE
              BOX  132, filay, 132, 20,0,RGB(WHITE),RGB(WHITE)
              TEXT 140,filay+3,submenuInt$(i)
            END IF
          NEXT
        
        CASE 4 
          C_MenuOp
          totalSub = totalConv
          FOR i = 1 TO totalConv
            filay = i*20+60
            IF subsel = i THEN
              C_MenuOpSel
              BOX  132, filay, 132, 20,0,RGB(150,150,255),RGB(150,150,255)
              TEXT 140,filay+3,submenuConv$(i)
              C_MenuOp
            ELSE
              BOX  132, filay, 132, 20,0,RGB(WHITE),RGB(WHITE)
              TEXT 140,filay+3,submenuConv$(i)
            END IF
          NEXT

        CASE 5
          C_MenuOp
          totalSub = totalConst
          FOR i = 1 TO totalConst
            filay = i*20+80
            IF subsel = i THEN
              C_MenuOpSel
              BOX  132, filay, 132, 20,0,RGB(150,150,255),RGB(150,150,255)
              TEXT 140,filay+3,submenuConst$(i)
              C_MenuOp
            ELSE
              BOX  132, filay, 132, 20,0,RGB(WHITE),RGB(WHITE)
              TEXT 140,filay+3,submenuConst$(i)
            END IF
          NEXT

        CASE 6 
          C_MenuOp
          totalSub = totalConf
          FOR i = 1 TO totalConf
            filay = i*20+20
            IF subsel = i THEN
              C_MenuOpSel
              BOX  132, filay, 132, 20,0,RGB(150,150,255),RGB(150,150,255)
              TEXT 140,filay+3,submenuConf$(i)
              C_MenuOp
            ELSE
              BOX  132, filay, 132, 20,0,RGB(WHITE),RGB(WHITE)
              TEXT 140,filay+3,submenuConf$(i)
            END IF
          NEXT
        END SELECT
      END IF
      redibujar = 0 
    END IF

    k$ = INKEY$
    IF k$ <> "" THEN
      SELECT CASE k$
        CASE CHR$(27),CHR$(8),CHR$(145)  
          menu_navegar$ = ""
          pila_mostrar
          EXIT FUNCTION

        CASE CHR$(128) 
          IF nivel=1 THEN
            IF sel>1 THEN 
              sel=sel-1 
              redibujar=1
            END IF
          ELSE
            IF subsel>1 THEN
              subsel=subsel-1
              redibujar=1
            END IF
          END IF

        CASE CHR$(129)
          IF nivel=1 THEN
            IF sel<total THEN
              sel=sel+1
              redibujar=1
            END IF
          ELSE
            IF subsel<totalSub THEN 
              subsel=subsel+1
              redibujar=1
            END IF
          END IF

        CASE CHR$(13)
          IF nivel=1 THEN
            SELECT CASE sel
              CASE 1,2,3,4,5,6 
                nivel=2 : subsel=1 : redibujar=1
              CASE 7   ' AYUDA 
                menu_navegar$ = "AYUDA"
                EXIT FUNCTION
            END SELECT
          ELSE
            SELECT CASE sel
              CASE 1 
                menu_navegar$ = TRIM$(submenuTrig$(subsel))
              CASE 2
                menu_navegar$ = TRIM$(submenuLog$(subsel))
              CASE 3
                menu_navegar$ = TRIM$(submenuInt$(subsel))
              CASE 4
                menu_navegar$ = TRIM$(submenuConv$(subsel))
              CASE 5
                menu_navegar$ = TRIM$(submenuConst$(subsel))
              CASE 6
                menu_navegar$ = TRIM$(submenuConf$(subsel))
            END SELECT
            pila_mostrar
            EXIT FUNCTION
          END IF

        CASE CHR$(131) 
          IF nivel=1 THEN 
            nivel=2
            subsel=1
            redibujar=1
          END IF

        CASE CHR$(130) 
          IF nivel=2 THEN 
            nivel=1
            redibujar=1
            pila_mostrar
          END IF
      END SELECT
    END IF

    PAUSE 50
  LOOP
END FUNCTION


SUB pila_mostrar()
  COLOR RGB(WHITE), RGB(BLACK)
  CLS
  FONT 7,2

  COLOR RGB(160,160,255) , RGB(WHITE)
  LINE 0, 0, 320, 0, , RGB(white) 
  TEXT 0,1," CALCULADORA PICOCALC v1.1 "
  LINE 0, 17, 320, 17, , RGB(white) 

  COLOR RGB(WHITE), RGB(160,160,255)
  TEXT   0, 22," RPN "
  SELECT CASE DRG$
    CASE "D": TEXT 96, 22," DEG "
    CASE "R": TEXT 96, 22," RAD "
    CASE "G": TEXT 96, 22," GRA "
  END SELECT
  SELECT CASE FORMATO$
    CASE "NORM": fmt$="NORM"
    CASE "FIX":  fmt$="FIX"+STR$(DECIM)
    CASE "SCI":  fmt$="SCI"+STR$(DECIM)
    CASE "ENG":  fmt$="ENG"
  END SELECT
  TEXT 252,22, " "+fmt$+" "

  LINE 0, 54, 320, 54, , RGB(white) 

  COLOR RGB(WHITE), RGB(BLACK)
  LOCAL i, idx, etiqueta$, fila, texto$
  FOR i = 8 TO 1 STEP -1
    idx = tope - (i - 1)
    fila = (11 - i) * 20 
    SELECT CASE i
      CASE 8: etiqueta$ = "8:"
      CASE 7: etiqueta$ = "7:"
      CASE 6: etiqueta$ = "6:"      
      CASE 5: etiqueta$ = "5:"
      CASE 4: etiqueta$ = "4:"
      CASE 3: etiqueta$ = "3:"
      CASE 2: etiqueta$ = "2:"
      CASE 1: etiqueta$ = "1:"
    END SELECT
    COLOR RGB(WHITE), RGB(BLACK)
    TEXT 0, fila, etiqueta$
    IF idx >= 1 THEN  
      COLOR RGB(WHITE), RGB(BLACK)
      cadena$ = formatear_numero$(pila(idx))
      columna = 310-LEN(cadena$)*12
      TEXT columna,fila,cadena$
    END IF
  NEXT i
  LINE 0, 230, 320, 230, , RGB(white)
  LINE 0, 303, 320, 303, , RGB(white) 
  COLOR RGB(160,160,255) , RGB(white)
  TEXT  0,304," F1: MENU                  "
  COLOR RGB(WHITE), RGB(BLACK)
END SUB

'--------------------------------------
SUB mostrar_entrada()
  COLOR RGB(white)
  TEXT 0, 240, SPACE$(28)
  cadena$ = "> " + entrada$
  columna = 310-LEN(cadena$)*12
  TEXT columna,240,cadena$
END SUB

'--------------------------------------
SUB mostrar_error(msg$)
  LOCAL k$
  TEXT 0, 260, SPACE$(20)
  TEXT 0, 280, SPACE$(20)
  COLOR RGB(GOLD)
  TEXT 0, 260, "ERROR:"
  TEXT 0, 280, msg$
  COLOR RGB(WHITE)
  DO
    k$ = INKEY$
    IF k$ = CHR$(8) OR k$ = CHR$(27) THEN EXIT DO
    PAUSE 20 
  LOOP
  TEXT 0, 260, SPACE$(20)
  TEXT 0, 280, SPACE$(20)
END SUB


'--------------------------------------
SUB op_suma()
  IF tope >= 2 THEN
    x = pila_desapilar()
    y = pila_desapilar()
    pila_apilar(y + x)
  ELSE
    mostrar_error("REQ. DOS ELEMENTOS")
  END IF
END SUB

SUB op_resta()
  IF tope >= 2 THEN
    x = pila_desapilar()
    y = pila_desapilar()
    pila_apilar(y - x)
  ELSE
    mostrar_error("REQ. DOS ELEMENTOS")
  END IF
END SUB

SUB op_mult()
  IF tope >= 2 THEN
    x = pila_desapilar()
    y = pila_desapilar()
    pila_apilar(y * x)
  ELSE
    mostrar_error("REQ. DOS ELEMENTOS")
  END IF
END SUB

SUB op_div()
  IF tope >= 2 THEN
    x = pila_desapilar()
    y = pila_desapilar()
    IF x = 0 THEN
      mostrar_error("DIVISION POR CERO")
      pila_apilar(y)
      pila_apilar(x) 
    ELSE
      pila_apilar(y / x)
    END IF
  ELSE
    mostrar_error("REQ. DOS ELEMENTOS")
  END IF
END SUB

SUB op_potencia
  IF tope >= 2 THEN
    x = pila_desapilar()
    y = pila_desapilar()
    pila_apilar y ^ x
  ELSE
    mostrar_error("REQ. DOS ELEMENTOS")
  END IF
END SUB

SUB op_factorial
  IF tope >= 1 THEN
    n = pila_desapilar()
    IF n < 0 OR n <> INT(n) THEN
      mostrar_error("REQ. UN ENTERO > 0")
      pila_apilar n 
    ELSE
      res = 1
      FOR i = 1 TO n
        res = res * i
      NEXT i
      pila_apilar res
    END IF
  ELSE
    mostrar_error("PILA VACIA")
  END IF
END SUB

SUB op_inversa
  IF tope >= 1 THEN
    x = pila_desapilar()
    IF x = 0 THEN
      mostrar_error("DIVISION POR CERO")
      pila_apilar x
    ELSE
      pila_apilar 1 / x
    END IF
  ELSE
    mostrar_error("PILA VACIA")
  END IF
END SUB

SUB op_raiz
  IF tope >= 1 THEN
    x = pila_desapilar()
    IF x < 0 THEN
      mostrar_error("ARG. RAIZ < 0")
      pila_apilar x
    ELSE
      pila_apilar SQR(x)
    END IF
  ELSE
    mostrar_error("PILA VACIA")
  END IF
END SUB


' Pila RPN -------------------------
SUB pila_iniciar()
  tope = 0
END SUB

FUNCTION pila_profundidad()
  pila_profundidad = tope
END FUNCTION

SUB pila_apilar(v)
  IF tope < MAX_PILA THEN
    tope = tope + 1
    pila(tope) = v
  ELSE
    mostrar_error("PILA LLENA")
  END IF
END SUB

FUNCTION pila_desapilar()
  IF tope > 0 THEN
    pila_desapilar = pila(tope)
    tope = tope - 1
  ELSE
    mostrar_error("PILA VACIA")
    pila_desapilar = 0
  END IF
END FUNCTION

FUNCTION pila_ver(n)
  IF n >= 1 AND n <= tope THEN
    pila_ver = pila(tope - n + 1)
  ELSE
    mostrar_error("FUERA DE RANGO")
    pila_ver = 0
  END IF
END FUNCTION

SUB pila_borrar_tope() ' DROP
  IF tope > 0 THEN
    tope = tope - 1
  ELSE
    mostrar_error("PILA VACIA")
  END IF
END SUB

SUB pila_duplicar()     ' DUP
  IF tope > 0 THEN
    pila_apilar(pila(tope))
  ELSE
    mostrar_error("NADA PARA DUPLICAR")
  END IF
END SUB

SUB pila_intercambiar()
  IF tope >= 2 THEN
    LOCAL t
    t = pila(tope)
    pila(tope) = pila(tope - 1)
    pila(tope - 1) = t
  ELSE
    mostrar_error("REQ. DOS ELEMENTOS")
  END IF
END SUB

SUB pila_rotar_abajo()
  IF tope >= 3 THEN
    LOCAL i, t
    t = pila(tope)
    FOR i = tope TO 2 STEP -1
      pila(i) = pila(i - 1)
    NEXT i
    pila(1) = t
  ELSE
    mostrar_error("REQ. TRES ELEMENTOS")
  END IF
END SUB

SUB pila_rotar_arriba() '
  IF tope >= 3 THEN
    LOCAL i, t
    t = pila(1)
    FOR i = 1 TO tope - 1
      pila(i) = pila(i + 1)
    NEXT i
    pila(tope) = t
  ELSE
    mostrar_error("REQ. TRES ELEMENTOS")
  END IF
END SUB

SUB pila_limpiar()
  tope = 0
END SUB

SUB pila_enter() 
  IF tope = 0 THEN
    pila_apilar(0)
  ELSE
    pila_apilar(pila(tope))
  END IF
END SUB
'--------------------------------------
SUB op_pi
  pila_apilar 3.14159265358979
  entrada$ = ""
END SUB

SUB op_e
  pila_apilar 2.71828182845905
  entrada$ = ""
END SUB

SUB op_phi
  pila_apilar 1.61803398874989
END SUB

SUB op_c
  pila_apilar 299792458
END SUB

SUB op_G
  pila_apilar 6.67430E-11
END SUB

SUB op_h
  pila_apilar 6.62607015E-34
END SUB

SUB op_qe
  pila_apilar 1.602176634E-19
END SUB
'--------------------------------------

SUB op_sin
  IF tope >= 1 THEN
    x = pila_desapilar()
    SELECT CASE UCASE$(DRG$)
      CASE "D": x = x * PI / 180
      CASE "G": x = x * PI / 200
    END SELECT
    pila_apilar SIN(x)
    entrada$ = ""
  ELSE
    mostrar_error("REQ. UN ELEMENTO")
  END IF
END SUB

SUB op_cos
  IF tope >= 1 THEN
    x = pila_desapilar()
    SELECT CASE UCASE$(DRG$)
      CASE "D": x = x * PI / 180
      CASE "G": x = x * PI / 200
    END SELECT
    pila_apilar COS(x)
    entrada$ = ""
  ELSE
    mostrar_error("REQ. UN ELEMENTO")
  END IF
END SUB

SUB op_tan
  IF tope >= 1 THEN
    x = pila_desapilar()
    SELECT CASE UCASE$(DRG$)
      CASE "D": x = x * PI / 180
      CASE "G": x = x * PI / 200
    END SELECT
    pila_apilar TAN(x)
    entrada$ = ""
  ELSE
    mostrar_error("REQ. UN ELEMENTO")
  END IF
END SUB

SUB op_asin
  IF tope >= 1 THEN
    x = pila_desapilar()
    IF x < -1 OR x > 1 THEN
      mostrar_error("FUERA DE RANGO")
      pila_apilar x
    ELSE
      res = ASIN(x)
      SELECT CASE UCASE$(DRG$)
        CASE "D": res = res * 180 / PI
        CASE "G": res = res * 200 / PI
      END SELECT
      pila_apilar res
    END IF
  ELSE
    mostrar_error("REQ. UN ELEMENTO")
  END IF
END SUB

SUB op_acos
  IF tope >= 1 THEN
    x = pila_desapilar()
    IF x < -1 OR x > 1 THEN
      mostrar_error("FUERA DE RANGO")
      pila_apilar x
    ELSE
      res = ACOS(x)
      SELECT CASE UCASE$(DRG$)
        CASE "D": res = res * 180 / PI
        CASE "G": res = res * 200 / PI
      END SELECT
      pila_apilar res
    END IF
  ELSE
    mostrar_error("REQ. UN ELEMENTO")
  END IF
END SUB

SUB op_atan
  IF tope >= 1 THEN
    x = pila_desapilar()
    res = ATN(x)
    SELECT CASE UCASE$(DRG$)
      CASE "D": res = res * 180 / PI
      CASE "G": res = res * 200 / PI
    END SELECT
    pila_apilar res
  ELSE
    mostrar_error("REQ. UN ELEMENTO")
  END IF
END SUB

'--------------------------------------
SUB op_sinh
  IF tope >= 1 THEN
    x = pila_desapilar()
    pila_apilar (EXP(x) - EXP(-x)) / 2
  ELSE
    mostrar_error("REQ. UN ELEMENTO")
  END IF
END SUB

SUB op_cosh
  IF tope >= 1 THEN
    x = pila_desapilar()
    pila_apilar (EXP(x) + EXP(-x)) / 2
  ELSE
    mostrar_error("REQ. UN ELEMENTO")
  END IF
END SUB

SUB op_tanh
  IF tope >= 1 THEN
    x = pila_desapilar()
    pila_apilar (EXP(x) - EXP(-x)) / (EXP(x) + EXP(-x))
  ELSE
    mostrar_error("REQ. UN ELEMENTO")
  END IF
END SUB

SUB op_asinh
  IF tope >= 1 THEN
    x = pila_desapilar()
    pila_apilar LOG(x + SQR(x*x + 1))
  ELSE
    mostrar_error("REQ. UN ELEMENTO")
  END IF
END SUB

SUB op_acosh
  IF tope >= 1 THEN
    x = pila_desapilar()
    IF x < 1 THEN
      mostrar_error("DOMINIO x>=1")
      pila_apilar x
    ELSE
      pila_apilar LOG(x + SQR(x*x - 1))
    END IF
  ELSE
    mostrar_error("REQ. UN ELEMENTO")
  END IF
END SUB

SUB op_atanh
  IF tope >= 1 THEN
    x = pila_desapilar()
    IF ABS(x) >= 1 THEN
      mostrar_error("|x|<1 REQ.")
      pila_apilar x
    ELSE
      pila_apilar 0.5 * LOG((1+x)/(1-x))
    END IF
  ELSE
    mostrar_error("REQ. UN ELEMENTO")
  END IF
END SUB
'--------------------------------------
SUB op_d2r
  IF tope >= 1 THEN
    x = pila_desapilar()
    pila_apilar x * PI / 180
  ELSE
    mostrar_error("REQ. UN ELEMENTO")
  END IF
END SUB

SUB op_r2d
  IF tope >= 1 THEN
    x = pila_desapilar()
    pila_apilar x * 180 / PI
  ELSE
    mostrar_error("REQ. UN ELEMENTO")
  END IF
END SUB

SUB op_d2g
  IF tope >= 1 THEN
    x = pila_desapilar()
    pila_apilar x * 200 / 180
  ELSE
    mostrar_error("REQ. UN ELEMENTO")
  END IF
END SUB

SUB op_g2d
  IF tope >= 1 THEN
    x = pila_desapilar()
    pila_apilar x * 180 / 200
  ELSE
    mostrar_error("REQ. UN ELEMENTO")
  END IF
END SUB

SUB op_d2dms
  IF tope >= 1 THEN
    x = pila_desapilar()
    g = INT(x)
    m = INT((x - g) * 60)
    s = INT((((x - g) * 60) - m) * 60 + 0.5) ' redondeo
    pila_apilar g*10000 + m*100 + s
  ELSE
    mostrar_error("REQ. UN ELEMENTO")
  END IF
END SUB

SUB op_dms2d
  IF tope >= 1 THEN
    x = pila_desapilar()
    g = INT(x/10000)
    m = INT((x - g*10000)/100)
    s = x - g*10000 - m*100
    pila_apilar g + m/60 + s/3600
  ELSE
    mostrar_error("REQ. UN ELEMENTO")
  END IF
END SUB
'--------------------------------------

'--------------------------------------
SUB op_ln
  IF tope >= 1 THEN
    x = pila_desapilar()
    IF x <= 0 THEN
      mostrar_error("DOMINIO x>0")
      pila_apilar x
    ELSE
      pila_apilar LOG(x)  
    END IF
  ELSE
    mostrar_error("REQ. UN ELEMENTO")
  END IF
END SUB

SUB op_log10
  IF tope >= 1 THEN
    x = pila_desapilar()
    IF x <= 0 THEN
      mostrar_error("DOMINIO x>0")
      pila_apilar x
    ELSE
      pila_apilar (LOG(x) / LOG(10)) 
    END IF
  ELSE
    mostrar_error("REQ. UN ELEMENTO")
  END IF
END SUB

SUB op_exp
  IF tope >= 1 THEN
    x = pila_desapilar()
    pila_apilar EXP(x)    
  ELSE
    mostrar_error("REQ. UN ELEMENTO")
  END IF
END SUB

SUB op_10x
  IF tope >= 1 THEN
    x = pila_desapilar()
    pila_apilar 10 ^ x  
  ELSE
    mostrar_error("REQ. UN ELEMENTO")
  END IF
END SUB
'--------------------------------------
SUB op_abs
  IF tope >= 1 THEN
    x = pila_desapilar()
    pila_apilar ABS(x)
  ELSE
    mostrar_error("REQ. UN ELEMENTO")
  END IF
END SUB

SUB op_int
  IF tope >= 1 THEN
    x = pila_desapilar()
    pila_apilar INT(x)
  ELSE
    mostrar_error("REQ. UN ELEMENTO")
  END IF
END SUB

SUB op_frac
  IF tope >= 1 THEN
    x = pila_desapilar()
    pila_apilar x - INT(x)
  ELSE
    mostrar_error("REQ. UN ELEMENTO")
  END IF
END SUB

' Signo (-1,0,1)
SUB op_sgn
  IF tope >= 1 THEN
    x = pila_desapilar()
    pila_apilar SGN(x)
  ELSE
    mostrar_error("REQ. UN ELEMENTO")
  END IF
END SUB

SUB op_fact
  IF tope >= 1 THEN
    x = pila_desapilar()
    IF x < 0 OR INT(x) <> x THEN
      mostrar_error("DOMINIO n>=0, ENTERO")
      pila_apilar x
    ELSE
      res = 1
      FOR i = 1 TO x
        res = res * i
      NEXT
      pila_apilar res
    END IF
  ELSE
    mostrar_error("REQ. UN ELEMENTO")
  END IF
END SUB

' Primo? (1 si, 0 no)
SUB op_primo
  IF tope >= 1 THEN
    x = pila_desapilar()
    IF x < 2 OR INT(x) <> x THEN
      pila_apilar 0
    ELSE
      esPrimo = 1
      FOR i = 2 TO INT(SQR(x))
        IF x MOD i = 0 THEN
          esPrimo = 0
          EXIT FOR
        END IF
      NEXT
      pila_apilar esPrimo
    END IF
  ELSE
    mostrar_error("REQ. UN ELEMENTO")
  END IF
END SUB

SUB op_mcd
  IF tope >= 2 THEN
    b = pila_desapilar()
    a = pila_desapilar()
    a = INT(ABS(a))
    b = INT(ABS(b))
    DO WHILE b <> 0
      t = b
      b = a MOD b
      a = t
    LOOP
    pila_apilar a
  ELSE
    mostrar_error("REQ. DOS ELEMENTOS")
  END IF
END SUB

SUB op_mcm
  IF tope >= 2 THEN
    b = pila_desapilar()
    a = pila_desapilar()
    IF a=0 OR b=0 THEN
      pila_apilar 0
    ELSE
      aa = INT(ABS(a))
      bb = INT(ABS(b))
      x = aa : y = bb
      DO WHILE y <> 0
        t = y
        y = x MOD y
        x = t
      LOOP
      mcd = x
      pila_apilar (aa \ mcd) * bb  
    END IF
  ELSE
    mostrar_error("REQ. DOS ELEMENTOS")
  END IF
END SUB
'--------------------------------------

FUNCTION es_numero(s$)
  LOCAL t$, i, c$, tiene_punto, en_exp, digitos, digitos_exp
  t$ = LTRIM$(RTRIM$(s$))
  IF t$ = "" THEN es_numero = 0 : EXIT FUNCTION

  i = 1
  IF MID$(t$,1,1) = "+" OR MID$(t$,1,1) = "-" THEN
    IF LEN(t$) = 1 THEN es_numero = 0 : EXIT FUNCTION
    i = 2
  END IF

  tiene_punto = 0 : en_exp = 0 : digitos = 0 : digitos_exp = 0

  DO WHILE i <= LEN(t$)
    c$ = MID$(t$, i, 1)
    IF c$ >= "0" AND c$ <= "9" THEN
      IF en_exp = 0 THEN
        digitos = digitos + 1
      ELSE
        digitos_exp = digitos_exp + 1
      END IF

    ELSEIF c$ = "." AND tiene_punto = 0 AND en_exp = 0 THEN
      tiene_punto = 1

    ELSEIF (c$ = "E" OR c$ = "e") AND en_exp = 0 THEN
      en_exp = 1
      IF i < LEN(t$) THEN
        IF MID$(t$, i + 1, 1) = "+" OR MID$(t$, i + 1, 1) = "-" THEN
          i = i + 1
        END IF
      END IF
      IF i = LEN(t$) THEN es_numero = 0 : EXIT FUNCTION

    ELSE
      es_numero = 0 : EXIT FUNCTION
    END IF
    i = i + 1
  LOOP

  IF digitos = 0 THEN es_numero = 0 : EXIT FUNCTION
  IF en_exp = 1 AND digitos_exp = 0 THEN es_numero = 0 : EXIT FUNCTION

  es_numero = 1
END FUNCTION

'--------------------------------------
FUNCTION LTRIM$(s$)
  LOCAL i
  i = 1
  DO WHILE i <= LEN(s$) AND MID$(s$, i, 1) = " "
    i = i + 1
  LOOP
  LTRIM$ = MID$(s$, i)
END FUNCTION

'--------------------------------------
FUNCTION RTRIM$(s$)
  LOCAL j 
  j = LEN(s$)
  DO WHILE j >= 1 AND MID$(s$, j, 1) = " "
    j = j - 1
  LOOP
  IF j = 0 THEN
    RTRIM$ = ""
  ELSE
    RTRIM$ = LEFT$(s$, j)
  END IF
END FUNCTION

'--------------------------------------
FUNCTION TRIM$(s$)
  TRIM$ = LTRIM$(RTRIM$(s$))
END FUNCTION

'--------------------------------------
FUNCTION formatear_numero$(valor)
  LOCAL temp$, absv, dig_int, prec, fmt$, s$
  LOCAL exp, mant, logv, frac
  LOCAL posE, mantisa$, exponente$

  IF valor = 0 THEN
    formatear_numero$ = "0"
    EXIT FUNCTION
  END IF

  IF valor < 1 THEN
    absv = valor * (-1)
  ELSE
    absv = valor
  END IF

  SELECT CASE FORMATO$
    CASE "NORM"
      ON ERROR SKIP
      logv = LOG(absv) / LOG(10)
      ON ERROR ABORT

      IF absv >= 1 THEN
        dig_int = INT(logv) + 1
      ELSE
        dig_int = 0
      END IF
      IF dig_int <= 13 THEN
        prec = 13 - dig_int
        IF prec < 0 THEN prec = 0
        IF prec > 12 THEN prec = 12
        s$ = LTRIM$(STR$(prec))
        fmt$ = "%." + s$ + "f"
      ELSE
        fmt$ = "%.12g"
      END IF
      temp$ = FORMAT$(valor, fmt$)


    CASE "FIX"
      ON ERROR SKIP
      logv = LOG(absv) / LOG(10)
      ON ERROR ABORT

      s$ = LTRIM$(STR$(DECIM))
      IF logv > 18 THEN
        fmt$ = "%." + s$ + "e"
      ELSE
        fmt$ = "%." + s$ + "f"
      END IF
      temp$ = FORMAT$(valor, fmt$)


    CASE "SCI"
      ON ERROR SKIP
      logv = LOG(absv) / LOG(10)
      ON ERROR ABORT

      exp  = INT(logv)
      frac = logv - exp
      mant = SGN(valor) * (10 ^ frac)

      s$ = LTRIM$(STR$(DECIM))
      fmt$ = "%." + s$ + "f"
      temp$ = FORMAT$(mant, fmt$)

      IF exp >= 0 THEN
        exponente$ = "E+" + LTRIM$(STR$(exp))
      ELSE
        exponente$ = "E" + LTRIM$(STR$(exp)) 
      END IF
      temp$ = temp$ + exponente$


    CASE "ENG"
      ON ERROR SKIP
      logv = LOG(absv) / LOG(10)
      ON ERROR ABORT

      exp  = INT(logv)
      exp  = exp - (exp MOD 3)
      frac = logv - exp
      mant = SGN(valor) * (10 ^ frac)

      s$ = LTRIM$(STR$(DECIM))
      fmt$ = "%." + s$ + "f"
      temp$ = FORMAT$(mant, fmt$)

      IF exp >= 0 THEN
        exponente$ = "E+" + LTRIM$(STR$(exp))
      ELSE
        exponente$ = "E" + LTRIM$(STR$(exp))
      END IF
      temp$ = temp$ + exponente$

    CASE ELSE
      temp$ = STR$(valor)
  END SELECT

  posE = INSTR(UCASE$(temp$), "E")
  IF posE > 0 THEN
    mantisa$    = LEFT$(temp$, posE - 1)
    exponente$  = MID$(temp$,  posE)  
  ELSE
    mantisa$   = temp$
    exponente$ = ""
  END IF

  IF INSTR(mantisa$, ".") > 0 THEN
    DO WHILE RIGHT$(mantisa$, 1) = "0"
      mantisa$ = LEFT$(mantisa$, LEN(mantisa$) - 1)
    LOOP
    IF RIGHT$(mantisa$, 1) = "." THEN
      mantisa$ = LEFT$(mantisa$, LEN(mantisa$) - 1)
    END IF
  END IF

  temp$ = mantisa$ + exponente$

  formatear_numero$ = temp$
END FUNCTION


'-------------------------------------
SUB ver_ayuda(texto$(), total)
  LOCAL pag, pags, i, idx, inicio, y, k$

  IF total < 1 THEN 
    EXIT SUB
  END IF
  pags = INT((total + 17) / 18)  
  pag = 1

  DO
    COLOR RGB(WHITE), RGB(BLACK)
    CLS

    inicio = (pag - 1) * 18 + 1
    FOR i = 0 TO 17
      idx = inicio + i
      y = i * 18
      IF idx <= total THEN
        TEXT 0, y, ajustar$(texto$(idx))
      ELSE
        EXIT FOR
      END IF
    NEXT i

    COLOR RGB(160,160,255) , RGB(white)
    aux$ = "("+STR$(pag)+"/"+STR$(pags)+")  [ESC] Salir              "
    TEXT 0, 304, aux$
    COLOR RGB(WHITE), RGB(BLACK)

    k$ = leer_tecla_paginador$() 
    SELECT CASE k$
      CASE "LEFT","UP","<"
        IF pag > 1 THEN pag = pag - 1
      CASE "RIGHT","DOWN",">"
        IF pag < pags THEN pag = pag + 1
      CASE "ESC"
        EXIT DO
    END SELECT
  LOOP

END SUB


FUNCTION ajustar$(s$)
  IF LEN(s$) <= 40 THEN
    ajustar$ = s$
  ELSE
    ajustar$ = LEFT$(s$, 40)
  END IF
END FUNCTION


FUNCTION leer_tecla_paginador$()
  LOCAL k$, k2$, k3$, t

  DO
    k$ = INKEY$
    IF k$ <> "" THEN
      SELECT CASE k$
        CASE CHR$(27), CHR$(8), CHR$(145)
          leer_tecla_paginador$ = "ESC"
          EXIT FUNCTION
        CASE CHR$(145),CHR$(128)
          leer_tecla_paginador$ = "UP"
          EXIT FUNCTION
        CASE CHR$(146),CHR$(129)  
            leer_tecla_paginador$ = "DOWN"
            EXIT FUNCTION
      END SELECT
    END IF
    PAUSE 10
  LOOP
END FUNCTION

SUB cargar_ayuda
  ayuda$(1)  = "  TRIGONOMETRIA"
  ayuda$(2)  = ""
  ayuda$(3)  = "SIN    seno"
  ayuda$(4)  = "COS    coseno"
  ayuda$(5)  = "TAN    tangente"
  ayuda$(6)  = "ASIN   arco seno"
  ayuda$(7)  = "ACOS   arco coseno"
  ayuda$(8)  = "ATAN   arco tangente"
  ayuda$(9)  = ""
  ayuda$(10)  = "  Hiperbolicas"
  ayuda$(11) = "SINH   seno"
  ayuda$(12) = "COSH   coseno"
  ayuda$(13) = "TANH   tangente"
  ayuda$(14) = "ASINH  arco seno"
  ayuda$(15) = "ACOSH  arco coseno"
  ayuda$(16) = "ATANH  arco tangente"
  ayuda$(17) = ""
  ayuda$(18) = ""

  ayuda$(19) = "  LOGARITMO/EXPONENCIAL"
  ayuda$(20) = ""
  ayuda$(21) = "LN     logaritmo natural"
  ayuda$(22) = "LOG    logaritmo base 10"
  ayuda$(23) = "EXP    e^x"
  ayuda$(24) = "10^X   potencia de 10"
  ayuda$(25) = ""
  ayuda$(26) = "  ENTEROS"
  ayuda$(27) = ""
  ayuda$(28) = "ABS   valor absoluto"
  ayuda$(29) = "INT   parte entera"
  ayuda$(30) = "FRAC  parte fraccionaria"
  ayuda$(31) = "SGN   signo (-1,0,1)"
  ayuda$(32) = "FACT  factorial (n!)"
  ayuda$(33) = "PRIMO 1=primo, 2=no primo"
  ayuda$(34) = "MCD   maximo comun divisor"
  ayuda$(35) = "MCM   minimo comun mult."
  ayuda$(36) = ""

  ayuda$(37) = "  MENU ANGULOS"
  ayuda$(38) = ""
  ayuda$(39) = "DEG>RAD grados a radianes"
  ayuda$(40) = "RAD>DEG radianes a grados"
  ayuda$(41) = "DEG>GRA grados a gradianes"
  ayuda$(42) = "GRA>DED gradianes a grados"
  ayuda$(43) = "DEG>DMS grados a DMS"
  ayuda$(44) = "DMS>DEM DMS a grados"
  ayuda$(45) = ""
  ayuda$(46) = "  MENU CONSTANTES"
  ayuda$(47) = ""
  ayuda$(48) = "PI   3.141592653589..."
  ayuda$(49) = "e    numero de Euler"
  ayuda$(50) = "PHI  numero aureo"
  ayuda$(51) = "c    velocidad de la luz"
  ayuda$(52) = "G    cte gravitatoria"
  ayuda$(53) = "h    cte de Planck"
  ayuda$(54) = "qe   carga electron"
END SUB

SUB C_MenuOp
  COLOR RGB(180,180,255),RGB(WHITE)
END SUB

SUB C_MenuOpSel
  C_MenuTitulo
END SUB

SUB C_MenuTitulo
  COLOR RGB(WHITE),RGB(150,150,255)
END SUB

