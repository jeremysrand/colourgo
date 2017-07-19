//
//  vbl.h
//  colourgo
//
//  Created by Jeremy Rand on 2017-07-19.
//  Copyright © 2017 Jeremy Rand. All rights reserved.
//

#ifndef __colourgo__vbl__
#define __colourgo__vbl__


// Typedefs

typedef void (*tVblWaitFunction)(void);


// Globals

extern tVblWaitFunction gVblWait;

// API

extern void __fastcall__ vblInit2gs(void);
extern void __fastcall__ vblWait(void);
extern void __fastcall__ vblWaitNon2c(void);
extern void __fastcall__ vblWait2c(void);

extern void __fastcall__ vblIRQCallback(void);


#endif /* defined(__colourgo__vbl__) */
