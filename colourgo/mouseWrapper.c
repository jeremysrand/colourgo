//
//  mouseWrapper.c
//  a2bejwld
//
//  Created by Jeremy Rand on 2016-08-17.
//  Copyright © 2016 Jeremy Rand. All rights reserved.
//


#include <conio.h>
#include <stdio.h>
#include <mouse.h>

#include "mouseWrapper.h"
#include "game.h"
#include "vbl.h"
#include "drivers/a2_mouse_drv.h"


// Globals

static bool gMouseInstalled = false;

static struct mouse_callbacks gMouseDrvCallbacks;


bool initMouse(void)
{
    if (!gMouseInstalled) {
        gMouseDrvCallbacks.hide = mouse_def_callbacks.hide;
        // This callback is here for the //c VBL which is only detectable
        // through the mouse interrupt.  By registering this as our "show"
        // function, we can ensure that we get called on our VBL interrupt
        // and can unblock our VBL wait function.
        gMouseDrvCallbacks.show = vblIRQCallback;
        gMouseDrvCallbacks.movex = mouse_def_callbacks.movex;
        gMouseDrvCallbacks.movey = mouse_def_callbacks.movey;
        
        if (mouse_install(&gMouseDrvCallbacks, &a2_mouse_drv) == 0) {
            gMouseInstalled = true;
            
            // This is required to ensure that the show callback is called
            // by the interrupt handler.  This whole thing is a bit of a
            // hack to get the default mouse interrupt handler to do what
            // we want on the //c to detect the VBL but it works for now.
            mouse_show();
        }
    }
    
    return gMouseInstalled;
}
    

void shutdownMouse(void)
{
    if (gMouseInstalled) {
        mouse_uninstall();
        gMouseInstalled = false;
    }
}
