' =====================================
'  Espirografo en PicoCalc / MMBasic
'  Hipotrocoide / Epitrocoide 
'  Ariel Palazzesi 2025
' =====================================
OPTION ANGLE RADIANS
PI = 3.14159265358979
RANDOMIZE TIMER

'Resolucion de pantalla
ANCHO   = MM.HRES
ALTO    = MM.VRES
ctroX   = ANCHO \ 2
ctroY   = ALTO  \ 2
FONT 7,2

' Valores iniciales
HOE$       = "H"
R1         = 80
R2         = 21
D          = 14
ESCALA     = 2
flag_cls   = 1
paso_color = 0
ModoColor  = 0 'No cambia

clrFondo = RGB(BLACK)
COLOR RGB(WHITE), clrFondo
CLS
MostrarAyuda
DibujarUI

' Bucle principal
DO
  k$ = INKEY$
  IF k$ <> "" THEN
    IF k$ = CHR$(27) THEN EXIT DO 
    ku$ = UCASE$(k$)
    SELECT CASE ku$
      CASE "E", "H"
        HOE$ = ku$
        DibujarUI

      CASE "A"
        R1  = R1  + 1
        DibujarUI

      CASE "Z"
        IF R1  > 1 THEN
          R1  = R1  - 1
          DibujarUI
        END IF 

      CASE "S"
        R2 = R2 + 1
        DibujarUI

      CASE "X"
        IF R2 > 1 THEN
          R2 = R2 - 1
          DibujarUI
        END IF

      CASE "D"
        D = D + 1
        DibujarUI

      CASE "C"
        IF D > 0 THEN
          D = D - 1
          DibujarUI
        END IF

      CASE "M"
        IF ModoColor = 1 THEN
          ModoColor = 0
        ELSE
          ModoColor = 1
        END IF
        DibujarUI

      CASE CHR$(145) ' F1 
        MostrarAyuda
        DibujarUI

      CASE CHR$(13)
        DibujarCurva
        DibujarUI

      CASE chr$(27), CHR$(8)
        EXIT DO
    END SELECT
    
    pause 10
  END IF
LOOP

'--- Salida
COLOR RGB(GREEN), RGB(BLACK)
Save Image "spiro1.bmp", 0, 0, 319, 319
DRIVE "B:"
CHDIR "B:/bas/graficos/"
RUN "menu.bas"
END

'----------------------------------------------
SUB MostrarAyuda
  COLOR RGB(GOLD), clrFondo
  CLS
  TEXT 0, 0, "        ESPIROGRAFO"
  TEXT 0, 20, "Hipotrocoide / Epitrocoide"

  COLOR RGB(WHITE), clrFondo
  y = 60
  x = 115
  TEXT x,  y+ 00,"Aumentar R"
  TEXT x,  y+ 20,"Disminuir R"
  TEXT x,  y+ 50,"Aumentar r"
  TEXT x,  y+ 70,"Disminuir r"
  TEXT x,  y+100,"Aumentar D"
  TEXT x,  y+120,"Disminuir D"
  TEXT x,  y+150,"Modo Color"

  TEXT x,  y+180,"Ayuda"
  TEXT x,  y+200,"Dibujar Grafico"
  TEXT x,  y+220,"Salir"

  COLOR RGB(GREEN), clrFondo
  y = 60
  x = 17 
  TEXT x,  y+ 00,"    A >"
  TEXT x,  y+ 20,"    Z >"
  TEXT x,  y+ 50,"    S >"
  TEXT x,  y+ 70,"    X >"
  TEXT x,  y+100,"    D >"
  TEXT x,  y+120,"    C >"
  TEXT x,  y+150,"    M >"

  TEXT x,  y+180,"   F1 >"
  TEXT x,  y+200,"ENTER >"
  TEXT x,  y+220,"  ESC >"

  DO : k$ = INKEY$ : LOOP WHILE k$ = ""
  CLS
END SUB

