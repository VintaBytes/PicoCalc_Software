'-----------------------------------------------------------
'MINNESOTA EDUCATIONAL COMPUTING CONSORTIUM STAFF
'PROGRAMMING REVISIONS BY DON RAWITSCH - 1975
'CURRENT VERSION - 09/2025 - Ariel Palazzesi
'-----------------------------------------------------------
PRINT : PRINT 
Titulo("OREGON TRAIL")
PRINT : COLOR RGB(white)
PRINT "                    _____________ "
PRINT "                   (   (  |  )   )"
PRINT "                    (  (  |  )  ) "
PRINT "     (__)         __|___________| "
PRINT "     (oo)------/   |            | "
PRINT "     (__)    ||====|____________| "
PRINT "        ||---||      (X)    (x)   "  
PRINT : COLOR RGB(green)
PRINT
PRINT
PRINT CENTRAR$("Creado en 1975 por Don Rawitsch,")
PRINT CENTRAR$("Bill Heinemann y Paul Dillenberger.")
PRINT
PRINT CENTRAR$("Adaptado a PicoCalc en 2025") 
PRINT CENTRAR$("por Ariel Palazzesi.")

PRINT:PRINT:PRINT
INPUT "Necesita instrucciones (s/n)"; a1$
ValidarSioNo
IF SiNo = 0 THEN
  CLS
  Titulo("INSTRUCCIONES")
  PRINT
  PRINT "Este programa simula  un viaje por el"
  PRINT "Camino de Oregon, que va de Independence"
  PRINT "(Missouri) a Oregon City (Oregon), en"
  PRINT "1847."
  PRINT "Tu familia de cinco personas recorrera"
  PRINT "las 2000 millas del Camino de Oregon en"
  PRINT "5 o 6 meses. ";
  COLOR RGB(gold) : PRINT "Si sobreviven."
  COLOR RGB(green)
  PRINT
  PRINT "Has ahorrado 900 dolares para gastar en" 
  PRINT "este viaje, y acabas de pagar $200 por"
  PRINT "una carreta. Necesitaras usar el dinero"
  PRINT "restante para comprar los siguientes"
  PRINT "articulos:"
  PRINT
  COLOR RGB(gold) : PRINT "Bueyes: "; : COLOR RGB(green)
  PRINT "puedes gastar entre  $200 y $300" 
  PRINT "en tus bueyes. Cuanto mas gastes, mas"
  PRINT "rapido viajaras, porque tendras mejores"
  PRINT "animales."
  PRINT
  COLOR RGB(gold) : PRINT "Comida: "; : COLOR RGB(green)
  PRINT "cuanto mas tengas, menor sera la"
  PRINT "posibilidad de enfermar."
  PresionarTecla
  CLS
  COLOR RGB(gold) : PRINT "Municiones: "; : COLOR RGB(green)
  PRINT "cada cinturon  con  50 balas"
  PRINT "cuesta $1. Necesitas balas para repeler"
  PRINT "ataques de animales o bandidos, y para"
  PRINT "cazar comida."
  PRINT
  COLOR RGB(gold) : PRINT "Ropa: "; : COLOR RGB(green)
  PRINT "especialmente  importante para  el"
  PRINT "frio que encontraras al atravesar las"
  PRINT "montanas."
  PRINT
  COLOR RGB(gold) : PRINT "Suministros varios: "; : COLOR RGB(green)
  PRINT "incluyen medicinas y"
  PRINT "otras cosas que necesitaras para tratar"
  PRINT "enfermedades y reparaciones del equipo."
  PRINT
  PRINT "Puedes gastar  todo tu  dinero  antes de" 
  PRINT "comenzar el viaje, o puedes guardar algo"
  PRINT "para gastar en  los fuertes en el camino"
  PRINT "cuando  te quedes  sin provisiones.  Sin"
  PRINT "embargo, los  articulos son mas caros en"
  PRINT "los fuertes.  Tambien puedes ir a  cazar"
  PRINT "durante el viaje para conseguir comida."
  PresionarTecla
  CLS  
  PRINT "Cada vez  que debas  usar tu  confiable"
  PRINT "rifle en el camino, aparecera el mensaje"
  COLOR RGB(gold)
  PRINT "escribe bang. "; 
  COLOR RGB(green)
  PRINT "Cuanto mas rapido escribas"
  PRINT "la palabra BANG y presiones tecla ENTER,"
  PRINT "mejor suerte tendras con tu arma."
  PRINT
  PRINT "Cuando se te pida ingresar cantidades de"
  PRINT "dinero, no uses '$'."
  PRINT
  COLOR RGB(gold)
  PRINT CENTRAR$("Buena suerte!!!")
  COLOR RGB(green)
  PresionarTecla
  CLS
