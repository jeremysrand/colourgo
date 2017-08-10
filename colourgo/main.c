//
//  main.c
//  colourgo
//
//  Created by Jeremy Rand on 2017-07-19.
//  Copyright © 2017 Jeremy Rand. All rights reserved.
//

#include <conio.h>
#include <stdio.h>

#include "game.h"
#include "machine.h"


void splashScreen(void)
{
    clrscr();
    
    printf(
// 0000000000111111111122222222223333333333
// 0123456789012345678901234567890123456789
  "              COLOURGO V1.5\n"               // 00
  "              BY JEREMY RAND\n"              // 01
  "\n"                                          // 02
  "YOU MUST HAVE A COLOUR MONITOR TO PLAY\n"    // 03
  "THIS GAME (I SUPPOSE COLOR MONITORS\n"       // 04
  "FROM THE US WILL WORK TOO).\n"               // 05
  "\n"                                          // 06
  "PRESS Q OR ESCAPE AT ANY TIME TO EXIT\n"     // 07
  "THE GAME\n"                                  // 08
  "\n"                                          // 09
  "YOUR PLAYER RUNS TO THE RUN AT ALL TIMES"    // 10
  "PRESS THE CLOSED APPLE KEY TO JUMP.  YOU"    // 11
  "CAN DOUBLE JUMP ALSO.  ONCE YOUR PLAYER\n"   // 12
  "TOUCHES A FLOOR (EVEN WITH THE HEAD),\n"     // 13
  "YOU CAN DOUBLE JUMP AGAIN.  CHANGE THE\n"    // 14
  "COLOUR OF YOUR PLAYER BY PRESSING ANY\n"     // 15
  "KEY (I SUGGEST SPACE).\n"                    // 16
  "\n"                                          // 17
  "YOUR PLAYER MUST BE THE SAME COLOUR AS\n"    // 18
  "ANY FLOOR YOU TOUCH!!!\n"                    // 19
  "\n"                                          // 20
  "THE SOLID FLOOR IS THE END OF THE LEVEL."    // 21
  "\n"                                          // 22
  "          PRESS ANY KEY TO BEGIN"            // 23
           );
    cgetc();
}


int main(void)
{
    initMachine();
    splashScreen();
    game();
    uninitMachine();
    return 0;
}