'----------------------------------------------
SUB DibujarCurva
  IF flag_cls THEN 
   COLOR RGB(WHITE), RGB(BLACK)
   CLS
  END IF

  ' Periodo de cierre
  g = MCD2(R1 , R2)
  theta_max = 2.0 * PI * (R2 / g+0.0)

  ' Paso angular
  seg = 4000   ' 3000-6000 
  dt  = theta_max / seg

  'color
  h! = 0.0 : s! = 1.0 : v! = 1.0
  h_inc! = 1.0 / (seg + 0.0)
  

  gT = 0.0
  x0 = PuntoX() : y0 = PuntoY()
  px = ctroX + x0 * ESCALA 
  py = ctroY - y0 * ESCALA 

  FOR gT = dt TO theta_max STEP dt
    x1 = PuntoX() : y1 = PuntoY()
    xpix = ctroX + x1 * ESCALA 
    ypix = ctroY - y1 * ESCALA 

    'Calcular color
    IF ModoColor THEN 
      paso_color= paso_color+ 1
    END IF

    IF (paso_color MOD 3) = 0 THEN
      HSVaRGB h!, s!, v!, r%, verd%, b%
      h! = h! + h_inc! : IF h! >= 1.0 THEN h! = h! - 1.0
    END IF

    LINE px, py, xpix, ypix, , RGB(r%, verd%, b%)
    px = xpix : py = ypix
  NEXT gT
  DO : k$ = INKEY$ : LOOP WHILE k$ = ""

END SUB

'----------------------------------------------
SUB DibujarUI
  COLOR RGB(YELLOW), RGB(BLACK)
  info$ = "Tipo:"+HOE$+"  R:"+STR$(R1 )+"  r:"+STR$(R2)+"  d:"+STR$(D)
  TEXT 9, ALTO - 18, STRING$(40," ")
  TEXT 0, ALTO - 18, info$
END SUB

'----------------------------------------------
FUNCTION PuntoX()
  IF HOE$ = "H" THEN
    PuntoX = (R1  - R2) * COS(gT) + D * COS((R1  - R2) * gT / R2)
  ELSE
    PuntoX = (R1  + R2) * COS(gT) - D * COS((R1  + R2) * gT / R2)
  ENDIF
END FUNCTION

'----------------------------------------------
FUNCTION PuntoY()
  IF HOE$ = "H" THEN
    PuntoY = (R1  - R2) * SIN(gT) - D * SIN((R1  - R2) * gT / R2)
  ELSE
    PuntoY = (R1  + R2) * SIN(gT) - D * SIN((R1  + R2) * gT / R2)
  ENDIF
END FUNCTION

'--------------------------------------
FUNCTION MCD2(a, b)
  'LOCAL x, y, t
  x = a : y = b
  IF x < 0 THEN x = -x
  IF y < 0 THEN y = -y
  IF y = 0 THEN MCD2 = x : EXIT FUNCTION
  DO WHILE y <> 0
    t = x MOD y
    x = y
    y = t
  LOOP
  MCD2 = x
END FUNCTION

'-------Conversion HSV -> RGB----------
SUB HSVaRGB(h!, s!, v!, BYREF r%, BYREF verd%, BYREF b%)
  hh! = h! * 6.0
  i%  = INT(hh!)
  f!  = hh! - i%
  p! = v! * (1.0 - s!)
  q! = v! * (1.0 - f! * s!)
  t! = v! * (1.0 - (1.0 - f!) * s!)

  SELECT CASE i% MOD 6
    CASE 0
      rp! = v! : gp! = t! : bp! = p!
    CASE 1
      rp! = q! : gp! = v! : bp! = p!
    CASE 2
      rp! = p! : gp! = v! : bp! = t!
    CASE 3
      rp! = p! : gp! = q! : bp! = v!
    CASE 4
      rp! = t! : gp! = p! : bp! = v!
    CASE ELSE
      rp! = v! : gp! = p! : bp! = q!
  END SELECT

  r%=INT(rp!*255.0+0.5) : IF r%<0 THEN r% = 0 ELSE IF r%>255 THEN r%=255
  verd%=INT(gp!*255.0+0.5) : IF verd%<0 THEN verd% = 0 ELSE IF verd%>255 THEN verd%=255
  b%=INT(bp!*255.0+0.5) : IF b%<0 THEN b% = 0 ELSE IF b%>255 THEN b%=255
END SUB