END IF

'--------------------------------------
' COMPRAS INICIALES
'--------------------------------------
COMPRAS_INICIALES:
DO 
  X1=-1
  K8=0: S4=0: F1=0: F2=0: M=0: M9=0: D3=0

  PRINT
  Titulo("COMPRAS INICIALES:")
  PRINT

  DO
    PRINT "Cuanto quieres gastar en tu equipo de"
    INPUT "bueyes"; A
    IF A < 200 THEN
      PRINT "No es suficiente."
    ELSEIF A > 300 THEN
      PRINT "Es demasiado."
    ELSE
      EXIT DO
    ENDIF
  LOOP

  DO
    INPUT "Cuanto quieres gastar en comida"; F
    IF F < 0 THEN
      PRINT "Imposible."
    ELSE
      EXIT DO
    ENDIF
  LOOP

  DO
    INPUT "Cuanto quieres gastar en municiones"; B
    IF B < 0 THEN
      PRINT "Imposible."
    ELSE
      EXIT DO
    ENDIF
  LOOP

  DO
    INPUT "Cuanto quieres gastar en ropa"; C
    IF C < 0 THEN
      PRINT "Imposible."
    ELSE
      EXIT DO
    ENDIF
  LOOP

  DO
    PRINT "Cuanto quieres gastar en suministros"
    INPUT "varios"; M1
    IF M1 < 0 THEN
      PRINT "Imposible."
    ELSE
      EXIT DO
    ENDIF
  LOOP

  ' presupuesto total y validacion
  T = 700 - A - F - B - C - M1
  IF T < 0 THEN
    PRINT "Te excediste: solo tenias 700 dolares"
    PRINT "para gastar. Has gastado $ "; T*(-1); " de"
    PRINT "mas. Vuelve a realizar las compras."
    PresionarTecla
    CLS
  ELSE
    EXIT DO
  ENDIF
LOOP

B = 50 * B '1 dolar = 50 balas
PRINT
PRINT "Finalizadas las compras. Quedan $"; T
COLOR RGB(white) : 
PRINT STRING$(40,"_")
PRINT 
Titulo("Lunes 29 de marzo de 1847")
PRINT

'--------------------------------------
' INICIO DEL JUEGO
'--------------------------------------
GOTO COMIENZO_TURNO

'--------------------------------------
' FECHA DE CADA QUINCENA
'--------------------------------------
FECHA_QUINCENA:
IF M >= 2040 OR D3 > 17 THEN GOTO LLEGADA_FINAL

D3 = D3 + 1
fecha_aux$ = "Lunes "
SELECT CASE D3
  CASE 1:  fecha_aux$ = fecha_aux$ + "12 de Abril "
  CASE 2:  fecha_aux$ = fecha_aux$ + "26 de Abril "
  CASE 4:  fecha_aux$ = fecha_aux$ + "24 de Mayo "
  CASE 5:  fecha_aux$ = fecha_aux$ + "7 de Junio "
  CASE 6:  fecha_aux$ = fecha_aux$ + "21 de Junio "
  CASE 7:  fecha_aux$ = fecha_aux$ + "5 de Julio "
  CASE 8:  fecha_aux$ = fecha_aux$ + "19 de Julio "
  CASE 9:  fecha_aux$ = fecha_aux$ + "2 de Agosto "
  CASE 10: fecha_aux$ = fecha_aux$ + "16 de Agosto "
  CASE 11: fecha_aux$ = fecha_aux$ + "31 de Agosto "
  CASE 12: fecha_aux$ = fecha_aux$ + "13 de Septiembre "
  CASE 13: fecha_aux$ = fecha_aux$ + "27 de Septiembre "
  CASE 14: fecha_aux$ = fecha_aux$ + "11 de Octubre "
  CASE 15: fecha_aux$ = fecha_aux$ + "25 de Octubre "
  CASE 16: fecha_aux$ = fecha_aux$ + "8 de Noviembre "
  CASE 17: fecha_aux$ = fecha_aux$ + "22 de Noviembre "
