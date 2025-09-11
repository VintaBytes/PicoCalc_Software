# Oregon Trail – Versión PicoCalc (MMBasic, Español)

Este proyecto es una **adaptación al dialecto BASIC de la PicoCalc** del clásico juego educativo **The Oregon Trail**, originalmente creado en **1971** por **Don Rawitsch, Bill Heinemann y Paul Dillenberger** para el Minnesota Educational Computing Consortium (MECC).  
La información histórica y el legado del juego pueden consultarse en [died-of-dysentery.com](https://www.died-of-dysentery.com/index.html).

## Origen del juego
The Oregon Trail fue desarrollado inicialmente como una herramienta educativa para enseñar historia de los pioneros norteamericanos.  
En 1975 el MECC publicó una versión más elaborada, que luego sería ampliamente difundida en escuelas de Estados Unidos durante los años 80 y 90.

El objetivo del juego es **guiar a una familia de colonos desde Missouri hasta Oregón en 1847**, administrando recursos como comida, municiones, ropa y suministros médicos, al tiempo que se enfrentan a enfermedades, accidentes y ataques.

## Adaptación PicoCalc
Esta versión ha sido:
- **Convertida al dialecto MMBasic de PicoCalc** (compatible con sus limitaciones de pantalla de 40 columnas y funciones de cadena).
- **Traducida íntegramente al español**.
- **Ajustada para jugabilidad en terminales pequeñas**, con funciones de centrado de texto y menús claros.
- **Actualizada al año 2025** por el autor.

## Cómo jugar
1. Ejecutar el programa en tu PicoCalc:
   ```basic
   RUN "oregontrail.bas"
   ```

2. Al inicio se te preguntará si necesitas ver las **instrucciones**.
3. Con un presupuesto inicial de \$700 (tras comprar la carreta), deberás decidir cuánto gastar en:

   * **Bueyes**
   * **Comida**
   * **Municiones**
   * **Ropa**
   * **Suministros varios**
     
4. Durante el viaje enfrentarás decisiones como:

   * Parar en fuertes para reabastecerte.
   * Salir a cazar para conseguir comida.
   * Administrar el ritmo de viaje y la alimentación de tu familia.
   * Resolver eventos aleatorios (lluvias, enfermedades, ataques, accidentes).
     
5. El objetivo es **sobrevivir** y lograr que tu familia llegue a Oregon City.

## Controles

* Todas las decisiones se toman escribiendo un número u opción (`S/N`).
* En los eventos de disparo, deberás escribir **`BANG`** lo más rápido posible y presionar **ENTER**.

## Estructura del código

* El programa sigue la lógica de BASIC clásico, con secciones organizadas en:

  * **Compras iniciales**
  * **Turnos quincenales**
  * **Eventos aleatorios**
  * **Subrutinas auxiliares** (centrado de texto, efectos de sonido, disparo, enfermedades).
* Incluye funciones personalizadas para:

  * **`CENTRAR$()`**: alinear texto en 40 columnas.
  * **`Titulo()`**: mostrar títulos destacados.
  * **`PresionarTecla`**: pausa interactiva.
  * **`Beep`**: señal sonora.

## Limitaciones

* No se utilizan tildes ni eñes en pantalla, para mantener compatibilidad con el display de la PicoCalc.
* El juego conserva la lógica original de los 70s, con mecánicas sencillas pero con alta rejugabilidad.

## Créditos

* **Autores originales (1971–1975):** Don Rawitsch, Bill Heinemann, Paul Dillenberger.
* **Versión PicoCalc (2025):** Ariel Palazzesi.

---

¡Disfrutá esta versión retro en tu PicoCalc y reviví uno de los juegos más influyentes en la historia de la informática educativa!

