# Oregon Trail – PicoCalc Version (MMBasic, English)

This project is an **adaptation to the PicoCalc BASIC dialect** of the classic educational game **The Oregon Trail**, originally created in **1971** by **Don Rawitsch, Bill Heinemann, and Paul Dillenberger** for the Minnesota Educational Computing Consortium (MECC).  
Historical information and the legacy of the game can be found at [died-of-dysentery.com](https://www.died-of-dysentery.com/index.html).

## Game origin
The Oregon Trail was initially developed as an educational tool to teach the history of American pioneers.  
In 1975 MECC released a more elaborate version, which later became widely used in U.S. schools during the 1980s and 1990s.

The goal of the game is to **guide a family of settlers from Missouri to Oregon in 1847**, managing resources such as food, ammunition, clothing, and medical supplies, while facing diseases, accidents, and attacks.

## PicoCalc adaptation
This version has been:
- **Converted to the PicoCalc MMBasic dialect** (compatible with its 40-column screen limitation and string functions).  
- **Fully translated into Spanish**.  
- **Adjusted for playability on small terminals**, with text-centering functions and clear menus.  
- **Updated to the year 2025** by the author.  

## How to play
1. Run the program on your PicoCalc:
   ```basic
   RUN "oregontrail.bas"
   ```

2. At the beginning you will be asked if you need to see the **instructions**.
   
3. With an initial budget of \$700 (after purchasing the wagon), you must decide how much to spend on:

   * **Oxen**
   * **Food**
   * **Ammunition**
   * **Clothing**
   * **Miscellaneous supplies**
  
4. During the journey you will face decisions such as:

   * Stopping at forts to resupply.
   * Going hunting to obtain food.
   * Managing the pace of travel and your family’s diet.
   * Handling random events (rains, diseases, attacks, accidents).
  
5. The objective is to **survive** and ensure your family reaches Oregon City.

## Controls

* All decisions are made by typing a number or option (`Y/N`).
* In shooting events, you must type **`BANG`** as quickly as possible and press **ENTER**.

## Code structure

* The program follows classic BASIC logic, with sections organized into:

  * **Initial purchases**
  * **Biweekly turns**
  * **Random events**
  * **Auxiliary subroutines** (text centering, sound effects, shooting, diseases).

* It includes custom functions such as:

  * **`CENTRAR$()`**: align text in 40 columns.
  * **`Titulo()`**: display highlighted titles.
  * **`PresionarTecla`**: interactive pause.
  * **`Beep`**: sound signal.

## Limitations

* Changes to maintain compatibility with the PicoCalc display.
* The game retains the original 1970s logic, with simple mechanics but high replayability.

## Credits

* **Original authors (1971–1975):** Don Rawitsch, Bill Heinemann, Paul Dillenberger.
* **PicoCalc version (2025):** Ariel Palazzesi.

---

Enjoy this retro version on your PicoCalc and relive one of the most influential games in the history of educational computing!