END SELECT

fecha_aux$ = fecha_aux$ + "de 1847"
COLOR RGB(white) : 
PRINT STRING$(40,"_")
PRINT 
Titulo(fecha_aux$)
PRINT

'GOTO COMIENZO_TURNO

'--------------------------------------
' COMIENZO DE CADA TURNO
'--------------------------------------
COMIENZO_TURNO:
PRINT
IF F < 0 THEN F=0
IF B < 0 THEN B=0
IF C < 0 THEN C=0
IF M1 < 0 THEN M1=0
IF F < 12 THEN 
  PRINT "Mejor que salgas a cazar, o compres"
  PRINT "comida pronto!!!!"
END IF

F=INT(F): B=INT(B): C=INT(C): M1=INT(M1)
T=INT(T): M=INT(M): M2=M

IF NOT (S4=1 OR K8=1) THEN GOTO MOSTRAR_MILLAJE
T=T-20
IF T<0 THEN GOTO SIN_DINERO_MEDICO
PRINT "La factura del doctor es $ 20."
K8=0: S4=0

MOSTRAR_MILLAJE:
IF M9=1 THEN
  PRINT "Millaje restante: 950"
  M9=0
ELSE
  PRINT "Millaje recorrido:"; M
END IF

PRINT "COMIDA  BALAS  ROPA  SUMINISTROS  DINERO"
PRINT TAB(2);F;
PRINT TAB(9);B;
PRINT TAB(16);C;
PRINT TAB(25);M1;
PRINT TAB(36);"$";T
PRINT

' decision de accion
IF X1=-1 THEN
  X1=X1*-1
  PRINT
  PRINT "Quieres:"
  PRINT "   (1) Parar en el proximo fuerte,"
  PRINT "   (2) cazar,"
  PRINT "   (3) continuar."
  INPUT "Tu opcion";X

  IF X<1 OR X>3 THEN X=3
ELSE
  PRINT
  PRINT "Quieres:"
  PRINT "   (1) cazar,"
  PRINT "   (2) continuar."
  INPUT "Tu opcion";X

  X=X+1
  IF X=3 AND B<=39 THEN
    PRINT
    PRINT "Imposible. Necesitas mas balas para ir a"
    PRINT "cazar"
    GOTO COMIENZO_TURNO
  END IF
  X1=X1*-1
END IF

SELECT CASE X
  CASE 1: GOTO PARAR_EN_FUERTE
  CASE 2: GOTO CAZAR
  CASE ELSE: GOTO CONTINUAR_RUTA
END SELECT

'--------------------------------------
' PARADA EN FUERTE
'--------------------------------------
PARAR_EN_FUERTE:
PRINT
PRINT "Ingresa lo que deseas gastar en cada"
PRINT "rubro."
PRINT

PRINT "Comida";
GOSUB ENTRADA_COMPRA
F=F + (2/3)*P

PRINT "Municion";
GOSUB ENTRADA_COMPRA
B=INT(B + (2/3)*P*50)

PRINT "Ropa";
GOSUB ENTRADA_COMPRA
C=C + (2/3)*P

PRINT "Suministros varios:";
GOSUB ENTRADA_COMPRA
M1=M1 + (2/3)*P

M=M-45
GOTO CONTINUAR_RUTA

'-------------------------------------
' CAZA
'-------------------------------------
CAZAR:
IF B<=39 THEN
  PRINT "Imposible. Necesitas mas balas para ir a"
  PRINT "cazar."
  GOTO COMIENZO_TURNO
END IF

M=M-45
GOSUB SUBRUTINA_DISPARO

IF B1 > 2 THEN
  IF 100*RND(0) < 13*B1 THEN
    PRINT "Lo siento... hoy no hubo suerte."
  ELSE
    F=F + 48 - 2*B1
    PRINT "Buen tiro, justo en el cuello."
    PRINT "Hay fiesta esta noche!!"
    B=B - 10 - 3*B1
  END IF
