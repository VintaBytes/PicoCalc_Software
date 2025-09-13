# Hammurabi – Versión PicoCalc (MMBasic, Español)

Este proyecto es una **adaptación al dialecto BASIC de la PicoCalc** del histórico juego educativo **Hammurabi**, originalmente creado en los años 60 y popularizado en la década de 1970 en máquinas **DEC PDP-8 y PDP-11**, y posteriormente difundido como ejemplo en numerosos libros de BASIC.  

El programa pone al jugador en el papel del rey **Hammurabi de Babilonia** (c. 1800 a.C.), responsable de administrar las tierras, el grano y la población de su reino.  
Con el tiempo, se convirtió en uno de los primeros **juegos de simulación de gestión** y sirvió de inspiración para títulos posteriores dentro del género de estrategia y recursos.

## Origen del juego
Hammurabi (también conocido como *The Sumer Game* o *Hamurabi*) fue diseñado por **Richard Merrill** hacia 1968 como un programa de demostración en FOCAL para minicomputadoras DEC.  
Más tarde fue traducido a BASIC y distribuido ampliamente en escuelas y publicaciones, convirtiéndose en un clásico de la informática educativa de los años 70.

El objetivo del juego es **gobernar con éxito la ciudad durante 10 años**, administrando:
- La cantidad de tierra a comprar o vender.  
- La distribución de grano entre siembra y alimentación de la población.  
- La prevención de hambrunas y revueltas.  

Cada decisión impacta en el bienestar de la ciudad y en tu reputación como gobernante.

## Adaptación PicoCalc
Esta versión ha sido:
- **Convertida al dialecto MMBasic de PicoCalc**, con compatibilidad para pantalla de 40 columnas.  
- **Traducida íntegramente al español**.  
- **Ajustada para una experiencia fluida en terminales pequeñas**.  
- **Actualizada al año 2025** por el autor.  

## Cómo jugar
1. Ejecutar el programa en tu PicoCalc:
   ```basic
   RUN "hammurabi.bas"
   ```

2. El juego avanza en **períodos de un año**. En cada turno deberás decidir:

   * Cuántas tierras comprar o vender.
   * Cuánto grano dedicar a alimentar a la población.
   * Cuánto grano reservar para sembrar en los campos.

3. Factores aleatorios como **cosechas variables, plagas y hambrunas** pondrán a prueba tu estrategia.

4. El juego termina después de 10 años o si tu pueblo perece antes.

## Controles

* Todas las decisiones se ingresan mediante valores numéricos.
* El programa valida las entradas para evitar errores y mantener la coherencia de los recursos.

## Estructura del código

El programa está organizado en bloques que siguen la lógica del BASIC clásico:

* **Presentación inicial**.
* **Bucle anual de decisiones**.
* **Cálculos de cosecha, población y recursos**.
* **Mensajes de estado y fin del juego**.

## Limitaciones

* No se utilizan tildes ni eñes en pantalla para mantener compatibilidad con la PicoCalc.
* La simulación es sencilla, pero refleja fielmente el espíritu del juego original de los 70.

## Créditos

* **Autor original (1968):** Richard Merrill (DEC).
* **Versión PicoCalc (2025):** Ariel Palazzesi.

---

¡Revive en tu PicoCalc uno de los primeros juegos de simulación de la historia de la informática!

