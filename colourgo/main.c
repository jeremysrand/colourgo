//
//  main.c
//  colourgo
//
//  Created by Jeremy Rand on 2017-07-19.
//  Copyright © 2017 Jeremy Rand. All rights reserved.
//

#include <stdio.h>

#include "game.h"
#include "machine.h"


int main(void)
{
    initMachine();
    game();
    uninitMachine();
    return 0;
}