ELSE
  PRINT "Justo entre los ojos... "
  PRINT "Cazaste uno grande!!"
  F=F + 52 + RND(0)*6
  B=B - 10 - RND(0)*4
END IF

GOTO CONTINUAR_RUTA

'--------------------------------------
' CONTINUAR RUTA (COMER, EVENTOS, ETC.)
'--------------------------------------
CONTINUAR_RUTA:
IF F < 13 THEN GOTO SIN_COMIDA

PRINT
PRINT "Quieres:"
PRINT "   (1) Comer solo un poco,"
PRINT "   (2) Comer de forma moderada,"
PRINT "   (3) Comer opiparamente."
INPUT "Tu opcion";E

IF E<1 OR E>3 THEN GOTO CONTINUAR_RUTA
E=INT(E)
F=F - 8 - 5*E
IF F < 0 THEN
  F=F + 8 + 5*E
  PRINT "No puedes comer tan bien..."
  GOTO CONTINUAR_RUTA
END IF

' avanzar
M = M + 200 + (A-220)/5 + 10*RND(0)
L1=0: C1=0

' jinetes
IF RND(0)*10 <= ((M/100-4)^2+72)/((M/100-4)^2+12)-1 THEN GOTO JINETES
GOTO EVENTOS

'--------------------------------------
' JINETES ADELANTE
'--------------------------------------
JINETES:
PRINT
PRINT "Ves jinetes adelante."
PRINT "Ellos ";
S5=0
IF RND(0) < .8 THEN
  ' nada
ELSE
  PRINT "no ";
  S5=1
END IF
PRINT "parecen hostiles."
PRINT
PRINT "Tacticas posibles:"
PRINT "   (1) Correr,"
PRINT "   (2) Atacar,"
PRINT "   (3) Continuar,"
PRINT "   (4) Formar circulo."
PRINT
PRINT "Si corres ganaras tiempo, pero cansaras"
PRINT "a los bueyes."
PRINT "Si formas circulo perderas tiempo."
PRINT

IF RND(0) <= .2 THEN S5=1-S5

INPUT "Tu opcion";T1
IF T1<1 OR T1>4 THEN GOTO JINETES
T1=INT(T1)

IF S5=1 THEN GOTO JINETES_AMIGOS

' hostiles (S5=0)
IF T1=1 THEN
  M=M+20: M1=M1-15: B=B-150: A=A-40
  GOTO JINETES_FIN
ELSEIF T1=2 THEN
  GOSUB SUBRUTINA_DISPARO
  B=B - B1*40 - 80
  IF B1<=1 THEN
    PRINT "Buenos disparos... Los alejaste."
    GOTO JINETES_FIN
  ELSEIF B1>4 THEN
    PRINT "Mal tiro... te acuchillaron."
    K8=1
    PRINT "Tendras que ver al viejo Doc Blanchard."
    GOTO JINETES_FIN
  ELSE
    PRINT "Algo lento con tu Colt .45"
    GOTO JINETES_FIN
  END IF
ELSEIF T1=3 THEN
  IF RND(0) <= .8 THEN
    B=B-150: M1=M1-15
  ELSE
    PRINT "No atacaron."
    GOTO EVENTOS
  END IF
  GOTO JINETES_FIN
ELSE
  GOSUB SUBRUTINA_DISPARO
  B=B - B1*30 - 80
  M=M-25
  IF B < 0 THEN
    PRINT "Te quedaste sin balas y los jinetes te"
    PRINT "masacraron."
    GOTO MUERTE
  END IF
  GOTO JINETES_FIN2
END IF

JINETES_AMIGOS:
IF T1=1 THEN
  M=M+15: A=A-10
ELSEIF T1=2 THEN
  M=M-5: B=B-100
ELSEIF T1=3 THEN
  ' nada
ELSE
  M=M-20
END IF

JINETES_FIN:
IF S5=1 THEN
  PRINT "Los jinetes eran amistosos, pero revisa"
  PRINT "posibles perdidas."
ELSE
  PRINT "Los jinetes eran hostiles. Revisa tus"
  PRINT "perdidas."
END IF
IF B < 0 THEN
  PRINT "Te quedaste sin balas y los jinetes te"
  PRINT "masacraron."
  GOTO MUERTE
END IF
GOTO EVENTOS

JINETES_FIN2:
IF S5=1 THEN
  PRINT "Los jinetes eran amistosos, pero revisa"
  PRINT "posibles perdidas."
ELSE
  PRINT "Los jinetes eran hostiles. Revisa tus"
  PRINT "perdidas."
END IF
IF B < 0 THEN
  PRINT "Te quedaste sin balas y los jinetes te"
  PRINT "masacraron."
  GOTO MUERTE
END IF

'--------------------------------------
' SELECCION DE EVENTOS
'--------------------------------------
EVENTOS:
D1=0
RESTORE
R1=100*RND(TIM(0))

EVENTO_BUCLE:
  D1=D1+1
  IF D1=16 THEN GOTO INDIOS_AYUDA
  READ D 
  IF R1 > D THEN GOTO EVENTO_BUCLE

  ' tabla de corte
  DATA 6,11,13,15,17,22,32,35,37,42,44,54,64,69,95
  IF D1<=10 THEN
    SELECT CASE D1
      CASE 1:
        GOTO EV_CARRO_ROTO
      CASE 2:
        GOTO EV_BUEY_PATA
      CASE 3:
        GOTO EV_HIJA_BRAZO
      CASE 4:
        GOTO EV_BUEY_PERDIDO
      CASE 5:
        GOTO EV_HIJO_PERDIDO
      CASE 6:
        GOTO EV_AGUA_INSEGURA
      CASE 7:
        GOTO EV_LLUVIAS
      CASE 8:
        GOTO EV_BANDIDOS
      CASE 9:
        GOTO EV_INCENDIO
      CASE 10:
       GOTO EV_NIEBLA
    END SELECT
  ELSE
    SELECT CASE (D1-10)
      CASE 1:
        GOTO EV_SERPIENTE
      CASE 2: 
        GOTO EV_RIO_ENLODADO
      CASE 3: 
        GOTO EV_ANIMALES_SALVAJES
      CASE 4:
        GOTO EV_FRIO_ROPA
      CASE 5: 
        GOTO EV_GRANIZO
      CASE 6:
        GOTO EV_COMIDA_SALUD
    END SELECT
  END IF

' ---- eventos concretos ----
EV_CARRO_ROTO:
  PRINT
  PRINT "Se rompe la carreta. Pierdes tiempo y"
  PRINT "suministros arreglandola."
  M=M - 15 - 5*RND(0)
  M1=M1 - 8
  GOTO POST_EVENTO

EV_BUEY_PATA:
  PRINT
  PRINT "Un buey se lastima la pata. Te ralentiza"
  PRINT "el resto del viaje."
  M=M-25
  A=A-20
  GOTO POST_EVENTO

EV_HIJA_BRAZO:
  PRINT
  PRINT "Mala suerte. Tu hija se rompio el brazo."
  PRINT "Debes parar y usar suministros para po-"
  PRINT "nerle un cabestrillo."
  M=M - 5 - 4*RND(0)
  M1=M1 - 2 - 3*RND(0)
  GOTO POST_EVENTO

EV_BUEY_PERDIDO:
  PRINT
  PRINT "Un buey se aleja. Pierdes un tiempo"
  PRINT "valioso buscandolo."
  M=M-17
  GOTO POST_EVENTO

EV_HIJO_PERDIDO:
  PRINT
  PRINT "Tu hijo se pierde. Gastas medio dia"
  PRINT "buscandolo."
  M=M-10
  GOTO POST_EVENTO

EV_AGUA_INSEGURA:
  PRINT
  PRINT "El agua no es segura. Pierdes tu tiempo"
  PRINT "buscando un manantial limpio."
  M = M - 10*RND(0) - 2
  GOTO POST_EVENTO

EV_LLUVIAS:
  PRINT
  IF M>950 THEN GOTO EV_FRIO_ROPA
  PRINT "Se producen lluvias intensas."
  PRINT "Pierdes tiempo y suministros."
  F=F-10
  B=B-500
  M1=M1-15
  M=M - 10*RND(0) - 5
  GOTO POST_EVENTO

EV_BANDIDOS:
  PRINT
  PRINT "Bandidos atacan."
  GOSUB SUBRUTINA_DISPARO
  B=B - 20*B1
  IF B < 0 THEN
    PRINT "Te quedaste sin balas. Se llevan mucho"
    PRINT "efectivo."
    T=T/3
  ELSEIF B1 > 1 THEN
    PRINT "Te dispararon en la pierna y se llevaron"
    PRINT "uno de tus bueyes."
    K8=1
    PRINT "Es mejor que un doctor vea tu herida."
    M1=M1-5
    A=A-20
  ELSE
    PRINT "Eres el mas rapido del oeste fuera de"
    PRINT "Dodge City!!!. Los atrapaste!"
  END IF
  GOTO POST_EVENTO

EV_INCENDIO:
  PRINT
  PRINT "Hubo un incendio en tu carreta. Pierdes"
  PRINT "algo de comida y algunos suministros."
  F=F-40
  B=B-400
  M1=M1 - RND(0)*8 - 3
  M=M-15
  GOTO POST_EVENTO

EV_NIEBLA:
  PRINT
  PRINT "Te pierdes en una niebla espesa. Logras"
  PRINT "salir del banco de niebla, pero pierdes"
  PRINT "tiempo."
  M=M - 10 - 5*RND(0)
  GOTO POST_EVENTO

EV_SERPIENTE:
  PRINT
  PRINT "Mataste una serpiente venenosa luego de"
  PRINT "que te mordio."
  B=B-10
  M1=M1-5
  IF M1 < 0 THEN
    PRINT "Mueres por mordedura de serpiente por no"
    PRINT "tener medicina."
    GOTO MUERTE
  END IF
  GOTO POST_EVENTO

EV_RIO_ENLODADO:
  PRINT
  PRINT "La carreta se  empantana al  vadear el"
  PRINT "rio. Pierdes parte de la comida y algo"
  PRINT "de ropa."
  F=F-30
  C=C-20
  M=M - 20 - 20*RND(0)
  GOTO POST_EVENTO

EV_ANIMALES_SALVAJES:
  PRINT
  PRINT "Animales salvajes te atacan!"
  GOSUB SUBRUTINA_DISPARO
  IF B<=39 THEN
    PRINT "Tenias muy pocas balas."
    PRINT "Los lobos te superaron."
    K8=1
    GOTO MUERTE_L2
  END IF
  IF B1<=2 THEN
    PRINT "Buenos disparos, compa. Pero no consi-"
    PRINT "guieron mucho."
  ELSE
    PRINT "Lento para desenfundar. Comieron algo de"
    PRINT "tu comida y rompieron tu ropa."
  END IF
  B = B - 20*B1
  C = C - B1*4
  F = F - B1*8
  GOTO POST_EVENTO

EV_FRIO_ROPA:
  PRINT
  PRINT "El clima es muy frio...  brrrrr..."
  IF C > 22 + 4*RND(0) THEN
    PRINT "Tienes ropa suficiente para mantenerte"
    PRINT "caliente."
    GOTO POST_EVENTO
  ELSE
    PRINT "No tienes ropa suficiente para mante-"
    PRINT "nerte caliente."
    C1=1
    GOTO SUBRUTINA_ENFERMEDAD
  END IF

EV_GRANIZO:
  PRINT
  PRINT "Se produce una tormenta de granizo."
  PRINT "Algunos suministros resultan danados."
  M = M - 5 - RND(0)*10
  B = B - 200
  M1 = M1 - 4 - RND(0)*3
  GOTO POST_EVENTO

EV_COMIDA_SALUD:
  IF E=1 THEN GOTO SUBRUTINA_ENFERMEDAD
  IF E=3 THEN
    IF RND(0) < .5 THEN GOTO SUBRUTINA_ENFERMEDAD
    GOTO POST_EVENTO
  END IF
  IF RND(0) > .25 THEN GOTO SUBRUTINA_ENFERMEDAD
  GOTO POST_EVENTO

INDIOS_AYUDA:
  PRINT
  PRINT "Indigenas amigables te muestran donde"
  PRINT "puedes encontrar mas comida."
  F=F+14
  ' cae a post_evento

POST_EVENTO:
PresionarTecla
PRINT
IF M <= 950 THEN GOTO FECHA_QUINCENA
IF RND(0)*10 <= 9 - ((M/100-15)^2+72)/((M/100-15)^2+12) THEN
  PRINT "Montanas escarpadas."
  IF RND(0) <= .1 THEN
    PRINT "Te perdiste. Pierdes un tiempo valioso"
    PRINT "buscando la ruta."
    M=M-60
  ELSEIF RND(0) <= .11 THEN
    PRINT "La carreta se ha estropeado. Pierdes"
    PRINT "tiempo y suministros."
    M1=M1-5
    B=B-200
    M=M - 20 - 30*RND(0)
  ELSE
    PRINT "El avance se vuelve lento."
    M = M - 45 - RND(0)/.02
  END IF
END IF

IF F1=0 THEN
  F1=1
  IF RND(0) >= .8 THEN 
    PRINT "Pasaste South Pass sin nieve y"
    PRINT "a salvo."
  END IF
END IF

IF M>=1700 AND F2=0 THEN
  F2=1
  IF RND(0) >= .7 THEN GOTO NEVADA_PASO
END IF

IF M>950 THEN GOTO FECHA_QUINCENA
M9=1
GOTO FECHA_QUINCENA

NEVADA_PASO:
  PRINT
  PRINT "Nevada en el paso de montana. Se pierde"
  PRINT "tiempo y suministros."
  L1=1
  F=F-25
  M1=M1-10
  B=B-300
  M=M - 30 - 40*RND(0)
  IF C < 18 + 2*RND(0) THEN GOTO SUBRUTINA_ENFERMEDAD
  GOTO POST_EVENTO ' regresar a flujo normal

'--------------------------------------
' MORIR / GAME OVER
'--------------------------------------
SIN_COMIDA:
  PRINT
  PRINT "Te quedaste sin comida y moriste de"
  PRINT "hambre."
  GOTO MUERTE

SIN_DINERO_MEDICO:
  PRINT
  T=0
  PRINT "No puedes pagar a un doctor."
  GOTO MUERTE_L2

MUERTE_L2:
  PRINT
  PRINT "Te quedaste sin suministros medicos."
  PRINT
  PRINT "Moriste por ";
  IF K8=1 THEN
    PRINT "las heridas."
  ELSE
    PRINT "una neumonia."
  END IF

MUERTE:
  PresionarTecla
  CLS
  Titulo("Q.E.P.D.")
  PRINT
  PRINT "Debido a tu desafortunada situacion, hay"
  PRINT "algunas formalidades que cumplir."
  PRINT "Hay que conseguir un ministro, organizar"
  PRINT "un funeral elegante e informar a tus"
  PRINT "parientes mas cercanos. Seguramente tu"
  PRINT "tia Nellie en ST. Louis esta preocupada"
  PRINT "por esta situacion."
  PRINT

  Titulo("TELEGRAMA:")
  PRINT
  PRINT "Gracias por la informacion y sentimos"
  PRINT "que no hayas logrado llegar al gran"
  PRINT "territorio de Oregon."
  PRINT "Mejor suerte la proxima vez."
  PRINT
  PRINT CENTRAR$("Atentamente,")
  PRINT
  PRINT CENTRAR$("La Camara de Comercio")
  PRINT CENTRAR$("de Oregon City.")
  PresionarTecla
  CLS
  FINAL_DEL_JUEGO


'--------------------------------------
' LLEGADA FINAL
'--------------------------------------
LLEGADA_FINAL:
F9=(2040-M2)/(M-M2)
F=F + (1-F9)*(8+5*E)

Titulo("FELICITACIONES!")

PRINT
PRINT "Por fin llegaste a Oregon City, despues"
PRINT "de 2040 largas millas... hurra!!!"
PRINT

F9=INT(F9*14)
D3=D3*14 + F9
F9=F9+1
IF F9>=8 THEN F9=F9-7

fecha_aux$ = "" 

SELECT CASE F9
  CASE 1:
   fecha_aux$ = "Lunes "
  CASE 2:
   fecha_aux$ = "Martes "
  CASE 3:
   fecha_aux$ = "Miercoles "
  CASE 4:
   fecha_aux$ = "Jueves "
  CASE 5:
   fecha_aux$ = "Viernes "
  CASE 6:
   fecha_aux$ = "Sabado "
  CASE 7:
   fecha_aux$ = "Domingo "
END SELECT

IF D3>124 THEN
  IF D3>155 THEN
    IF D3>185 THEN
      IF D3>216 THEN
        D3=D3-216
        fecha_aux$ = fecha_aux$ + STR$(D3) + " de Noviembre de 1847"
      ELSE
        D3=D3-185
        fecha_aux$ = fecha_aux$ + STR$(D3) + " de Octubre de 1847"
      END IF
    ELSE
      D3=D3-155
      fecha_aux$ = fecha_aux$ + STR$(D3) + " de Septiembre de 1847"
    END IF
  ELSE
    D3=D3-124
    fecha_aux$ = fecha_aux$ + STR$(D3) + " de Agosto de 1847"
  END IF
ELSE
  D3=D3-93
  fecha_aux$ = fecha_aux$ + STR$(D3) + " de Julio de 1847"
END IF

COLOR RGB(white) : 
PRINT STRING$(40,"_")
PRINT 
Titulo(fecha_aux$)
PRINT

PRINT
PRINT "COMIDA  BALAS  ROPA  SUMINISTROS  DINERO"
IF B<0 THEN B=0
IF C<0 THEN C=0
IF M1<0 THEN M1=0
IF T<0 THEN T=0
IF F<0 THEN F=0
PRINT TAB(2);F;
PRINT TAB(9);B;
PRINT TAB(16);C;
PRINT TAB(25);M1;
PRINT TAB(36);"$";T
PRINT
PresionarTecla

Titulo("TELEGRAMA:")
PRINT
PRINT "El presidente James K. Polk te envia"
PRINT CENTER$("sus mas calidas felicitaciones")
PRINT CENTER$("y te desea una vida prospera por")
PRINT CENTER$("delante en tu nuevo hogar.")
PRINT
COLOR RGB(green)
FINAL_DEL_JUEGO


'--------------------------------------
' SUBRUTINAS
'--------------------------------------
ENTRADA_COMPRA:
  INPUT P
  IF P<0 THEN RETURN
  T=T-P
  IF T < 0 THEN
    PRINT "No tienes tanto dinero. Baja el gasto."
    T=T+P
    P=0
  END IF
RETURN

'--------------------------------------
SUBRUTINA_DISPARO:
  PRINT
  PRINT "Escribe BANG y presiona ENTER";
  B2 = 7
  TIMER = 0
  INPUT Cx$
  B1 = TIMER / 1000.0
  PRINT
  IF UCASE$(Cx$) <> "BANG" OR B1 > B2 THEN
    B1 = B2 
  END IF
RETURN

'--------------------------------------
SUBRUTINA_ENFERMEDAD:
  IF 100*RND(0) < 10 + 35*(E-1) THEN
    PRINT "Enfermedad leve. Se usa medicina."
    M=M-5
    M1=M1-2
    GOTO ENF_SALIDA
  END IF

  IF 100*RND(0) < 100 - (40/4^(E-1)) THEN
    PRINT "Enfermedad grave..."
    PRINT "Debes parar para recibir atencion"
    PRINT "medica."
    M1=M1-10
    S4=1
    GOTO ENF_SALIDA
  END IF

  PRINT "Enfermedad mala. Se usa medicina"
  M=M-5
  M1=M1-5

  ENF_SALIDA:
  IF M1<0 THEN GOTO MUERTE_L2
  IF L1=1 THEN
    ' si venimos de nevada en el paso, 
    ' volvemos al flujo alli
    GOTO POST_EVENTO
  ELSE
    GOTO POST_EVENTO
  END IF


'--------------------------------------
FINAL_DEL_JUEGO:
  PRINT: PRINT 
  PRINT "¿INTENTAR OTRA VEZ? (S/N)";
  INPUT a1$
  ValidarSioNo
  IF SiNo = 0 THEN
    RUN "oregontrail.bas"
  ELSE
    END
  END IF


'--------------------------------------
'Helpers
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
    LINE INPUT a1$
    DO WHILE LEN(a1$) = 0 
    LOOP
  LOOP
END SUB

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
  PRINT "Pulsa una tecla para continuar.";
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
  PRINT CENTRAR$(T$)
  COLOR RGB(green)
END SUB